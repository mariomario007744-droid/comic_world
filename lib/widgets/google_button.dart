import 'package:comic_world/const.dart';
import 'package:comic_world/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({required this.text});
  final supabase = Supabase.instance.client;

  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: Image.asset(
          'assets/images/free-google-icon-svg-download-png-189824.png',
          height: 22,
        ),
        label: Text(text, style: TextStyle(fontSize: 16)),
        onPressed: () async {
          try {
            final googleSignIn = GoogleSignIn.instance;

            await googleSignIn.initialize(
              serverClientId:
                  '788754430985-fohq86tcf0lcsfdervqnn4b99evhtdsp.apps.googleusercontent.com',
            );

            final GoogleSignInAccount account = await googleSignIn
                .authenticate();

            final String? idToken = account.authentication.idToken;

            final authorization = await account.authorizationClient
                .authorizationForScopes(['email', 'profile']);
            final String? accessToken = authorization?.accessToken;

            if (idToken == null) throw 'ID Token not found';

            final res = await supabase.auth.signInWithIdToken(
              provider: OAuthProvider.google,
              idToken: idToken,
              accessToken: accessToken,
            );
            
            if (res.user != null) {
              await supabase
  .from('Users')
  .upsert({ 'email': "${res.user!.email}",})
  .select();
              kUser = res.user;
              kSession = res.session;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
          }
        },
      ),
    );
  }
}
