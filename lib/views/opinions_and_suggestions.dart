import 'package:comic_world/const.dart';
import 'package:comic_world/widgets/custom_form_button.dart';
import 'package:comic_world/widgets/custom_show_dialog.dart';
import 'package:comic_world/widgets/custom_text_form_field.dart';
import 'package:comic_world/widgets/custome_more_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OpinionsAndSuggestions extends StatelessWidget {
  OpinionsAndSuggestions({required this.title});
  final String title;
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Column(
            children: [
              CustomtMorePageAppBar(title: title),
              const SizedBox(height: 18),
              Expanded(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomTextFormField(
                          hint: 'أضف ملاحظاتك ومقترحاتك ..........',
                          validator: (String? value) {
                            if (value!.replaceAll(' ', '') == null ||
                                value.replaceAll(' ', '') == '') {
                              return 'أدخل النص';
                            }
                            ;
                          },
                          controller: controller,
                          maxLines: 10,
                        ),
                      ),
                      CustomFormButton(
                        text: 'ارسال',
                        onpressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await supabase
                                  .from('opinions_and_suggestions')
                                  .insert({
                                    'user': kUser!.email,
                                    'content': controller.text,
                                  });
                                  showDialog(context: context, builder: (context){
                                    return CustomShowDialog(title: 'تم إلارسال', buttonText: 'تم');
                                  });
                            } on AuthException catch (e) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(e.message)));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
