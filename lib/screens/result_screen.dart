import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/analysis_result.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatefulWidget {
  final AnalysisResult result;

  const ResultScreen({
    super.key,
    required this.result,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoPositionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 1.2,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    // Start the animation after a brief delay
    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: [
                // Animated Logo and Title
                Positioned(
                  top: Tween<double>(
                    begin: (screenHeight - 200) / 2,
                    end: 60.0,
                  ).evaluate(_logoPositionAnimation),
                  left: 0,
                  right: 0,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.25),
                                blurRadius: 36,
                                spreadRadius: 10,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.medical_services_outlined,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cerebrum',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              'AI',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w900,
                                fontSize: 28,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Main Content
                Positioned.fill(
                  child: Opacity(
                    opacity: _contentOpacityAnimation.value,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 180, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Back Button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: theme.colorScheme.primary,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(height: 18),
                          // Disease Summary Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.cardColor.withOpacity(0.98),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withOpacity(0.13),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.info_outline, color: theme.colorScheme.primary, size: 22),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Disease Summary',
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  widget.result.data['summary'] ?? 'No summary available',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.amber[700],
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Severity: Moderate',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: Colors.amber[700],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.medical_services_outlined,
                                      color: theme.colorScheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Recommended Action: Immediate Consultation',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Diagnosis Results Card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: theme.cardColor.withOpacity(0.98),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withOpacity(0.13),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.search_rounded, color: theme.colorScheme.primary, size: 22),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Diagnosis Results',
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildDiagnosisItem(theme, 'Primary Diagnosis', '85%'),
                                const SizedBox(height: 12),
                                _buildDiagnosisItem(theme, 'Alternative Diagnosis 1', '65%'),
                                const SizedBox(height: 12),
                                _buildDiagnosisItem(theme, 'Alternative Diagnosis 2', '45%'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          // Action Buttons
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _actionButton(
                                context,
                                icon: Icons.local_hospital,
                                label: 'Nearby\nHospitals',
                                background: theme.colorScheme.primary.withOpacity(0.1),
                                foreground: theme.colorScheme.primary,
                                onTap: () {
                                  // TODO: Implement nearby hospitals functionality
                                },
                              ),
                              _actionButton(
                                context,
                                icon: Icons.phone,
                                label: 'Emergency\nCall',
                                background: theme.colorScheme.primary,
                                foreground: theme.colorScheme.onPrimary,
                                onTap: () {
                                  // TODO: Implement emergency call functionality
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Navigation Buttons
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _actionButton(
                                context,
                                icon: Icons.home,
                                label: 'Go to\nHome',
                                background: theme.colorScheme.primary,
                                foreground: theme.colorScheme.onPrimary,
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                                    (route) => false,
                                  );
                                },
                              ),
                              _actionButton(
                                context,
                                icon: Icons.add,
                                label: 'New\nAnalysis',
                                background: theme.colorScheme.surface,
                                foreground: theme.colorScheme.primary,
                                border: BorderSide(color: theme.colorScheme.primary),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                                    (route) => false,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDiagnosisItem(ThemeData theme, String title, String percentage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage match',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color background,
    required Color foreground,
    BorderSide? border,
    required VoidCallback onTap,
  }) {
    final width = (MediaQuery.of(context).size.width - 64) / 2;
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 22),
        label: Text(label, textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: border ?? BorderSide.none,
          ),
          elevation: 4,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}