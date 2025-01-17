import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String name;
  final String description;
  final int year;
  final double ratings;
  final String posterUrl;

  Movie({
    required this.id,
    required this.name,
    required this.description,
    required this.year,
    required this.ratings,
    required this.posterUrl,
  });

  factory Movie.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Movie(
      id: snapshot.id,
      name: data?['name'] ?? '',
      description: data?['description'] ?? '',
      year: data?['year'] ?? 0,
      ratings: (data?['ratings'] ?? 0).toDouble(),
      posterUrl: data?['posterUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'year': year,
      'ratings': ratings,
      'posterUrl': posterUrl,
    };
  }
}
