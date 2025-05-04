import 'package:flutter/material.dart';

class ReviewSubmit extends StatefulWidget {
  final Map<String, String> formData;
  final VoidCallback prevStep;
  final VoidCallback handleSubmit;

  const ReviewSubmit({
    super.key,
    required this.formData,
    required this.prevStep,
    required this.handleSubmit,
  });

  @override
  State<ReviewSubmit> createState() => _ReviewSubmitState();
}

class _ReviewSubmitState extends State<ReviewSubmit> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Your Information',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              background: Paint()
                ..shader = const LinearGradient(
                  colors: [
                    Color(0xFFE81CFF),
                    Color(0xFF40C9FF),
                  ],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildReviewSection(
            'Account Information',
            [
              _buildReviewItem('Email', widget.formData['email'] ?? ''),
            ],
          ),
          const SizedBox(height: 24),
          _buildReviewSection(
            'Personal Information',
            [
              _buildReviewItem('First Name', widget.formData['firstName'] ?? ''),
              _buildReviewItem('Last Name', widget.formData['lastName'] ?? ''),
              _buildReviewItem('Date of Birth', widget.formData['dateOfBirth'] ?? ''),
              _buildReviewItem('Gender', widget.formData['gender'] ?? ''),
            ],
          ),
          const SizedBox(height: 24),
          _buildReviewSection(
            'Medical Information',
            [
              _buildReviewItem('Height', '${widget.formData['height']} cm'),
              _buildReviewItem('Weight', '${widget.formData['weight']} kg'),
              _buildReviewItem('Blood Type', widget.formData['bloodType'] ?? ''),
              _buildReviewItem('Allergies', widget.formData['allergies'] ?? 'None', isFullWidth: true),
              _buildReviewItem('Medications', widget.formData['medications'] ?? 'None', isFullWidth: true),
              _buildReviewItem('Medical Conditions', widget.formData['conditions'] ?? 'None', isFullWidth: true),
              _buildReviewItem('Family History', widget.formData['familyHistory'] ?? 'None', isFullWidth: true),
            ],
          ),
          const SizedBox(height: 24),
          _buildReviewSection(
            'Lifestyle Information',
            [
              _buildReviewItem('Smoking Status', widget.formData['smokingStatus'] ?? ''),
              _buildReviewItem('Alcohol Consumption', widget.formData['alcoholConsumption'] ?? ''),
              _buildReviewItem('Physical Activity', widget.formData['physicalActivity'] ?? ''),
              _buildReviewItem('Sleep Hours', '${widget.formData['sleepHours']} hours'),
              _buildReviewItem('Diet Type', widget.formData['diet'] ?? ''),
              _buildReviewItem('Occupation', widget.formData['occupation'] ?? ''),
              _buildReviewItem('Stress Level', widget.formData['stressLevel'] ?? ''),
              _buildReviewItem('Hobbies/Interests', widget.formData['hobbies'] ?? 'None', isFullWidth: true),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: widget.prevStep,
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('Previous Step'),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value ?? false;
                  });
                },
                activeColor: theme.colorScheme.primary,
              ),
              Expanded(
                child: Text(
                  'I understand that my data will be collected to help provide personalized recommendations.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _acceptedTerms ? widget.handleSubmit : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                disabledBackgroundColor: theme.colorScheme.primary.withOpacity(0.6),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(String title, List<Widget> items) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF313131),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
            children: items,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(String label, String value, {bool isFullWidth = false}) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF717171),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF414141),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 