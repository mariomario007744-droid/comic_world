import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_world/models/comic_model.dart';
import 'package:comic_world/views/comic_view.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class ComicGrid extends StatefulWidget {
  const ComicGrid({super.key, required this.dataFunc});
  final Future<dynamic> Function() dataFunc;
  @override
  State<ComicGrid> createState() => _ComicGridState();
}

class _ComicGridState extends State<ComicGrid> {
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
        ? Center(
          child: SizedBox(
            height: 150,
            child: const Center(child: CircularProgressIndicator())),
        )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .65,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ComicView(
                          data: data[index],
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kThemeColor,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        data[index].posterUrl,
                      ),
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
                      data[index].name,
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
