import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/widgets/action_buttons.dart';
import 'package:comic_world/widgets/chapters_section.dart';
import 'package:comic_world/widgets/comic_banner.dart';
import 'package:comic_world/widgets/comic_description.dart';
import 'package:comic_world/widgets/comic_header.dart';
import 'package:comic_world/widgets/comic_info.dart';
import 'package:comic_world/widgets/warning_box.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class ComicView extends StatelessWidget {
  const ComicView({super.key, required this.data});
  final ComicModel data;

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: CustomScrollView(
          slivers: [
            ComicBanner(data: data),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComicHeader(data: data),
                    const SizedBox(height: 16),
                    if (data.warning != '') WarningBox(warning: data.warning),
                    const SizedBox(height: 16),
                    ActionButtons(comicId: data.id),
                    const SizedBox(height: 24),
                    ComicDescription(description: data.description),
                    const SizedBox(height: 24),
                    ComicInfo(data: data),
                    const  SizedBox(height: 24),
                    ChaptersSection(comicId: data.id, bannerUrl: data.bannerUrl, posterUrl: data.posterUrl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
