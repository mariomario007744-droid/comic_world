import 'package:comic_world/requests/request_data.dart';
import 'package:comic_world/views/categories_view.dart';
import 'package:comic_world/views/comic_grid_view.dart';
import 'package:comic_world/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [


          MenuItem(icon: Icons.favorite, text: 'المفضلة',onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return ComicGridView(dataFunc:()=> RequestData().featchFavoriteList(),title: 'المفضلة',);
            }));
          },),




          MenuItem(icon: Icons.category, text: 'التصنيفات', onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return CategoriesView();
            }));
          },),




          
          MenuItem(icon: Icons.history, text: 'آخر المشاهدة', onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return ComicGridView(dataFunc:()=> RequestData().lastViewed(),title: 'آخر المشاهدة',);
            }));
          },),
        ],
      ),
    );
  }
}