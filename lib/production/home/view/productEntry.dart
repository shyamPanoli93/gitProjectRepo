import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../../../common/common_style.dart';
import '../../../common/widget.dart';

class ProductionEntryScreen extends StatefulWidget {
  const ProductionEntryScreen({super.key});

  @override
  State<ProductionEntryScreen> createState() => _ProductionEntryScreenState();
}

class _ProductionEntryScreenState extends State<ProductionEntryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController measurementController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Form',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 32, end: 32, top: 16, bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*  const Text("Product Name", style: TextStyle(fontSize: 20)),*/
                const SizedBox(
                  height: 6,
                ),
                /*TextFormField(
                controller: nameController,
                style: const TextStyle(fontSize: 12, color: Color(0xFF081731)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    enabledBorder: requestFormBorder,
                    focusedBorder: requestFormBorder,
                    filled: true,
                    fillColor: const Color(0xffEEF2F9)),
              ),*/
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: CommonStyle.textFieldStyle(labelTextStr:"ProductName",hintTextStr:"Enter ProductName"),
                ),

                TextFormField(
                  controller: measurementController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: CommonStyle.textFieldStyle(labelTextStr:"Measurement",hintTextStr:"Enter Measurement"),
                ),
                /* const Text("Measurement", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: measurementController,
                style: const TextStyle(fontSize: 12, color: Color(0xFF081731)),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    enabledBorder: requestFormBorder,
                    focusedBorder: requestFormBorder,
                    filled: true,
                    fillColor: const Color(0xffEEF2F9)),
              ),*/


                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: CommonStyle.textFieldStyle(labelTextStr:"Price",hintTextStr:"Enter Price"),
                ),
                /* const Text("Price", style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: priceController,
                style: const TextStyle(fontSize: 12, color: Color(0xFF081731)),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: requestFormBorder,
                    focusedBorder: requestFormBorder,
                    filled: true,
                    fillColor: const Color(0xffEEF2F9)),
              ),*/

                fullWidthPrimaryButton(context, () {
                  String Id = randomAlphaNumeric(10);
                  CollectionReference productionInfoMap =
                  FirebaseFirestore.instance.collection('product');
                  productionInfoMap.add({
                    "name": nameController.text,
                    "measurement": measurementController.text,
                    "id": Id,
                    "price": priceController.text,
                  }).then(
                        (value) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBarWhenSuccess());
                      Navigator.pop(context);
                    },
                  );
                }, 'Add'),
              ],
            ),
          ),
      ),
    );
  }
}
