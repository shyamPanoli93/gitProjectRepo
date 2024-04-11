import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_management/production/home/view/productEntry.dart';
import 'package:product_management/service/database.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? productDetailsStream;

  getOnTheload() async {
    productDetailsStream = await DatabaseMethods().getProductionDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheload();
    super.initState();
  }

  Widget allProductionDetails() {
    return StreamBuilder(
      stream: productDetailsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 20, right: 20),
                    child: Material(
                      elevation: 5.0,
                      type: MaterialType.transparency,
                      borderRadius: BorderRadius.circular(10),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(0.8, 1),
                              colors: <Color>[
                                Color(0xFFFEEDFC),
                                Colors.white,
                                Color(0xFFE4E6F7),
                                Color(0xFFE2E5F5),
                              ],
                              tileMode: TileMode.mirror,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                height: 130,
                                width: 130,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(0.8, 1),
                                    colors: <Color>[
                                      Colors.white,
                                      Color(0xFFE4E6F7),
                                      Colors.white,
                                    ],
                                    tileMode: TileMode.mirror,
                                  ),
                                ),
                                child: Center(
                                  child: QrImageView(
                                    data: ds['name'],
                                    version: QrVersions.auto,
                                    size: 100.0,
                                    foregroundColor: const Color(0xFF8194FE),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                toBeginningOfSentenceCase(ds['name']) ?? "",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6565FF),
                                ),
                              ),
                              Text(
                                'Measurement:' + ds['measurement'],
                                style: const TextStyle(
                                    color: Colors.orange,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\u{20B9}${ds['price']}',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductionEntryScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Production',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Manager',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: [
            Expanded(child: allProductionDetails()),
          ],
        ),
      ),
    );
  }
}
