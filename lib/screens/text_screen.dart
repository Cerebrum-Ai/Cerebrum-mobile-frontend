import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/analysis_result.dart';

class TextScreen extends StatefulWidget {
  final Function(AnalysisResult) onComplete;

  const TextScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
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
    _textController.dispose();
    super.dispose();
  }

  void _analyzeText() {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some text to analyze'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate AI analysis with a delay
    Future.delayed(const Duration(seconds: 2), () {
      final result = AnalysisResult(
        type: 'text',
        data: {
          'summary': 'Based on the provided text, here is a comprehensive analysis of the key points and potential insights.',
          'details': [
            {
              'description': 'Text Length',
              'value': '${_textController.text.length} characters'
            },
            {
              'description': 'Key Topics',
              'value': 'Health, Symptoms'
            },
            {
              'description': 'Sentiment',
              'value': 'Neutral'
            },
            {
              'description': 'Confidence Score',
              'value': '85%'
            }
          ],
          'rawText': _textController.text,
        },
      );
      widget.onComplete(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back button in its own row
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Title in its own container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: AnimatedBuilder(
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
                      child: const Text(
                        'Text Analysis',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 42,
                          letterSpacing: 0.3,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.18),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Enter your symptoms, medical history, or any health-related concerns. Our AI will analyze the text to provide insights and potential recommendations.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              // Glassy Text Input Field
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.13),
                      width: 1.3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    expands: true,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.5,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your text here...',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.4),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(18),
                    ),
                    enabled: !_isAnalyzing,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              // Action Buttons Row
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isAnalyzing
                          ? null
                          : () {
                              _textController.clear();
                              setState(() {
                                _isAnalyzing = false;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.red[400],
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.close),
                      label: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Confirm Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isAnalyzing
                          ? null
                          : () {
                              if (_textController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter some text to analyze'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }
                              _analyzeText();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(Icons.check),
                      label: Text(
                        _isAnalyzing ? 'Analyzing...' : 'Confirm',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
} 