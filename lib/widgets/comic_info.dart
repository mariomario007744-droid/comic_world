import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/comic_grid_view.dart';
import 'package:comic_world/widgets/comic_category.dart';
import 'package:flutter/material.dart';

class ComicInfo extends StatelessWidget {
  const ComicInfo({super.key, required this.data});
  final ComicModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const  Text('النوع: ', style: TextStyle(color: Colors.white70)),
      const  SizedBox(height: 6),
        ComicCategory(data: data),
        const SizedBox(height: 6),
        Row(
          children: [
          const  Text('الشركة المنتجة: ', style: TextStyle(color: Colors.white70)),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
              ),
              child: Text(
                data.productionCompany,
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComicGridView(
                      dataFunc:()=> RequestData().fetchMostViewedCompanyComic(
                        company: data.productionCompany,
                        limit: 40,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

