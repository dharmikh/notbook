import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

 static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //Insert Data(Notes Data) In Firestote Database in Farebase
  Future<void> InsertData({required String note}) async {
    await firebaseFirestore
        .collection("BookData")
        .add({"note": note, "status": false});
  }

  //Read Data(Notes Data) In Firestote Database in Farebase
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadNotesData() {
    return firebaseFirestore.collection("BookData").snapshots();
  }

  //Delete Data(Notes Data) In Firestote Database in Farebase
  void DeleteData({required String id}) {
    firebaseFirestore.collection("BookData").doc(id).delete();
  }

  //Update Data(Notes Data) In Firestote Database in Farebase
  void UpdateData(
      {required String id, required String note, required bool status}) {
    firebaseFirestore
        .collection("BookData")
        .doc(id)
        .update({"note": note, "status": status});
  }
}
