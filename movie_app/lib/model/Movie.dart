final String tableMoview = 'movies';

class MoviewFields {
  static final List<String> values = [
    //displaying all fields
    id,movieName,directorName,posterImgUrl
  ];
  static final String id = '_id';
  static final String movieName = 'movieName';
  static final String directorName = 'directorName';
  static final String posterImgUrl = 'posterImgUrl';
}

class Movie {
  final int? id;
  final String movieName;
  final String directorName;
  final String posterImgUrl;
  Movie({
    this.id,
    required this.movieName,
    required this.directorName,
    required this.posterImgUrl,
  });

  Map<String, Object?> toJson() => {
        MoviewFields.id: id,
        MoviewFields.movieName: movieName,
        MoviewFields.directorName: directorName,
        MoviewFields.posterImgUrl: posterImgUrl,
      };

  static Movie fromJson(Map<String, Object?> json) => Movie(
        id: json[MoviewFields.id] as int?,
        movieName: json[MoviewFields.movieName] as String,
        directorName: json[MoviewFields.directorName] as String,
        posterImgUrl: json[MoviewFields.posterImgUrl] as String,
      );

  Movie copy({
    int? id,
    String? movieName,
    String? directorName,
    String? posterImgUrl,
  }) =>
      Movie(
        id: id ?? this.id,
        movieName: movieName ?? this.movieName,
        directorName: directorName ?? this.directorName,
        posterImgUrl: posterImgUrl ?? this.posterImgUrl,
      );
}
