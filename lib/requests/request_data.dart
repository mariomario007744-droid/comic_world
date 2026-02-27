import 'package:comic_world/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestData {
  final supabase = Supabase.instance.client;
  fetchNewComic({required int limit}) async {
    final data = await supabase
        .from('comic')
        .select()
        .order('created_at', ascending: false)
        .limit(limit);
    return data;
  }

  fetchMostViewedComic({required int limit}) async {
    final data = await supabase
        .from('comic')
        .select()
        .order('viewed', ascending: false)
        .limit(limit);
    return data;
  }

  fetchMostViewedCompanyComic({
    required String company,
    required int limit,
  }) async {
    final data = await supabase
        .from('comic')
        .select()
        .eq('production_company', company)
        .order('viewed', ascending: false)
        .limit(limit);
    return data;
  }




  evaluationComic({required int evaluation, required int comicId}) async {
    final data = await supabase
  .from('List_of_ratings')
  .select().eq('comic_id', comicId).eq('email', kUser!.email.toString()).maybeSingle();


    if (data != null) {
  await supabase.from('List_of_ratings').update({
    'evaluation': evaluation,
  }).eq('comic_id', comicId).eq('email', kUser!.email.toString()).select();
}else{
  await supabase
    .from('List_of_ratings')
    .insert({
      'evaluation': evaluation,
      'comic_id': comicId,
      'email': kUser!.email.toString(),
    });
}

    final respones = await supabase
  .from('List_of_ratings')
  .select('evaluation').eq('comic_id', comicId).eq('email', kUser!.email.toString());
  double sum = 0;
  for (var element in respones) {
    sum += element['evaluation'];
  }
  final average = sum / respones.length;
  await supabase
    .from('comic')
    .update({
      'evaluation': average,
    })
    .eq('id', comicId);
  }



  fetchPartComic({required int comicId}) async {
    final data = await supabase
        .from('comic_parts')
        .select('link_pdf,part')
        .eq('comic_id', comicId);
    return data;
  }


  fetchCategoryComic({required int comicId}) async {
    final data = await supabase
        .from('comic_type')
        .select('type')
        .eq('comic_id', comicId);
    return data;
  }

  fetchThisCategoryComic({required String category, required int limit}) async {
    final comicsId = await supabase
        .from('comic_type')
        .select('comic_id')
        .eq('type', category)
        .limit(limit);
        List  listData = [];
        for (var element in comicsId) {
          listData.add(element['comic_id']);
        }
        final data = await supabase
        .from('comic').select().inFilter('id', listData);
    return data;
  }


  fetchOneComic({required int id})async{
    final data = await supabase
  .from('comic')
  .select().eq('id', id).maybeSingle();
  return data;
  }

  fetchSuggestions({required String query})async{
    final data = await supabase
  .from('comic')
  .select('name,id')
  .ilike('name', '%$query%');
  return data;
  }

  featchFavoriteList()async{
    final idComics = await supabase
  .from('favorite')
  .select('id_comic').eq('user', kUser!.email.toString());
  List listId = [];
  for (var element in idComics) {
    listId.add(element['id_comic']);
  }
  final data = await supabase
  .from('comic')
  .select()
  .inFilter('id', listId);
  return data;
  }



    lastViewed() async {
    final idComics = await supabase
        .from('most_viewed')
        .select('comic_id').eq('user_name', kUser!.email.toString())
        .order('created_at', ascending: false);
          List listId = [];
  for (var element in idComics) {
    listId.add(element['comic_id']);
  }
  final data = await supabase
  .from('comic')
  .select()
  .inFilter('id', listId);
  return data;
  }


  featchCategorys()async{
        final data = await supabase
  .from('types')
  .select();
  return data;
  }
}
