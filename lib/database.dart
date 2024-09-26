import 'package:cloud_firestore/cloud_firestore.dart';
class database {
  Future addemployee(Map<String, dynamic>employeemapid, String id) async
  {
    return await FirebaseFirestore.instance.collection('Employee').doc(id).set(
        employeemapid);
  }

  Future<Stream<QuerySnapshot>> getemployeedetails() async {
    return await FirebaseFirestore.instance.collection('Employee').snapshots();
  }

  Future updatedetails(String id, Map<String, dynamic> Updateinfo) async {
    return await FirebaseFirestore.instance.collection('Employee')
        .doc(id)
        .update(Updateinfo);
  }

  Future deletedetails(String id) async {
    return await FirebaseFirestore.instance.collection('Employee').doc(id).delete();
  }
}