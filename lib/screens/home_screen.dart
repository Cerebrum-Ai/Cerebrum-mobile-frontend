import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/analysis_result.dart';
import 'text_screen.dart';
import 'voice_screen.dart';
import 'image_screen.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final AnalysisSession _session = AnalysisSession();
  final List<String> _selectedTypes = ['text']; // Pre-select text as mandatory
  bool _isAnalyzing = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  void _onAnalysisComplete(AnalysisResult result) {
    _session.addResult(result);
    if (_selectedTypes.isEmpty) {
      Navigator.pushReplacement(
        context,
        _createSlideRoute(
          ResultScreen(
            result: AnalysisResult(
              type: 'combined',
              data: {
                'summary': 'Combined analysis complete. Here are the results from all analyses.',
                'details': _session.results.expand((result) =>
                  (result.data['details'] as List).map((detail) => {
                    'description': '${result.type.toUpperCase()}: ${detail['description']}',
                    'value': detail['value'],
                  })
                ).toList(),
                'individualResults': _session.results.map((r) => r.data).toList(),
              },
            ),
          ),
        ),
      );
    } else {
      _navigateToNextScreen();
    }
  }

  PageRouteBuilder _createSlideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  void _navigateToNextScreen() {
    if (_selectedTypes.isEmpty) return;
    final nextType = _selectedTypes.removeAt(0);
    switch (nextType) {
      case 'text':
        Navigator.push(context, _createSlideRoute(TextScreen(onComplete: _onAnalysisComplete)));
        break;
      case 'voice':
        Navigator.push(context, _createSlideRoute(VoiceScreen(onComplete: _onAnalysisComplete)));
        break;
      case 'image':
        Navigator.push(context, _createSlideRoute(ImageScreen(onComplete: _onAnalysisComplete)));
        break;
    }
  }

  void _startAnalysis() {
    if (_selectedTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one analysis type'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _isAnalyzing = true;
    });
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.primary, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.5),
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.5),
                ],
                stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                begin: Alignment(-2 + (4 * _shimmerController.value), -0.2),
                end: Alignment(-1 + (4 * _shimmerController.value), 0.2),
                tileMode: TileMode.clamp,
              ).createShader(bounds),
              child: Text(
                'Choose Input Types',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              Text(
                'Select one or more analysis types',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              _buildOptionCard(
                context, theme, 'Text Analysis', Icons.text_fields,
                'Analyze text data for insights', 'text', Colors.deepPurpleAccent
              ),
              const SizedBox(height: 20),
              _buildOptionCard(
                context, theme, 'Voice Analysis', Icons.mic,
                'Analyze voice recordings', 'voice', Colors.teal
              ),
              const SizedBox(height: 20),
              _buildOptionCard(
                context, theme, 'Image Analysis', Icons.image,
                'Analyze images and scans', 'image', Colors.pinkAccent
              ),
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 20, top: 10),
                child: ElevatedButton(
                  onPressed: _isAnalyzing ? null : _startAnalysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTypes.isNotEmpty
                        ? theme.colorScheme.primary
                        : Colors.grey[300],
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    minimumSize: const Size(double.infinity, 54),
                    elevation: 6,
                  ),
                  child: Text(
                    _isAnalyzing ? 'Analyzing...' : 'Start Analysis',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    ThemeData theme,
    String title,
    IconData icon,
    String description,
    String type,
    Color accentColor,
  ) {
    final isSelected = _selectedTypes.contains(type);
    final isTextType = type == 'text';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected
            ? accentColor.withOpacity(0.12)
            : theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? accentColor.withOpacity(0.5)
              : theme.dividerColor.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? accentColor.withOpacity(0.15)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: isTextType ? null : () {
          setState(() {
            if (isSelected) {
              _selectedTypes.remove(type);
            } else {
              _selectedTypes.add(type);
            }
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor.withOpacity(0.2)
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? accentColor : theme.colorScheme.onSurface.withOpacity(0.5),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isSelected
                                ? accentColor
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isTextType)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Required',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (!isTextType)
              Checkbox(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedTypes.add(type);
                    } else {
                      _selectedTypes.remove(type);
                    }
                  });
                },
                activeColor: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 