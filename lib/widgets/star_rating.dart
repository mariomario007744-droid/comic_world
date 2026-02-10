import 'package:comic_world/requests/request_data.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  const StarRating({super.key, required this.comicId});
  final int comicId;
  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int selectedRating = 0;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            int tempRating = selectedRating;
            return Dialog(
              backgroundColor: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'قيم الكوميك',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            int starIndex = index + 1;
                            return IconButton(
                              icon: Icon(
                                size: 32,
                                tempRating >= starIndex
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setStateDialog(() {
                                  tempRating = starIndex;
                                });
                              },
                            );
                          }),
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Center(
                                  child: const CircularProgressIndicator(
                                    color: Colors.white70,
                                  ),
                                );
                              },
                            );
                            setState(() {
                              selectedRating =
                                  tempRating; // تحديث الـ state الرئيسي
                                  RequestData().evaluationComic(evaluation: selectedRating, comicId: widget.comicId);
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('تقييم'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.star_border, color: Colors.white70),
    );
  }
}
