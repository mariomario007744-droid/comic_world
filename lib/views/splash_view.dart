import 'dart:async';
import 'dart:io';
import 'package:comic_world/const.dart';
import 'package:comic_world/views/home_view.dart';
import 'package:comic_world/views/login_view.dart';
import 'package:comic_world/widgets/check_network.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String splashView = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client;
  var data;
  bool isConected = true;
  bool versionSupported = true;

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  getVersion() async {
    if (mounted) {
      try {
        data = await supabase.from('app_version').select().maybeSingle();
        if (kCurrentAppVersion >= data['current_app_version']) {
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(
              context,
              kSession == null ? LoginView.id : HomeView.id,
            );
          });
          if (mounted) {
            setState(() {});
          }
        } else {
          versionSupported = false;
          if (mounted) {
            setState(() {});
          }
        }
      } on SocketException {
        if (mounted) {
          setState(() {
            isConected = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: isConected
          ? versionSupported
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/images/Picsart_26-02-19_03-22-53-564.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Center(
                        child: Text(
                          'أصبح هذا الإصدار قديم انت بحاجة الي التحديث',
                          style: TextStyle(color: kTextColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kThemeColor,
                          ),
                          onPressed: () async {
                            await launchUrl(Uri.parse(data['download_url']));
                          },
                          child: Text(
                            'تحديث',
                            style: TextStyle(color: kTextColor),
                          ),
                        ),
                      ),
                    ],
                  )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CheckNetwork(getData: () => getVersion())),
              ],
            ),
    );
  }
}
