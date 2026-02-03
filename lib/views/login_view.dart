import 'package:comic_world/widgets/custom_form_button.dart';
import 'package:comic_world/widgets/custom_password_text_form_field.dart';
import 'package:comic_world/widgets/custom_text_form_field.dart';
import 'package:comic_world/widgets/google_button.dart';
import 'package:comic_world/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    // LOGO
                    LogoWidget(),

                    const SizedBox(height: 40),

                    // GOOGLE LOGIN
                    GoogleButton(),

                    const SizedBox(height: 20),

                    // OR
                    Center(
                      child: Text('أو', style: TextStyle(color: kTextColor)),
                    ),

                    const SizedBox(height: 20),

                    // EMAIL
                    // _inputField(
                    //   hint: 'البريد الإلكتروني',
                    //   icon: Icons.email_outlined,
                    // ),
                    CustomTextFormField(
                      hint: 'البريد الإلكتروني',
                      icon: Icons.email_outlined,
                      controller: email,
                      validator: (String? value) {
                        if (value == null || value == '') {
                          return 'أدخل الايميل';
                        } else if (!value.contains('@')) {
                          return 'الايميل لا يحتوي علي "@"';
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    // PASSWORD
                    // _inputField(
                    //   hint: 'كلمة المرور',
                    //   icon: Icons.lock_outline,
                    //   obscure: true,
                    // ),
                    CustomPasswordTextFormField(
                      controller: password,
                      validator: (String? value) {
                        if (value == null || value == '') {
                          return 'ادخل كلمة المرور';
                        } else if (value.length < 8) {
                          return 'كلمة مرور ضعيفة';
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    // LOGIN BUTTON
                    CustomFormButton(
                      text: 'تسجيل الدخول',
                      onpressed: () async {
                        try {
  if (formKey.currentState!.validate()) {
    final AuthResponse res = await supabase.auth
        .signInWithPassword(
          email: email.text,
          password: password.text,
        );
    kSession = res.session;
    kUser= res.user;
      print('Mario done');

  }
} on Exception catch (e) {
  print('Mario $e');
}
                      },
                    ),

                    const SizedBox(height: 16),

                    // CREATE ACCOUNT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'ليس لديك حساب؟ ',
                            style: TextStyle(color: kTextColor),
                          ),
                        TextButton(
                          onPressed: () {
                            // Navigate to Register
                          },
                          child: Text(
                           'إنشاء حساب',
                            style: TextStyle(color: kThemeColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
