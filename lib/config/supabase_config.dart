import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://odgfmdbnjroqktddkgkz.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9kZ2ZtZGJuanJvcWt0ZGRrZ2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU4Nzc3NTEsImV4cCI6MjA2MTQ1Mzc1MX0.xdQZAIyUbZ2peecH5yLHpnm3pRIlY4DxpM1YXI0k9Uo';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
} 