import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../components/review_submit.dart';
import 'profile_screen.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SignupScreen(),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final Map<String, TextEditingController> _controllers = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'dateOfBirth': TextEditingController(),
    'phone': TextEditingController(),
    'gender': TextEditingController(),
    'height': TextEditingController(),
    'weight': TextEditingController(),
    'bloodType': TextEditingController(),
    'chronicConditions': TextEditingController(),
    'conditions': TextEditingController(),
    'medications': TextEditingController(),
    'allergies': TextEditingController(),
    'familyHistory': TextEditingController(),
    'smokingStatus': TextEditingController(),
    'alcoholConsumption': TextEditingController(),
    'physicalActivity': TextEditingController(),
    'sleepHours': TextEditingController(),
    'diet': TextEditingController(),
    'occupation': TextEditingController(),
    'stressLevel': TextEditingController(),
    'hobbies': TextEditingController(),
  };

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _nextStep() {
    // Validate current step before proceeding
    if (!_validateCurrentStep()) {
      return;
    }

    if (_currentStep < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0: // Account Info
        if (_controllers['email']!.text.isEmpty ||
            _controllers['password']!.text.isEmpty ||
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_controllers['email']!.text) ||
            _controllers['password']!.text.length < 6) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all account information correctly'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }
        break;
      case 1: // Personal Info
        if (_controllers['firstName']!.text.isEmpty ||
            _controllers['lastName']!.text.isEmpty ||
            _controllers['dateOfBirth']!.text.isEmpty ||
            _controllers['phone']!.text.isEmpty ||
            _controllers['gender']!.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all personal information'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }
        break;
      case 2: // Medical Info
        if (_controllers['height']!.text.isEmpty ||
            _controllers['weight']!.text.isEmpty ||
            _controllers['bloodType']!.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill height, weight, and blood type'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }
        break;
      case 3: // Lifestyle Info
        if (_controllers['smokingStatus']!.text.isEmpty ||
            _controllers['alcoholConsumption']!.text.isEmpty ||
            _controllers['physicalActivity']!.text.isEmpty ||
            _controllers['sleepHours']!.text.isEmpty ||
            _controllers['diet']!.text.isEmpty ||
            _controllers['occupation']!.text.isEmpty ||
            _controllers['stressLevel']!.text.isEmpty ||
            _controllers['hobbies']!.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all lifestyle information'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return false;
        }
        break;
    }
    return true;
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _completeSignup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userData = {
          'firstName': _controllers['firstName']!.text,
          'lastName': _controllers['lastName']!.text,
          'dateOfBirth': _controllers['dateOfBirth']!.text,
          'phone': _controllers['phone']!.text,
          'gender': _controllers['gender']!.text,
          'height': _controllers['height']!.text,
          'weight': _controllers['weight']!.text,
          'bloodType': _controllers['bloodType']!.text,
          'chronicConditions': _controllers['chronicConditions']!.text,
          'conditions': _controllers['conditions']!.text,
          'medications': _controllers['medications']!.text,
          'allergies': _controllers['allergies']!.text,
          'familyHistory': _controllers['familyHistory']!.text,
          'smokingStatus': _controllers['smokingStatus']!.text,
          'alcoholConsumption': _controllers['alcoholConsumption']!.text,
          'physicalActivity': _controllers['physicalActivity']!.text,
          'sleepHours': _controllers['sleepHours']!.text,
          'diet': _controllers['diet']!.text,
          'occupation': _controllers['occupation']!.text,
          'stressLevel': _controllers['stressLevel']!.text,
          'hobbies': _controllers['hobbies']!.text,
        };

        await Provider.of<UserProvider>(context, listen: false).signUp(
          email: _controllers['email']!.text,
          password: _controllers['password']!.text,
          userData: userData,
        );

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            HomeScreen.route(),
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup failed: ${e.toString()}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  Widget _buildAccountInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _controllers['email'],
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email address',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['password'],
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password (min. 6 characters)',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password length should be at least 6 characters';
              }
              return null;
            },
            onChanged: (value) {
              // Show error message immediately when typing
              if (value.isNotEmpty && value.length < 6) {
                setState(() {
                  // This will trigger the validator
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _controllers['firstName'],
            decoration: const InputDecoration(
              labelText: 'First Name',
              hintText: 'Enter your first name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['lastName'],
            decoration: const InputDecoration(
              labelText: 'Last Name',
              hintText: 'Enter your last name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['dateOfBirth'],
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              hintText: 'DD-MM-YYYY',
              prefixIcon: Icon(Icons.calendar_today_outlined),
            ),
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).colorScheme.primary,
                        onPrimary: Theme.of(context).colorScheme.onPrimary,
                        surface: Theme.of(context).colorScheme.surface,
                        onSurface: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                _controllers['dateOfBirth']!.text = 
                    '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth';
              }
              if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                return 'Please enter date in DD-MM-YYYY format';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['phone'],
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['gender']!.text.isEmpty ? null : _controllers['gender']!.text,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person_outline),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                  DropdownMenuItem(
                    value: 'Prefer not to say',
                    child: Text('Prefer not to say'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['gender']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Gender'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _controllers['height'],
            decoration: const InputDecoration(
              labelText: 'Height',
              hintText: 'Enter your height in cm',
              prefixIcon: Icon(Icons.height),
              suffixText: 'cm',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your height';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['weight'],
            decoration: const InputDecoration(
              labelText: 'Weight',
              hintText: 'Enter your weight in kg',
              prefixIcon: Icon(Icons.monitor_weight_outlined),
              suffixText: 'kg',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your weight';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['bloodType']!.text.isEmpty ? null : _controllers['bloodType']!.text,
                decoration: const InputDecoration(
                  labelText: 'Blood Type',
                  prefixIcon: Icon(Icons.bloodtype_outlined),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(value: 'A+', child: Text('A+')),
                  DropdownMenuItem(value: 'A-', child: Text('A-')),
                  DropdownMenuItem(value: 'B+', child: Text('B+')),
                  DropdownMenuItem(value: 'B-', child: Text('B-')),
                  DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                  DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                  DropdownMenuItem(value: 'O+', child: Text('O+')),
                  DropdownMenuItem(value: 'O-', child: Text('O-')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['bloodType']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your blood type';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Blood Type'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['chronicConditions'],
            decoration: const InputDecoration(
              labelText: 'Chronic Conditions (Optional)',
              hintText: 'Enter any chronic conditions',
              prefixIcon: Icon(Icons.medical_services_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['conditions'],
            decoration: const InputDecoration(
              labelText: 'Current Conditions (Optional)',
              hintText: 'Enter any current conditions',
              prefixIcon: Icon(Icons.medical_services_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['medications'],
            decoration: const InputDecoration(
              labelText: 'Medications (Optional)',
              hintText: 'Enter any medications',
              prefixIcon: Icon(Icons.medication_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['allergies'],
            decoration: const InputDecoration(
              labelText: 'Allergies (Optional)',
              hintText: 'Enter any allergies',
              prefixIcon: Icon(Icons.warning_amber_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['familyHistory'],
            decoration: const InputDecoration(
              labelText: 'Family History (Optional)',
              hintText: 'Enter any relevant family history',
              prefixIcon: Icon(Icons.family_restroom_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['smokingStatus']!.text.isEmpty ? null : _controllers['smokingStatus']!.text,
                decoration: const InputDecoration(
                  labelText: 'Smoking Status',
                  prefixIcon: Icon(Icons.smoking_rooms_outlined),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(value: 'Never Smoked', child: Text('Never Smoked')),
                  DropdownMenuItem(value: 'Former Smoker', child: Text('Former Smoker')),
                  DropdownMenuItem(value: 'Current Smoker', child: Text('Current Smoker')),
                  DropdownMenuItem(value: 'Occasional Smoker', child: Text('Occasional Smoker')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['smokingStatus']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your smoking status';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Smoking Status'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['alcoholConsumption']!.text.isEmpty ? null : _controllers['alcoholConsumption']!.text,
                decoration: const InputDecoration(
                  labelText: 'Alcohol Consumption',
                  prefixIcon: Icon(Icons.wine_bar_outlined),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(value: 'Never', child: Text('Never')),
                  DropdownMenuItem(value: 'Occasionally', child: Text('Occasionally')),
                  DropdownMenuItem(value: 'Moderately', child: Text('Moderately')),
                  DropdownMenuItem(value: 'Heavily', child: Text('Heavily')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['alcoholConsumption']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your alcohol consumption';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Alcohol Consumption'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['physicalActivity']!.text.isEmpty ? null : _controllers['physicalActivity']!.text,
                decoration: const InputDecoration(
                  labelText: 'Physical Activity Level',
                  prefixIcon: Icon(Icons.fitness_center_outlined),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(value: 'Sedentary', child: Text('Sedentary')),
                  DropdownMenuItem(value: 'Lightly Active', child: Text('Lightly Active')),
                  DropdownMenuItem(value: 'Moderately Active', child: Text('Moderately Active')),
                  DropdownMenuItem(value: 'Very Active', child: Text('Very Active')),
                  DropdownMenuItem(value: 'Extremely Active', child: Text('Extremely Active')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['physicalActivity']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your physical activity level';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Physical Activity Level'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['sleepHours'],
            decoration: const InputDecoration(
              labelText: 'Sleep Hours',
              hintText: 'Enter average hours of sleep per night',
              prefixIcon: Icon(Icons.bedtime_outlined),
              suffixText: 'hours',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your sleep hours';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['diet'],
            decoration: const InputDecoration(
              labelText: 'Diet',
              hintText: 'Enter your dietary preferences',
              prefixIcon: Icon(Icons.restaurant_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your diet information';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['occupation'],
            decoration: const InputDecoration(
              labelText: 'Occupation',
              hintText: 'Enter your occupation',
              prefixIcon: Icon(Icons.work_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your occupation';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _controllers['stressLevel']!.text.isEmpty ? null : _controllers['stressLevel']!.text,
                decoration: const InputDecoration(
                  labelText: 'Stress Level',
                  prefixIcon: Icon(Icons.psychology_outlined),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                items: const [
                  DropdownMenuItem(value: 'Low', child: Text('Low')),
                  DropdownMenuItem(value: 'Moderate', child: Text('Moderate')),
                  DropdownMenuItem(value: 'High', child: Text('High')),
                  DropdownMenuItem(value: 'Very High', child: Text('Very High')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _controllers['stressLevel']!.text = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your stress level';
                  }
                  return null;
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Theme.of(context).cardColor,
                menuMaxHeight: 300,
                style: Theme.of(context).textTheme.bodyLarge,
                hint: const Text('Select Stress Level'),
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _controllers['hobbies'],
            decoration: const InputDecoration(
              labelText: 'Hobbies',
              hintText: 'Enter your hobbies and interests',
              prefixIcon: Icon(Icons.sports_esports_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your hobbies';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSubmitStep() {
    final formData = {
      'email': _controllers['email']!.text,
      'password': _controllers['password']!.text,
      'firstName': _controllers['firstName']!.text,
      'lastName': _controllers['lastName']!.text,
      'dateOfBirth': _controllers['dateOfBirth']!.text,
      'gender': _controllers['gender']!.text,
      'height': _controllers['height']!.text,
      'weight': _controllers['weight']!.text,
      'bloodType': _controllers['bloodType']!.text,
      'allergies': _controllers['allergies']!.text,
      'medications': _controllers['medications']!.text,
      'conditions': _controllers['conditions']!.text,
      'familyHistory': _controllers['familyHistory']!.text,
      'smokingStatus': _controllers['smokingStatus']!.text,
      'alcoholConsumption': _controllers['alcoholConsumption']!.text,
      'physicalActivity': _controllers['physicalActivity']!.text,
      'sleepHours': _controllers['sleepHours']!.text,
      'diet': _controllers['diet']!.text,
      'occupation': _controllers['occupation']!.text,
      'stressLevel': _controllers['stressLevel']!.text,
      'hobbies': _controllers['hobbies']!.text,
    };

    return ReviewSubmit(
      formData: formData,
      prevStep: _previousStep,
      handleSubmit: _completeSignup,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        actions: [
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoggedIn) {
                return IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: userProvider.user!,
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Step Indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepIndicator(
                    context,
                    step: 1,
                    title: 'Account',
                    isCompleted: _currentStep > 0,
                    isCurrent: _currentStep == 0,
                  ),
                  _buildStepIndicator(
                    context,
                    step: 2,
                    title: 'Personal',
                    isCompleted: _currentStep > 1,
                    isCurrent: _currentStep == 1,
                  ),
                  _buildStepIndicator(
                    context,
                    step: 3,
                    title: 'Medical',
                    isCompleted: _currentStep > 2,
                    isCurrent: _currentStep == 2,
                  ),
                  _buildStepIndicator(
                    context,
                    step: 4,
                    title: 'Lifestyle',
                    isCompleted: _currentStep > 3,
                    isCurrent: _currentStep == 3,
                  ),
                  _buildStepIndicator(
                    context,
                    step: 5,
                    title: 'Review',
                    isCompleted: _currentStep > 4,
                    isCurrent: _currentStep == 4,
                  ),
                ],
              ),
            ),
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentStep + 1) / 5,
              backgroundColor: theme.colorScheme.surface,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildAccountInfoStep(),
                  _buildPersonalInfoStep(),
                  _buildMedicalInfoStep(),
                  _buildLifestyleInfoStep(),
                  _buildReviewSubmitStep(),
                ],
              ),
            ),
            if (_currentStep < 4)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentStep > 0)
                      ElevatedButton(
                        onPressed: _previousStep,
                        child: const Text('Previous'),
                      ),
                    ElevatedButton(
                      onPressed: _nextStep,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(
    BuildContext context, {
    required int step,
    required String title,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    final theme = Theme.of(context);
    const size = 32.0;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? theme.colorScheme.primary
                : isCurrent
                    ? theme.colorScheme.primary.withOpacity(0.2)
                    : theme.colorScheme.surface,
            border: Border.all(
              color: isCompleted || isCurrent
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.check,
                    color: theme.colorScheme.onPrimary,
                    size: 20,
                  )
                : Text(
                    step.toString(),
                    style: TextStyle(
                      color: isCurrent
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isCurrent
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// Glassmorphism TextField
class _GlassTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final ThemeData theme;

  const _GlassTextField({
    required this.hintText,
    required this.icon,
    required this.theme,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.52),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.13),
          width: 1.1,
        ),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: theme.colorScheme.primary),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: theme.colorScheme.primary.withOpacity(0.5),
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        ),
      ),
    );
  }
}

// Animated Gradient Button
class _AnimatedGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ThemeData theme;

  const _AnimatedGradientButton({
    required this.text,
    required this.onPressed,
    required this.theme,
  });

  @override
  State<_AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<_AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.08,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_controller);
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) => _controller.reverse();
  void _onTapCancel() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.theme.colorScheme.primary,
                widget.theme.colorScheme.secondary,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.theme.colorScheme.primary.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 19,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 