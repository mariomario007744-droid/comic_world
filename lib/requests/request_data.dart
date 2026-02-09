import 'package:supabase_flutter/supabase_flutter.dart';

class RequestData {
  final supabase = Supabase.instance.client;
  fetchNewComic()async{
    final data = await supabase
  .from('comic')
  .select().order('created_at', ascending: false).limit(10);
  return data;
  }

  fetchMostViewedComic()async{
        final data = await supabase
  .from('comic')
  .select().order('viewed', ascending: false).limit(10);
  return data;
  }

    fetchMostViewedCompanyComic({required String company})async{
        final data = await supabase
  .from('comic')
  .select().eq('production_company',company).order('viewed', ascending: false).limit(10);
  return data;
  }
}