import 'package:comic_world/const.dart';
import 'package:comic_world/views/home_view.dart';
import 'package:comic_world/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(url: kUrlSupaBase, anonKey: kAnonKeySupaBase);
  Supabase.instance.client;
  if (Supabase.instance.client.auth.currentUser != null &&
      Supabase.instance.client.auth.currentSession != null) {
    kUser = Supabase.instance.client.auth.currentUser;
    kSession = Supabase.instance.client.auth.currentSession;
  }
  runApp(ComicWorld());
}

class ComicWorld extends StatelessWidget {
  const ComicWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: kSession == null ? LoginView() : HomeView(),
    );
  }
}
