import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/widgets/comic_grid.dart';
import 'package:comic_world/widgets/custom_home_app_bar.dart';
import 'package:comic_world/widgets/horizontal_list_view.dart';
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomHomeAppBar(),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24),
                            SectionTitle(title: 'الأكثر مشاهدة',request:RequestData().fetchMostViewedComic(limit: 20),),
                            SizedBox(height: 12),
                            HorizontalListView(
                              dataFunc: RequestData().fetchMostViewedComic(limit: 10),
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
                            SizedBox(height: 24),
                            SectionTitle(title: 'كوميك جديدة',request: RequestData().fetchNewComic(limit: 20),),
                            SizedBox(height: 12),
                            ComicGrid(dataFunc: RequestData().fetchNewComic(limit: 10)),
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
                            SizedBox(height: 24),
                            SectionTitle(title: 'DC',request: RequestData().fetchMostViewedCompanyComic(company: 'DC Comics',limit: 20),),
                            SizedBox(height: 12),
                            HorizontalListView(
                              dataFunc: RequestData()
                                  .fetchMostViewedCompanyComic(
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
                            SizedBox(height: 24),
                            SectionTitle(title: 'Marvel',request: RequestData().fetchMostViewedCompanyComic(company: 'Marvel',limit: 20),),
                            SizedBox(height: 12),
                            HorizontalListView(
                              dataFunc: RequestData()
                                  .fetchMostViewedCompanyComic(
                                    company: 'Marvel',
                                    limit: 10,
                                  ),
                            ),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
