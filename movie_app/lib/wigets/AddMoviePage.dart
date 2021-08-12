import 'package:flutter/material.dart';
import 'package:movie_app/db/MovieDatabase.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/wigets/HomePage.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  _AddMoviePageState createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  late String movieName;
  late String movieDirectorName;
  late String posterImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Add Movie Details',
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
                  saveMovie(movieName, movieDirectorName, posterImg);
                },
                child: Text("Save"),
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
            labelText: 'Movie Director',
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
            labelText: 'Movie poster image url',
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
          onSubmitted: (String value) =>  posterImg= value,
        ),
      ),
    );
  }

  Future saveMovie(String name, String director, String img) async {
    final movie =
        Movie(movieName: name, directorName: director, posterImgUrl: img);
    await MovieDatabase.dbInstance.saveMovie(movie);
    Navigator.push(context, new MaterialPageRoute(
   builder: (context) => new HomePage())
 );
  }
  
}
