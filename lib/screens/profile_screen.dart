import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Account Information',
              [
                _buildInfoRow('Email', user.email),
                _buildInfoRow('Password', '••••••••'),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Personal Information',
              [
                _buildInfoRow('First Name', user.firstName),
                _buildInfoRow('Last Name', user.lastName),
                _buildInfoRow('Date of Birth', user.dateOfBirth),
                _buildInfoRow('Phone', user.phone),
                _buildInfoRow('Gender', user.gender),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Medical Information',
              [
                _buildInfoRow('Height', user.height),
                _buildInfoRow('Weight', user.weight),
                _buildInfoRow('Blood Type', user.bloodType),
                _buildInfoRow('Chronic Conditions', user.chronicConditions),
                _buildInfoRow('Current Conditions', user.conditions),
                _buildInfoRow('Medications', user.medications),
                _buildInfoRow('Allergies', user.allergies),
                _buildInfoRow('Family History', user.familyHistory),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Lifestyle Information',
              [
                _buildInfoRow('Smoking Status', user.smokingStatus),
                _buildInfoRow('Alcohol Consumption', user.alcoholConsumption),
                _buildInfoRow('Physical Activity', user.physicalActivity),
                _buildInfoRow('Sleep Hours', user.sleepHours),
                _buildInfoRow('Diet', user.diet),
                _buildInfoRow('Occupation', user.occupation),
                _buildInfoRow('Stress Level', user.stressLevel),
                _buildInfoRow('Hobbies', user.hobbies),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 