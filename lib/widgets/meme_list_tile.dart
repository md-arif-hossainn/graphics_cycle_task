import 'package:flutter/material.dart';

import '../models/meme.dart';
import '../screens/meme_detail_screen.dart';

import 'package:shimmer/shimmer.dart';

class MemeGridTile extends StatelessWidget {
  final Meme meme;

  const MemeGridTile({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MemeDetailScreen(meme: meme)),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                child: FancyShimmerImage(memeUrl: meme.url),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meme.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FancyShimmerImage extends StatelessWidget {
  final String memeUrl;

  const FancyShimmerImage({super.key, required this.memeUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(memeUrl), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(
            memeUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300],
            ),
          );
        }
      },
    );
  }
}


