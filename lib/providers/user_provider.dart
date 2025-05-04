import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../config/supabase_config.dart';

String convertToIsoDate(String input) {
  // input: DD-MM-YYYY, output: YYYY-MM-DD
  final parts = input.split('-');
  if (parts.length == 3) {
    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }
  return input;
}

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // First, sign up with email and password
      final response = await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Insert into user_profiles table
        await SupabaseConfig.client.from('user_profiles').insert({
          'user_id': response.user!.id,
          'email': email,
          'first_name': userData['firstName'],
          'last_name': userData['lastName'],
          'date_of_birth': convertToIsoDate(userData['dateOfBirth']),
          'phone': userData['phone'],
          'gender': userData['gender'],
          'height': userData['height'],
          'weight': userData['weight'],
          'blood_type': userData['bloodType'],
          'chronic_conditions': userData['chronicConditions'],
          'conditions': userData['conditions'],
          'medications': userData['medications'],
          'allergies': userData['allergies'],
          'family_history': userData['familyHistory'],
          'smoking_status': userData['smokingStatus'],
          'alcohol_consumption': userData['alcoholConsumption'],
          'physical_activity': userData['physicalActivity'],
          'sleep_hours': userData['sleepHours'],
          'diet': userData['diet'],
          'occupation': userData['occupation'],
          'stress_level': userData['stressLevel'],
          'hobbies': userData['hobbies'],
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        });

        // Create user model
        _user = UserModel(
          email: email,
          password: password,
          firstName: userData['firstName'] ?? '',
          lastName: userData['lastName'] ?? '',
          dateOfBirth: userData['dateOfBirth'] ?? '',
          phone: userData['phone'] ?? '',
          gender: userData['gender'] ?? '',
          height: userData['height'] ?? '',
          weight: userData['weight'] ?? '',
          bloodType: userData['bloodType'] ?? '',
          chronicConditions: userData['chronicConditions'] ?? '',
          conditions: userData['conditions'] ?? '',
          medications: userData['medications'] ?? '',
          allergies: userData['allergies'] ?? '',
          familyHistory: userData['familyHistory'] ?? '',
          smokingStatus: userData['smokingStatus'] ?? '',
          alcoholConsumption: userData['alcoholConsumption'] ?? '',
          physicalActivity: userData['physicalActivity'] ?? '',
          sleepHours: userData['sleepHours'] ?? '',
          diet: userData['diet'] ?? '',
          occupation: userData['occupation'] ?? '',
          stressLevel: userData['stressLevel'] ?? '',
          hobbies: userData['hobbies'] ?? '',
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Sign in with Supabase
      final response = await SupabaseConfig.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Fetch user profile from the user_profiles table
        final profile = await SupabaseConfig.client
            .from('user_profiles')
            .select()
            .eq('user_id', response.user!.id)
            .single();

        // Create user model
        _user = UserModel(
          email: profile['email'] ?? '',
          password: password,
          firstName: profile['first_name'] ?? '',
          lastName: profile['last_name'] ?? '',
          dateOfBirth: profile['date_of_birth'] ?? '',
          phone: profile['phone'] ?? '',
          gender: profile['gender'] ?? '',
          height: profile['height'] ?? '',
          weight: profile['weight'] ?? '',
          bloodType: profile['blood_type'] ?? '',
          chronicConditions: profile['chronic_conditions'] ?? '',
          conditions: profile['conditions'] ?? '',
          medications: profile['medications'] ?? '',
          allergies: profile['allergies'] ?? '',
          familyHistory: profile['family_history'] ?? '',
          smokingStatus: profile['smoking_status'] ?? '',
          alcoholConsumption: profile['alcohol_consumption'] ?? '',
          physicalActivity: profile['physical_activity'] ?? '',
          sleepHours: profile['sleep_hours'] ?? '',
          diet: profile['diet'] ?? '',
          occupation: profile['occupation'] ?? '',
          stressLevel: profile['stress_level'] ?? '',
          hobbies: profile['hobbies'] ?? '',
        );
      }
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await SupabaseConfig.client.auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  bool get isLoggedIn => _user != null;
} 