import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:producto_integrador/services/firestore.dart';

class GetMovieName extends StatelessWidget {
  final String documentId;

  GetMovieName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference movies =
        FirebaseFirestore.instance.collection('Movies');

    return FutureBuilder<DocumentSnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
              title: Text('${data['name']},' +
                  ' ' +
                  '${data['genero']},' +
                  ' ' +
                  '${data['year']}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                    onPressed: () {
                      final docMovie = FirebaseFirestore.instance
                          .collection('Movies')
                          .doc(documentId);
                      docMovie.delete();
                    },
                    icon: const Icon(Icons.delete))
              ]));
        }
        return Text('cargando..');
      }),
      future: movies.doc(documentId).get(),
    );
  }
}
