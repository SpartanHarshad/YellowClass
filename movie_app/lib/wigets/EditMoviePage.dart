import 'package:flutter/material.dart';
import 'package:movie_app/db/MovieDatabase.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/wigets/HomePage.dart';

class EditMoviePage extends StatefulWidget {
  const EditMoviePage({Key? key}) : super(key: key);

  @override
  _EditMoviePageState createState() => _EditMoviePageState();
}

class _EditMoviePageState extends State<EditMoviePage> {
  late String movieName;
  late String movieDirectorName;
  late String posterImg;

  @override
  Widget build(BuildContext context) {
    var movieModel = ModalRoute.of(context)!.settings.arguments as Movie;
     movieName = movieModel.movieName;
     movieDirectorName = movieModel.directorName;
     posterImg = movieModel.posterImgUrl;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Edit Movie Details',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal),
              ),
            ),
            nameTextFieldItem(),
            directorTextFieldItem(),
            imgTextFieldItem(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  updateMovie(movieName, movieDirectorName, posterImg);
                },
                child: Text("Update"),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameTextFieldItem() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        subtitle: TextField(
          decoration: InputDecoration(
            labelText: 'Movie Name',
            border: OutlineInputBorder(),
            hintText: 'Enter Movie Name',
            fillColor: Colors.black,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSubmitted: (String value) => movieName = value,
        ),
      ),
    );
  }

  Widget directorTextFieldItem() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        subtitle: TextField(
          decoration: InputDecoration(
            labelText: 'Director Name',
            border: OutlineInputBorder(),
            hintText: 'Enter Movie Director Name',
            fillColor: Colors.black,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSubmitted: (String value) => movieDirectorName = value,
        ),
      ),
    );
  }

  Widget imgTextFieldItem() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        subtitle: TextField(
          decoration: InputDecoration(
            labelText: 'poster image',
            border: OutlineInputBorder(),
            hintText: 'Enter Movie poster image url',
            fillColor: Colors.black,
        
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSubmitted: (String value) => posterImg = value,
        ),
      ),
    );
  }

  Future updateMovie(String name, String director, String img) async {
    final movie =
        Movie(movieName: name, directorName: director, posterImgUrl: img);
    await MovieDatabase.dbInstance.editMovieDetails(movie);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new HomePage()));
  }
}
