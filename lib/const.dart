import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final Color kBackgroundColor = Color(0xFF0F0F14);
final Color kThemeColor = Color(0xff381D7E);
final Color kTextColor = Colors.white70;
final String kUrlSupaBase="https://dfsrzxmvygdzzgfnbhby.supabase.co";
final String kAnonKeySupaBase="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRmc3J6eG12eWdkenpnZm5iaGJ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0NjEzOTQsImV4cCI6MjA3NTAzNzM5NH0.Sa5q3CAfhjB-oBwhYkauEIF10KZjzxtm8mlzGwltL90";
User? kUser;
Session? kSession;
