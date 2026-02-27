import 'package:flutter/material.dart';
import 'package:comic_world/requests/authentication_logic.dart';
import 'package:comic_world/widgets/custom_form_button.dart';
import 'package:comic_world/widgets/custom_text_form_field.dart';
import 'package:comic_world/widgets/logo_widget.dart';
import 'package:comic_world/const.dart';

class ForgotPasswordView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

  ForgotPasswordView({super.key});
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

                    CustomFormButton(
                      text: 'إعادة تعيين كلمة المرور',
                       onpressed: () async {
                        await AuthenticationLogic().resetPasswordLogic(context, email.text, formKey);
                      },
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
