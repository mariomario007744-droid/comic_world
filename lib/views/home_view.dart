import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      _SectionTitle(title: 'الأكثر مشاهدة'),
                      const SizedBox(height: 12),
                      MostViewedList(),
                      const SizedBox(height: 24),
                      _SectionTitle(title: 'كوميك جديدة'),
                      const SizedBox(height: 12),
                      _ComicGrid(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomHomeAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff201E2C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // ☰ MENU
          IconButton(
            icon: Icon(Icons.menu, color: kTextColor),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kThemeColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const _MenuSheet(),
              );
            },
          ),

          // SEARCH FIELD
          Expanded(
            child: TextField(
              style: TextStyle(color: kTextColor),
              decoration: InputDecoration(
                hintText: 'ابحث عن كوميك...',
                hintStyle: TextStyle(color: kTextColor.withValues(alpha: 0.5)),
                border: InputBorder.none,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, color: kTextColor),
          ),
        ],
      ),
    );
  }
}

class _MenuSheet extends StatelessWidget {
  const _MenuSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MenuItem(icon: Icons.favorite, text: 'المفضلة'),
          _MenuItem(icon: Icons.category, text: 'التصنيفات'),
          _MenuItem(icon: Icons.history, text: 'آخر المشاهدة'),
          _MenuItem(icon: Icons.settings, text: 'الإعدادات'),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MenuItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kThemeColor),
      title: Text(text, style: TextStyle(color: kTextColor)),
      onTap: () {},
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kThemeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('عرض الكل', style: TextStyle(color: kTextColor)),
        ),
      ],
    );
  }
}

class _ComicGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: kThemeColor,
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/SAVE_20251016_224542.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius:  BorderRadius.circular(12),
            ),
            child: const Text(
              'اسم الكوميك',
              style: TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}


class MostViewedList extends StatelessWidget {
  const MostViewedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // IMAGE
                    Container(
                      height: 150,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/SAVE_20251016_224542.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // VIEWS
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
                          children: const [
                            Icon(
                              Icons.remove_red_eye,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '2.3K',
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

                // TITLE
                SizedBox(
                  width: 110,
                  child: const Text(
                    'اسم الكوميك',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}