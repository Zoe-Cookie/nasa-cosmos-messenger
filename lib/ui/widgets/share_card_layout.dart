import 'package:flutter/material.dart';
import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';

class ShareCardLayout extends StatelessWidget {
  final ApodModel apod;

  const ShareCardLayout({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              apod.mediaType == 'video' ? apod.thumbnailUrl! : apod.url,
              fit: BoxFit.cover,
            ),
            
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apod.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    apod.date.replaceAll('-', ' . '),
                    style: TextStyle(
                      color: Colors.blueAccent[100],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '來自 Nova Space Messenger',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Icon(Icons.rocket_launch, color: Colors.blueAccent[100], size: 20),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}