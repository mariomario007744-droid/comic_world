import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_world/const.dart';
import 'package:comic_world/models/comic_model.dart';
import 'package:flutter/material.dart';

class ComicBanner extends StatelessWidget {
  const ComicBanner({super.key, required this.data});
  final ComicModel data;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: kBackgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: CachedNetworkImageProvider(data.bannerUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}