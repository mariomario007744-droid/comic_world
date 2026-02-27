import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/widgets/comic_grid.dart';
import 'package:comic_world/widgets/horizontal_list_view.dart';
import 'package:comic_world/widgets/section_title.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 120,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  SectionTitle(
                    title: 'الأكثر مشاهدة',
                    request:() => RequestData().fetchMostViewedComic(limit: 20),
                  ),
                  const SizedBox(height: 12),
                  HorizontalListView(
                    dataFunc:() => RequestData().fetchMostViewedComic(limit: 10),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  SizedBox(height: 24),
                    SectionTitle(
                      title: 'كوميك جديدة',
                      request:() => RequestData().fetchNewComic(limit: 20),
                    ),
                    const SizedBox(height: 12),
                    ComicGrid(dataFunc:() => RequestData().fetchNewComic(limit: 10)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const  SizedBox(height: 24),
                  SectionTitle(
                    title: 'DC',
                    request:() => RequestData().fetchMostViewedCompanyComic(
                      company: 'DC Comics',
                      limit: 20,
                    ),
                  ),
                const  SizedBox(height: 12),
                  HorizontalListView(
                    dataFunc:() => RequestData().fetchMostViewedCompanyComic(
                      company: 'DC Comics',
                      limit: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  SectionTitle(
                    title: 'Marvel',
                    request:() => RequestData().fetchMostViewedCompanyComic(
                      company: 'Marvel',
                      limit: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  HorizontalListView(
                    dataFunc:() => RequestData().fetchMostViewedCompanyComic(
                      company: 'Marvel',
                      limit: 10,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
