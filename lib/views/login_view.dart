import 'package:comic_world/views/home_view.dart';
import 'package:comic_world/views/register_view.dart';
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
                        try {
                          if (formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            );
                            final data = await supabase
                                .from('Users')
                                .select()
                                .eq('email', email.text)
                                .maybeSingle();
                            if (data == null) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('الحساب غير موجود')),
                              );
                            } else {
                              try {
                                final AuthResponse res = await supabase.auth
                                    .signInWithPassword(
                                      email: email.text,
                                      password: password.text,
                                    );
                                kSession = res.session;
                                kUser = res.user;
                                Navigator.pop(context);
                                if (kUser != null) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeView();
                                      },
                                    ),
                                    (route) => false,
                                  );
                                }
                              } on Exception catch (e) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'الايميل او كلمة المرور غير صحيحة',
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
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
