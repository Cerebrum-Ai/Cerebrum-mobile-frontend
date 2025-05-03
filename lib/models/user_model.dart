class UserModel {
  // Account Info
  final String email;
  final String password;

  // Personal Info
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String phone;
  final String gender;

  // Medical Info
  final String height;
  final String weight;
  final String bloodType;
  final String chronicConditions;
  final String conditions;
  final String medications;
  final String allergies;
  final String familyHistory;

  // Lifestyle Info
  final String smokingStatus;
  final String alcoholConsumption;
  final String physicalActivity;
  final String sleepHours;
  final String diet;
  final String occupation;
  final String stressLevel;
  final String hobbies;

  UserModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phone,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.chronicConditions,
    required this.conditions,
    required this.medications,
    required this.allergies,
    required this.familyHistory,
    required this.smokingStatus,
    required this.alcoholConsumption,
    required this.physicalActivity,
    required this.sleepHours,
    required this.diet,
    required this.occupation,
    required this.stressLevel,
    required this.hobbies,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'phone': phone,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'chronicConditions': chronicConditions,
      'conditions': conditions,
      'medications': medications,
      'allergies': allergies,
      'familyHistory': familyHistory,
      'smokingStatus': smokingStatus,
      'alcoholConsumption': alcoholConsumption,
      'physicalActivity': physicalActivity,
      'sleepHours': sleepHours,
      'diet': diet,
      'occupation': occupation,
      'stressLevel': stressLevel,
      'hobbies': hobbies,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      bloodType: json['bloodType'] ?? '',
      chronicConditions: json['chronicConditions'] ?? '',
      conditions: json['conditions'] ?? '',
      medications: json['medications'] ?? '',
      allergies: json['allergies'] ?? '',
      familyHistory: json['familyHistory'] ?? '',
      smokingStatus: json['smokingStatus'] ?? '',
      alcoholConsumption: json['alcoholConsumption'] ?? '',
      physicalActivity: json['physicalActivity'] ?? '',
      sleepHours: json['sleepHours'] ?? '',
      diet: json['diet'] ?? '',
      occupation: json['occupation'] ?? '',
      stressLevel: json['stressLevel'] ?? '',
      hobbies: json['hobbies'] ?? '',
    );
  }
} 