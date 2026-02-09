import 'package:comic_world/views/comic_view.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ComicDetailsView();
                    },
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // IMAGE
                      Container(
                        height: 180,
                        width: 132,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/SAVE_20251016_224542.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 14,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '1000',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  SizedBox(
                    width: 110,
                    child: Text(
                      'name',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
