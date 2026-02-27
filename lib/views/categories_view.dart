import 'package:comic_world/const.dart';
import 'package:comic_world/models/category_model.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/comic_grid_view.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<CategoryModel> data = [];
  @override
  void initState() {
    super.initState();
    getCategory();
  }

  getCategory() async {
    final request = await RequestData().featchCategorys();
    for (var element in request) {
      data.add(CategoryModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: data.isEmpty
              ? Center(child: CircularProgressIndicator(color: kTextColor))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'التصنيفات',
                        style: TextStyle(color: kTextColor, fontSize: 32),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kThemeColor,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24,
                                  ),
                                  child: Text(
                                    data[index].nameAr,
                                    style: TextStyle(color: kTextColor),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ComicGridView(
                                        title: 'التصنيفات',
                                        dataFunc: () => RequestData()
                                            .fetchThisCategoryComic(
                                              category: data[index].nameAr,
                                              limit: 50,
                                            ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
