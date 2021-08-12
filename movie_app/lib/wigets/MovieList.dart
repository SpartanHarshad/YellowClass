import 'package:flutter/material.dart';
import 'package:movie_app/db/MovieDatabase.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/wigets/AddMoviePage.dart';
import 'package:movie_app/wigets/EditMoviePage.dart';

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
            subtitle: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Expanded(
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(movie.posterImgUrl),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            movie.movieName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            movie.directorName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(
                            onPressed: () {
                              editMovie(movie, index);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(
                            onPressed: () {
                              deleteMovie(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //tileColor: Colors.blue[400],
          ),
        ),
      );

  Future deleteMovie(int index) async {
    setState(() async {
      await MovieDatabase.dbInstance.deleteMovieDetails(index);
      this.movies = await MovieDatabase.dbInstance.showAllMovieDetails();
    });
    //refreshMovieList();
  }

  void editMovie(Movie movie, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMoviePage(),
        settings: RouteSettings(
          arguments: movie,
        ),
      ),
    );
  }
}
