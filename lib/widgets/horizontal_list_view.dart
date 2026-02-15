import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/views/comic_view.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  const HorizontalListView({super.key, required this.dataFunc});
  final dataFunc;

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  List<ComicModel> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final response = await widget.dataFunc();
    for (var element in response) {
      data.add(ComicModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return data == []
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: 210,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                      await precacheImage(
                        CachedNetworkImageProvider(data[index].bannerUrl),
                        context,
                      );
                      await precacheImage(
                        CachedNetworkImageProvider(data[index].posterUrl),
                        context,
                      );
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ComicView(data: data[index]);
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
                                  image: CachedNetworkImageProvider(data[index].posterUrl),
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
                                      data[index].viewedCount.toString(),
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
                            data[index].name,
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
