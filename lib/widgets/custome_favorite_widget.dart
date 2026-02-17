import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomeFavoriteWidget extends StatefulWidget {
  const CustomeFavoriteWidget({
    super.key,
    required this.id,
  });
  final int id;
  @override
  State<CustomeFavoriteWidget> createState() => _CustomeFavoriteWidgetState();
}

class _CustomeFavoriteWidgetState extends State<CustomeFavoriteWidget> {
    final supabase = Supabase.instance.client;
    String  chick='null';
chickFavorite()async{
  if (mounted) {
  final  response = await supabase
  .from('favorite')
  .select().eq('user', kUser!.email.toString()).eq('id_comic', widget.id).maybeSingle();
  if(response==null){
    chick='false';
  }else{
    chick='true';
  }
  if (mounted) {
  setState(() {
    
  });
  }
}
}

  @override
  void initState() {
    super.initState();
    chickFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return  chick=='null'?IconButton(icon: Icon(Icons.favorite_outline,color: Colors.white70,),onPressed: () {
      
    },): IconButton(onPressed: ()async{
      if (mounted) {
  if (chick=='true') {
    chick='false';
    await supabase
      .from('favorite')
      .delete()
      .eq('id_comic', widget.id).eq('user', kUser!.email.toString());
      setState(() {
  
      });
  }else if(chick=='false'){
    chick='true';
    await supabase
      .from('favorite')
      .insert({'id_comic': widget.id, 'user': kUser!.email.toString()});
      setState(() {
  
      });
  }
}
    }, icon:chick=='false'? Icon(Icons.favorite_outline,color: Colors.white70,):Icon(Icons.favorite,color: Colors.redAccent,));
  }
}
