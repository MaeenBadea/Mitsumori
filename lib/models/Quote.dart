import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Quote{
  String quote;
  String author;
  String category;

  DocumentReference reference;

  Quote(this.quote, this.author, this.category);

  factory Quote.fromJson(Map<String, dynamic> json) => _quoteFromJson(json);
  factory Quote.fromSnapShot(QueryDocumentSnapshot snapshot){
    Quote q = Quote.fromJson(snapshot.data());
    q.reference = snapshot.reference;
    return q;
  }
  Map<String,dynamic> toJson() => _quoteToJson(this);

  @override
  String toString() => "Quote: <$quote>";

}
Quote _quoteFromJson(Map<String, dynamic> json){
  return Quote(json['quote'], json['author'],json['category']);
}

_quoteToJson(Quote instance){
  return <String , dynamic>{
    'quote': instance.quote,
    'author': instance.author,
    'category':instance.category
  };
}

