import 'package:comic_world/const.dart';
import 'package:comic_world/widgets/comic_grid.dart';
import 'package:flutter/material.dart';

class ComicGridView extends StatelessWidget {
  const ComicGridView({super.key, required this.dataFunc,required this.title});
  final Future<dynamic> Function() dataFunc;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(color: kTextColor, fontSize: 32),
                  ),
                ),
                const SizedBox(height: 24),

                Expanded(child: ComicGrid(dataFunc: dataFunc)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
