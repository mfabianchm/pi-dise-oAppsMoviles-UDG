import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get all movies

  final CollectionReference movies =
      FirebaseFirestore.instance.collection('movies');

  //create movie
  Future<void> addMovie(
      String name, Int year, String director, String genero, String sinopsis) {
    return movies.add({
      'name': name,
      'year': year,
      'director': director,
      'genero': genero,
      'sinopsis': sinopsis,
    });
  }

  //get movies

  //update movies

  //delete movies

  Future<void> deleteMovie(String docID) {
    return movies.doc(docID).delete();
  }
}
