import 'package:comic_world/models/comic_model.dart';
import 'package:flutter/material.dart';

class ComicInfo extends StatelessWidget {
  const ComicInfo({required this.data});
  final ComicModel data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'النوع: أكشن • فانتازيا',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text('الشركة المنتجة: ', style: TextStyle(color: Colors.white70)),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
              ),
              child: Text(
                data.productionCompany,
                style: TextStyle(color: Colors.white70),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
