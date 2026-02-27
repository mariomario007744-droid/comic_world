import 'package:comic_world/requests/authentication_logic.dart';
import 'package:comic_world/views/register_view.dart';
import 'package:comic_world/views/forgot_password_view.dart';
import 'package:comic_world/widgets/custom_form_button.dart';
import 'package:comic_world/widgets/custom_password_text_form_field.dart';
import 'package:comic_world/widgets/custom_text_form_field.dart';
import 'package:comic_world/widgets/google_button.dart';
import 'package:comic_world/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatelessWidget {
  final String id='LoginView';
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final supabase = Supabase.instance.client;

  LoginView({super.key});
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
                    LogoWidget(),

                    const SizedBox(height: 40),

                    GoogleButton(
                      text: 'تسجيل الدخول بواسطة Google',
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: Text('أو', style: TextStyle(color: kTextColor)),
                    ),

                    const SizedBox(height: 20),

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

                    CustomPasswordTextFormField(
                      controller: password,
                      validator: (String? value) {
                        if (value == null || value.replaceAll(' ', '') == '') {
                          return 'ادخل كلمة المرور';
                        } else if (value.length < 8) {
                          return 'كلمة مرور ضعيفة';
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    CustomFormButton(
                      text: 'تسجيل الدخول',
                      onpressed: () async {
                        await AuthenticationLogic().logInLogic(context, email.text, password.text, formKey);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordView();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'هل نسيت كلمة السر؟',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisterView();
                                },
                              ),
                            );
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
