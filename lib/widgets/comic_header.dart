import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/widgets/custome_favorite_widget.dart';
import 'package:flutter/material.dart';

class ComicHeader extends StatelessWidget {
  const ComicHeader({super.key, required this.data});
  final ComicModel data;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 170,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: DecorationImage(
              image: CachedNetworkImageProvider(data.posterUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "${data.publishYear} • ${data.isCompleted ? 'مكتمل' : 'غير مكتمل'} • ${data.ageRating}+",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text(data.evaluation.toString(), style: TextStyle(color: Colors.white)),

                  SizedBox(width: 12),

                  Icon(Icons.remove_red_eye, color: Colors.white70, size: 18),
                  SizedBox(width: 4),
                  Text(data.viewedCount.toString(), style: TextStyle(color: Colors.white70)),
                  SizedBox(width: 12),
                  CustomeFavoriteWidget(id: data.id),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

