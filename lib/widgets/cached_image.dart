import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  CachedImage({super.key, required this.imageUrl, this.radius = 0});

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        imageUrl: imageUrl ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxQCAUz8w1WIRUjYdqTKZDri3wT_fB51KZwjUOVIeIDQ&s',
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
