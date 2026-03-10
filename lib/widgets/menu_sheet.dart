import 'package:comic_world/const.dart';
import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/categories_view.dart';
import 'package:comic_world/views/comic_grid_view.dart';
import 'package:comic_world/views/login_view.dart';
import 'package:comic_world/views/opinions_and_suggestions.dart';
import 'package:comic_world/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuItem(
            icon: Icons.favorite,
            text: 'المفضلة',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ComicGridView(
                      dataFunc: () => RequestData().featchFavoriteList(),
                      title: 'المفضلة',
                    );
                  },
                ),
              );
            },
          ),

          MenuItem(
            icon: Icons.category,
            text: 'التصنيفات',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CategoriesView();
                  },
                ),
              );
            },
          ),

          MenuItem(
            icon: Icons.history,
            text: 'آخر المشاهدة',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ComicGridView(
                      dataFunc: () => RequestData().lastViewed(),
                      title: 'آخر المشاهدة',
                    );
                  },
                ),
              );
            },
          ),

          MenuItem(
            icon: Icons.feedback,
            text: 'ملاحظات ومقترحات',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OpinionsAndSuggestions(title: 'ملاحظات ومقترحات');
                  },
                ),
              );
            },
          ),

          MenuItem(
            icon: Icons.logout,
            text: 'تسجيل الخروج',
            onTap: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    final supabase= Supabase.instance.client;

    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: kSecondaryBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "تسجيل الخروج",
              style: TextStyle(color: kTextColor),
            ),
            content: const Text(
              "هل أنت متأكد من تسجيل الخروج؟",
              style: TextStyle(color: kTextColor),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("إلغاء"),
              ),
              ElevatedButton(
                onPressed: () {
                  supabase.auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginView();
                      },
                    ),
                    (route)=>false
                  );
                },
                child: const Text("تسجيل الخروج"),
              ),
            ],
          ),
        );
      },
    );
  }
}
