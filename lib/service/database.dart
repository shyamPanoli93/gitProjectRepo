import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{
  Future addProductionDetails(Map<String,dynamic>productionInfoMap,String id)async{
    return await FirebaseFirestore.instance.collection('product')
        .doc(id)
        .set(productionInfoMap);
  }
}