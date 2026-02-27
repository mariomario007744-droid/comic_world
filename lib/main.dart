import 'package:app_links/app_links.dart';
import 'package:comic_world/const.dart';
import 'package:comic_world/views/home_view.dart';
import 'package:comic_world/views/login_view.dart';
import 'package:comic_world/views/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Supabase.initialize(url: kUrlSupaBase, anonKey: kAnonKeySupaBase);
  Supabase.instance.client;
  if (Supabase.instance.client.auth.currentUser != null &&
      Supabase.instance.client.auth.currentSession != null) {
    kUser = Supabase.instance.client.auth.currentUser;
    kSession = Supabase.instance.client.auth.currentSession;
  }
  runApp(ComicWorld());
  
  _handleDeepLinks();
}

void _handleDeepLinks() async {
  final appLinks = AppLinks();

  // الرابط الابتدائي (إذا كان التطبيق مغلقًا)
  final Uri? initialUri = await appLinks.getInitialLink();
  if (initialUri != null && _isResetPasswordLink(initialUri)) {
    _navigateToResetPassword();
  }

  // الاستماع للروابط أثناء تشغيل التطبيق
  appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null && _isResetPasswordLink(uri)) {
      _navigateToResetPassword();
    }
  }, onError: (err) {
    print('خطأ في استقبال الرابط: $err');
  });
}

bool _isResetPasswordLink(Uri uri) {
  return uri.scheme == 'comicknight' && uri.host == 'reset';
}

void _navigateToResetPassword() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigatorKey.currentState?.pushNamed(ResetPasswordView().id);
  });
}

class ComicWorld extends StatelessWidget {
  const ComicWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,

      initialRoute: kSession == null ? LoginView().id : HomeView().id,
      routes: {
        LoginView().id: (context) =>  LoginView(),
        HomeView().id: (context) => const HomeView(),
        ResetPasswordView().id: (context) => ResetPasswordView(),
      },
    );
  }
}
