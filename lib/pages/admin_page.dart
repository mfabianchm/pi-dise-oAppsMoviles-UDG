import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:producto_integrador/components/my_button.dart';
import 'package:producto_integrador/models/movie.dart';
import 'package:producto_integrador/pages/my_movies.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final controllerName = TextEditingController();
  final controllerYear = TextEditingController();
  final controllerGenero = TextEditingController();
  final controllerDirector = TextEditingController();
  final controllerSinopsis = TextEditingController();

  Future createMovie(Mov mov) async {
    final docMovie = FirebaseFirestore.instance.collection('Movies').doc();
    mov.id = docMovie.id;
    final json = mov.toJson();
    await docMovie.set(json);
  }

  void goToMyMovies() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyMoviesPage()));
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controllerYear,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Año',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controllerGenero,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Género',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controllerDirector,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Director',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controllerSinopsis,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Sinopsis',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: (() {
                final mov = Mov(
                    name: controllerName.text,
                    year: controllerYear.text,
                    genero: controllerGenero.text,
                    director: controllerDirector.text,
                    sinopsis: controllerSinopsis.text);
                createMovie(mov);
              }),
              child: Text("Agregar")),
          MyButton(
            text: 'Ver mis películas',
            onTap: goToMyMovies,
          ),
        ],
      ),
    );
  }
}

class Mov {
  String id;
  final String? name;
  final String year;
  final String director;
  final String? genero;
  final String sinopsis;

  Mov({
    this.id = '',
    required this.name,
    required this.year,
    required this.director,
    required this.genero,
    required this.sinopsis,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'year': year,
        'director': director,
        'genero': genero,
        'sinopsis': sinopsis,
      };

  static Mov fromJson(Map<String, dynamic> json) => Mov(
        id: json['id'],
        name: json['name'],
        year: json['year'],
        director: json['director'],
        genero: json['genero'],
        sinopsis: json['sinopsis'],
      );
}
