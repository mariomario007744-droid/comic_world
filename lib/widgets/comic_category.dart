import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/comic_grid_view.dart';
import 'package:flutter/material.dart';

class ComicCategory extends StatefulWidget {
  const ComicCategory({required this.data});
  final ComicModel data;

  @override
  State<ComicCategory> createState() => _ComicCategoryState();
}

class _ComicCategoryState extends State<ComicCategory> {
  List<String> category = [];
  @override
  void initState() {
    super.initState();
    getCategory();
  }

  getCategory() async {
    final data = await RequestData().fetchCategoryComic(
      comicId: widget.data.id,
    );
    setState(() {
      for (var element in data) {
        category.add(element['type']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: category.map((categoryName) {
        return ElevatedButton(
          style: TextButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComicGridView(
                  dataFunc: RequestData().fetchThisCategoryComic(
                    category: categoryName,
                    limit: 40,
                  ),
                ),
              ),
            );
          },
          child: Text(categoryName,style: TextStyle(color: Colors.white70),
),
        );
      }).toList(),
    );
  }
}
