import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tv_show.dart';

class ViewTVShows extends StatelessWidget {
  const ViewTVShows({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tvShows').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No TV shows available'));
          }
          final tvShows = snapshot.data!.docs.map((doc) => TVShow.fromFirestore(doc)).toList();
          return ListView.builder(
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              final tvShow = tvShows[index];
              return ListTile(
                leading: tvShow.backdropPath.isNotEmpty
                    ? Image.network(tvShow.backdropPath, width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.tv, size: 50, color: Colors.deepPurple),
                title: Text(tvShow.name),
                subtitle: Text(tvShow.overview),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(tvShow.name),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (tvShow.backdropPath.isNotEmpty)
                              Center(
                                child: Image.network(
                                  tvShow.backdropPath,
                                  width: 200,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 10),
                            Text('Overview: ${tvShow.overview}'),
                            const SizedBox(height: 5),
                            Text('Popularity: ${tvShow.popularity}'),
                            const SizedBox(height: 5),
                            Text('Tv Show Category: ${tvShow.type}'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
