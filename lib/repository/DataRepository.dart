import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mitsumori/models/Quote.dart';

class DataRepository {
  // 1
  final CollectionReference collection = FirebaseFirestore.instance.collection('quotes');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<void> addQuote(Quote q,onSuccessCB, onErrorCB) {
    return collection.add(q.toJson())
        .then((value) {
                print("Quote Added: $value");
                onSuccessCB();
              }
        )
        .catchError((error){
          print("Failed to add quote: $error");
          onErrorCB();
        });
  }
  // 4
  /*updateQuote(Quote q) async {
    await collection.doc(q.reference.id).update(q.toJson())
        .then((value) => print("quote updated"))
        .catchError((error) => print("Failed to upda: $error"));
    //await collection.document(q.reference.).updateData(q.toJson());
  }*/
}
