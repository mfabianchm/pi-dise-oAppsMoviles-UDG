import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:producto_integrador/read%20data/get_movie_name.dart';

class MyMoviesPage extends StatefulWidget {
  const MyMoviesPage({super.key});

  @override
  State<MyMoviesPage> createState() => _MyMoviesPageState();
}

class _MyMoviesPageState extends State<MyMoviesPage> {
  // document IDs
  List<String> docIds = [];

  // get moviesIds
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Movies')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: Text('Gestor de películas'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: ((context, snapshot) {
                      return ListView.builder(
                          itemCount: docIds.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: GetMovieName(documentId: docIds[index]),
                                tileColor: Colors.grey[200],
                              ),
                            );
                          }));
                    })))
          ],
        ),
      ),
    );
  }
}
