import 'package:comic_world/widgets/comic_grid.dart';
import 'package:comic_world/widgets/custom_home_app_bar.dart';
import 'package:comic_world/widgets/most_viewed_list.dart';
import 'package:comic_world/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomHomeAppBar(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      SectionTitle(title: 'الأكثر مشاهدة'),
                      SizedBox(height: 12),
                      HorizontalListView(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      SectionTitle(title: 'كوميك جديدة'),
                      SizedBox(height: 12),
                      ComicGrid(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      SectionTitle(title: 'DC'),
                      SizedBox(height: 12),
                      HorizontalListView(),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      SectionTitle(title: 'Marvel'),
                      SizedBox(height: 12),
                      HorizontalListView(),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}