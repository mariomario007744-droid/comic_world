import 'package:comic_world/views/confirmation_view.dart';
import 'package:comic_world/views/home_view.dart';
import 'package:comic_world/views/mail_alart_view.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationLogic {
    final supabase = Supabase.instance.client;

  Future<void> logInLogic(BuildContext context, String email, String password,GlobalKey<FormState> formKey) async {
    try {
      if (formKey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
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
            .eq('email', email)
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
                  email: email,
                  password: password,
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
          } on Exception {
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
  }





    Future<void> registerLogic(BuildContext context, String email, String password,String userName,GlobalKey<FormState> formKey) async {
    try {
      if (formKey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
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
            .eq('email', email)
            .maybeSingle();
        if (data != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الايميل موجود بالفعل')),
          );
        } else {
          final AuthResponse
          res = await supabase.auth.signUp(
            email: email,
            password: password,
            emailRedirectTo:
                'https://mariomario007744-droid.github.io/comic_knight/verify.html',
    
            data: {'user name': userName},
          );
          kUser = res.user;
          kSession = res.session;
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ConfirmView(
                  email: email,
                  password: password,
                );
              },
            ),
          );
        }
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }






    Future<void> resetPasswordLogic(BuildContext context, String email,GlobalKey<FormState> formKey) async {
    try {
      if (formKey.currentState!.validate()) {
        showDialog(
          barrierDismissible: false,
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
            .eq('email', email)
            .maybeSingle();
        if (data == null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('الحساب غير موجود')),
          );
        } else {
           await supabase.auth.resetPasswordForEmail(
            email,
            redirectTo:
                'comicknight://reset',
    
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return MailAlartView();
          }));
        }
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


    
  }
