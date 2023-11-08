import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:producto_integrador/api/api.dart';
import 'package:producto_integrador/components/my_button.dart';
import 'package:producto_integrador/pages/admin_page.dart';
import 'package:producto_integrador/widgets/movies_slider.dart';
import 'package:producto_integrador/widgets/trending_slider.dart';
import 'package:producto_integrador/models/movie.dart';
import 'package:producto_integrador/api/api.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToAdminPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminPage()));
  }

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: Text('Movie App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenido: ${user.email}",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'Películas Trending',
                  style: GoogleFonts.aBeeZee(fontSize: 25),
                ),
                const SizedBox(height: 32),
                SizedBox(
                    child: FutureBuilder(
                        future: trendingMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return TrendingSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),
                const SizedBox(height: 32),
                Text('Películas con mejor calificación',
                    style: GoogleFonts.aBeeZee(fontSize: 25)),
                const SizedBox(height: 32),
                SizedBox(
                    child: FutureBuilder(
                        future: topRatedMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return MoviesSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),
                const SizedBox(height: 32),
                Text('Próximamente', style: GoogleFonts.aBeeZee(fontSize: 25)),
                const SizedBox(height: 32),
                SizedBox(
                    child: FutureBuilder(
                        future: upcomingMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return MoviesSlider(
                              snapshot: snapshot,
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        })),
                const SizedBox(height: 32),
                MyButton(
                  text: 'Administrar películas',
                  onTap: goToAdminPage,
                ),
              ],
            ),
          )),
    );
  }
}
