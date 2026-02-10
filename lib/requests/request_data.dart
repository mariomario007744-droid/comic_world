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
  .select().eq('comic_id', comicId).eq('user_id', kUser!.email.toString()).maybeSingle();


    if (data != null) {
  await supabase.from('List_of_ratings').update({
    'evaluation': evaluation,
  }).eq('comic_id', comicId).eq('user_id', kUser!.email.toString()).select();
}else{
  await supabase
    .from('List_of_ratings')
    .insert({
      'evaluation': evaluation,
      'comic_id': comicId,
      'user_id': kUser!.email.toString(),
    });
}

    final respones = await supabase
  .from('List_of_ratings')
  .select('evaluation').eq('comic_id', comicId).eq('user_id', kUser!.email.toString());
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
}
