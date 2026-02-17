import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_world/const.dart';
import 'package:comic_world/models/comic_part_model.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/pdf_view.dart';
import 'package:flutter/material.dart';

class ChaptersSection extends StatefulWidget {
  const ChaptersSection({
    super.key,
    required this.comicId,
    required this.bannerUrl,
    required this.posterUrl,
  });
  final int comicId;
  final String bannerUrl;
  final String posterUrl;

  @override
  State<ChaptersSection> createState() => _ChaptersSectionState();
}

class _ChaptersSectionState extends State<ChaptersSection> {
  List<ComicPartModel> dataParts = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (mounted) {
      final response = await RequestData().fetchPartComic(
        comicId: widget.comicId,
      );
      for (var element in response) {
        dataParts.add(ComicPartModel.fromJson(element));
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataParts == []
        ?const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الفصول',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataParts.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: kThemeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        'الفصل ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 16,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: kSecondaryBackgroundColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image(
                                      image: CachedNetworkImageProvider(
                                        widget.bannerUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                const  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'شاهد اعلان للمتابعه',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kThemeColor,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ComicPdfView(
                                              pdfUrl: dataParts[index].pdfUrl,
                                              comicId: widget.comicId,
                                            ),
                                          ),
                                        );
                                      },
                                      child:const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                "فتح",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
  }
}
