import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:comic_world/const.dart';
import 'package:comic_world/views/home_view.dart';

class ConfirmView extends StatefulWidget {
  final String email;
  final String password;

  const ConfirmView({super.key, required this.email, required this.password});

  @override
  State<ConfirmView> createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {
  int resendSeconds = 30;
  bool canResend = false;
  Timer? resendTimer;
  final otpController = TextEditingController();
  final supabase = Supabase.instance.client;
  late DateTime otpCreatedAt;
  final Duration otpValidity = const Duration(minutes: 5);
  late String generatedOtp; // ⭐ هنا بيتخزن الـ OTP
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    generatedOtp = generateOtp();
    otpCreatedAt = DateTime.now();
    sendOtpEmail();
    startResendTimer();
  }

  void startResendTimer() {
    canResend = false;
    resendSeconds = 30;

    resendTimer?.cancel();

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds == 0) {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      } else {
        setState(() {
          resendSeconds--;
        });
      }
    });
  }

  Future<void> resendOtp() async {
    if (!canResend) return;

    setState(() {
      generatedOtp = generateOtp();
      otpCreatedAt = DateTime.now();
    });

    await sendOtpEmail();
    startResendTimer();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('📩 تم إرسال كود جديد')));
  }

  // توليد OTP
  String generateOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // إرسال OTP على الإيميل
  Future<void> sendOtpEmail() async {
    try {
      await sendEmail(
        to: widget.email,
        subject: 'كود التحقق - Comic World',
        body: 'كود التحقق الخاص بك هو:\n\n$generatedOtp',
      );
    } catch (e) {
      debugPrint('Email error: $e');
    }
  }

  // التحقق من OTP
  Future<void> verifyOtp() async {
    final now = DateTime.now();

    // ⏰ فحص مدة صلاحية الكود
    if (now.difference(otpCreatedAt) > otpValidity) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('⏰ انتهت صلاحية الكود')));
      return;
    }

    // ❌ الكود غلط
    if (otpController.text.trim() != generatedOtp) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ الكود غير صحيح')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // إضافة المستخدم في جدول Users
      await supabase.from('Users').insert({
        'email': widget.email,
        'created_at': DateTime.now().toIso8601String(),
      });

      // تسجيل الدخول بعد نجاح OTP
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: widget.email,
        password: widget.password,
      );

      kUser = res.user;
      kSession = res.session;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('خطأ في تسجيل الدخول: $e')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🔐 أدخل كود التحقق المرسل إلى بريدك',
              style: TextStyle(fontSize: 20, color: kTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: verifyOtp,
                    child: const Text('تأكيد'),
                  ),
            TextButton(
              onPressed: canResend ? resendOtp : null,
              child: Text(
                canResend
                    ? 'إعادة إرسال الكود'
                    : 'إعادة الإرسال بعد $resendSeconds ثانية',
                    style: TextStyle(color: kTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    const username = 'mariomario007744@gmail.com';
    const password = 'rgxm mwlw cchy pscd'; // App Password

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = const Address(username, 'Comic World')
      ..recipients.add(to)
      ..subject = subject
      ..text = body;

    await send(message, smtpServer);
  }
}
