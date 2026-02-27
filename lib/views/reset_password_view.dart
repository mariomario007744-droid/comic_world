import 'package:comic_world/const.dart';
import 'package:comic_world/widgets/custom_form_button.dart';
import 'package:comic_world/widgets/custom_password_text_form_field.dart';
import 'package:comic_world/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordView extends StatelessWidget {
    final String id='ResetPasswordView';
  final formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();

  ResetPasswordView({super.key});

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

                    const SizedBox(height: 16),

                    CustomFormButton(
                      text: 'إعادة تعيين كلمة المرور',
                       onpressed: () async {
  if (formKey.currentState!.validate()) {

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: password.text.trim()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تغيير كلمة السر بنجاح')),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }
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