import 'package:comic_world/views/comic_view.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class ComicGrid extends StatelessWidget {
  const ComicGrid();


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ComicDetailsView();
            }));
          },
          child: Container(
            decoration: BoxDecoration(
              color: kThemeColor,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/SAVE_20251016_224542.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'رؤؤئءؤءؤ ئءؤءؤئؤءرؤرؤء رءؤ',
                style: TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
