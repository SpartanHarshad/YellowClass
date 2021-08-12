import 'package:flutter/material.dart';
import 'package:movie_app/db/MovieDatabase.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/wigets/AddMoviePage.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late List<Movie> movies;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshMovieList();
  }

  @override
  void dispose() {
    MovieDatabase.dbInstance.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : movies.isEmpty
                    ? Text(
                        'No Movies add yet',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              return movieItem(movie, index);
                            }),
                      ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddMoviePage()),
            );
            refreshMovieList();
          },
        ),
      ],
    );
  }

  Future refreshMovieList() async {
    setState(() => isLoading = true);
    this.movies = await MovieDatabase.dbInstance.showAllMovieDetails();
    setState(() => isLoading = false);
  }

  Widget movieItem(Movie movie, int index) => Expanded(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              movie.movieName,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            subtitle: Text(
              movie.directorName,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            //tileColor: Colors.blue[400],
            trailing: IconButton(
              onPressed: () {
                editMovie(movie, index);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                deleteMovie(index);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );

  void deleteMovie(int index) {}

  void editMovie(Movie movie, int index) {}
}
