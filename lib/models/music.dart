import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String genre;
  final String image;
  final int releaseYear;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.genre,
    required this.image,
    required this.releaseYear,
  });

  factory Music.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Music(
      id: snapshot.id,
      title: data?['title'] ?? '',
      artist: data?['artist'] ?? '',
      album: data?['album'] ?? '',
      genre: data?['genre'] ?? '',
      image: data?['image'] ?? '',
      releaseYear: (data?['releaseYear'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'artist': artist,
      'album': album,
      'genre': genre,
      'image': image,
      'releaseYear': releaseYear,
    };
  }
}