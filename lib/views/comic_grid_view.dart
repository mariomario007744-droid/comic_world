import 'package:comic_world/const.dart';
import 'package:comic_world/widgets/comic_grid.dart';
import 'package:comic_world/widgets/custom_home_app_bar.dart';
import 'package:flutter/material.dart';

class ComicGridView extends StatelessWidget {
  const ComicGridView({super.key, required this.dataFunc});
  final dataFunc;
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
                CustomHomeAppBar(),
                SizedBox(height: 24),

                Expanded(child: ComicGrid(dataFunc: dataFunc)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
