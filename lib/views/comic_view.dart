import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class ComicDetailsView extends StatelessWidget {
  const ComicDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: CustomScrollView(
          slivers: [
            ComicBanner(),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComicHeader(),
                    const SizedBox(height: 16),
                    WarningBox(),
                    const SizedBox(height: 16),
                    ActionButtons(),
                    const SizedBox(height: 24),
                    ComicDescription(),
                    const SizedBox(height: 24),
                    ComicInfo(),
                    SizedBox(height: 24),
                    ChaptersSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ComicBanner extends StatelessWidget {
  const ComicBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: kBackgroundColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/a57605846861da5e6c9762a66a29dc74.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class ComicHeader extends StatelessWidget {
  const ComicHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// البوستر
        Container(
          height: 170,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/images/SAVE_20251016_224542.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'اسم الكوميك',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                '2024 • مكتمل • +16',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 12),

              /// التقييم والمشاهدات
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 18),
                  SizedBox(width: 4),
                  Text('9.2', style: TextStyle(color: Colors.white)),

                  SizedBox(width: 12),

                  Icon(Icons.remove_red_eye,
                      color: Colors.white70, size: 18),
                  SizedBox(width: 4),
                  Text('1.2M', style: TextStyle(color: Colors.white70)),
                  SizedBox(width: 12),
                  Icon(Icons.favorite_border, color: Colors.white),
                  SizedBox(width: 8),
                  ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class WarningBox extends StatelessWidget {
  const WarningBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'تحذير: يحتوي هذا الكوميك على عنف أو محتوى غير مناسب.',
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}



class ActionButtons extends StatelessWidget {
  const ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kThemeColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {},
            icon: const Icon(Icons.menu_book),
            label: const Text('ابدأ القراءة'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ComicDescription extends StatelessWidget {
  const ComicDescription();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'هنا يوضع وصف الكوميك بشكل مختصر وجذاب بدون حرق أحداث...',
      style: TextStyle(color: Colors.white70, height: 1.6),
    );
  }
}



class ComicInfo extends StatelessWidget {
  const ComicInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('النوع: أكشن • فانتازيا',
            style: TextStyle(color: Colors.white70)),
        SizedBox(height: 6),
        Text('الشركة المنتجة: Comic Studio',
            style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}


class ChaptersSection extends StatelessWidget {
  const ChaptersSection();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          itemCount: 15,
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
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // فتح صفحة القراءة
                },
              ),
            );
          },
        ),
      ],
    );
  }
}