import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/analysis_result.dart';
import '../services/api_service.dart';
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
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _errorMessage = '';
  Map<String, dynamic>? _analysisData;

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

    // Fetch analysis data
    _fetchAnalysisData();
  }

  Future<void> _fetchAnalysisData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      Map<String, dynamic> response;
      
      switch (widget.result.type) {
        case 'chat':
          response = await _apiService.chat(widget.result.data['question'] ?? '');
          break;
        case 'ml':
          response = await _apiService.processML(
            url: widget.result.data['url'] ?? '',
            dataType: widget.result.data['data_type'] ?? '',
            model: widget.result.data['model'] ?? '',
          );
          break;
        case 'workflow':
          response = await _apiService.processWorkflow(
            model: widget.result.data['model'] ?? '',
            data: widget.result.data['data'] ?? {},
          );
          break;
        case 'combined':
          response = await _apiService.processCombined(
            question: widget.result.data['question'] ?? '',
            image: widget.result.data['image'],
            audio: widget.result.data['audio'],
            keystrokes: (widget.result.data['keystrokes'] as List<dynamic>?)?.map((k) => Map<String, dynamic>.from(k)).toList(),
          );
          break;
        default:
          // For unknown types, just display the raw data
          response = widget.result.data;
      }

      if (!mounted) return;

      setState(() {
        _analysisData = response;
        _isLoading = false;
      });
      
      print('API Response: $_analysisData');
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getResultText() {
    if (_analysisData == null) return 'No results available';
    
    // Handle the new API response format
    if (_analysisData!['analysis'] != null) {
      final analysis = _analysisData!['analysis'];
      final finalAnalysis = analysis['final_analysis'] ?? '';
      final initialDiagnosis = analysis['initial_diagnosis'] ?? '';
      final vectordbResults = analysis['vectordb_results'] ?? '';
      
      return '$finalAnalysis\n\nInitial Diagnosis: $initialDiagnosis\n\nRelated Conditions:\n$vectordbResults';
    }
    
    // Fallback to old format
    return _analysisData!['summary'] ??
           _analysisData!['result'] ??
           _analysisData!['message'] ??
           _analysisData!['response'] ??
           _analysisData!['content'] ??
           (_analysisData!['data']?['content']) ??
           'No results available';
  }

  String? _getSeverity() {
    if (_analysisData == null) return null;
    
    // Check for severity in the analysis
    if (_analysisData!['analysis'] != null) {
      final analysis = _analysisData!['analysis'];
      final finalAnalysis = analysis['final_analysis'] ?? '';
      
      // Look for severity indicators in the analysis
      if (finalAnalysis.toLowerCase().contains('severe')) {
        return 'High';
      } else if (finalAnalysis.toLowerCase().contains('moderate')) {
        return 'Moderate';
      } else if (finalAnalysis.toLowerCase().contains('mild')) {
        return 'Low';
      }
    }
    
    // Fallback to old format
    return _analysisData!['severity'] ?? 
           _analysisData!['risk_level'] ?? 
           _analysisData!['confidence']?.toString();
  }

  String? _getRecommendation() {
    if (_analysisData == null) return null;
    
    // Check for recommendations in the analysis
    if (_analysisData!['analysis'] != null) {
      final analysis = _analysisData!['analysis'];
      final finalAnalysis = analysis['final_analysis'] ?? '';
      
      // Extract treatment recommendations
      if (finalAnalysis.contains('Treatment:')) {
        final parts = finalAnalysis.split('Treatment:');
        if (parts.length > 1) {
          return parts[1].trim();
        }
      }
    }
    
    // Fallback to old format
    return _analysisData!['recommendation'] ?? 
           _analysisData!['suggestion'] ?? 
           _analysisData!['next_steps'];
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
                          // Analysis Results Card
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
                                      'Analysis Results',
                                      style: theme.textTheme.titleLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                if (_isLoading)
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                else if (_errorMessage.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Error: $_errorMessage',
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                else
                                  _buildAnalysisContent(theme),
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

  Widget _buildAnalysisContent(ThemeData theme) {
    if (_analysisData == null) {
      return Text(
        'No results available',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
      );
    }

    if (_analysisData!['analysis'] != null) {
      final analysis = _analysisData!['analysis'];
      final finalAnalysis = analysis['final_analysis'] ?? '';
      final initialDiagnosis = analysis['initial_diagnosis'] ?? '';
      final vectordbResults = analysis['vectordb_results'] ?? '';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Final Analysis Section
          _buildSection(
            theme,
            title: 'Final Analysis',
            contentWidget: _buildFormattedFinalAnalysis(theme, finalAnalysis),
            icon: Icons.analytics_outlined,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 20),
          
          // Initial Diagnosis Section
          _buildSection(
            theme,
            title: 'Initial Diagnosis',
            contentWidget: _buildFormattedInitialDiagnosis(theme, initialDiagnosis),
            icon: Icons.medical_services_outlined,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          
          // Related Conditions Section
          _buildSection(
            theme,
            title: 'Related Conditions',
            contentWidget: _buildFormattedRelatedConditions(theme, vectordbResults),
            icon: Icons.health_and_safety_outlined,
            color: Colors.green,
          ),
        ],
      );
    }

    // Fallback to old format
    final result = _analysisData!['summary'] ??
                  _analysisData!['result'] ??
                  _analysisData!['message'] ??
                  _analysisData!['response'] ??
                  _analysisData!['content'] ??
                  (_analysisData!['data']?['content']) ??
                  'No results available';

    return _buildSection(
      theme,
      title: 'Analysis Results',
      contentWidget: _buildSimpleTextContent(theme, result),
      icon: Icons.analytics_outlined,
      color: theme.colorScheme.primary,
    );
  }

  Widget _buildSection(
    ThemeData theme, {
    required String title,
    required Widget contentWidget,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          contentWidget,
        ],
      ),
    );
  }

  Widget _buildSimpleTextContent(ThemeData theme, String content) {
    return Text(
      content,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.8),
        height: 1.5,
      ),
    );
  }

  Widget _buildFormattedFinalAnalysis(ThemeData theme, String content) {
    if (content.isEmpty) return _buildSimpleTextContent(theme, 'N/A');

    final lines = content.split('\n');
    final formattedWidgets = <Widget>[];

    for (final line in lines) {
      if (line.contains(': ')) {
        final parts = line.split(': ');
        if (parts.length > 1) {
          formattedWidgets.add(RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${parts[0]}: ',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: parts.sublist(1).join(': '),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ));
        } else {
          formattedWidgets.add(_buildSimpleTextContent(theme, line));
        }
      } else {
        formattedWidgets.add(_buildSimpleTextContent(theme, line));
      }
    }

    if (formattedWidgets.isEmpty && content.isNotEmpty) {
       return _buildSimpleTextContent(theme, content); // Fallback if parsing fails
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: formattedWidgets,
    );
  }

  Widget _buildFormattedInitialDiagnosis(ThemeData theme, String content) {
     if (content.isEmpty) return _buildSimpleTextContent(theme, 'N/A');

     // Try splitting by comma, but if that results in no items, display the raw content as a fallback.
     final items = content.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();

     if (items.isEmpty) {
       // If splitting by comma didn't yield any items, display the content as a single item or simple text.
       return _buildSimpleTextContent(theme, content);
     }

     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: items.map((item) => Padding(
         padding: const EdgeInsets.only(bottom: 4.0),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('• ', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8), height: 1.5)),
             Expanded(
               child: Text(
                 item,
                 style: theme.textTheme.bodyLarge?.copyWith(
                   color: theme.colorScheme.onSurface.withOpacity(0.8),
                   fontWeight: FontWeight.w500,
                   height: 1.5,
                 ),
               ),
             ),
           ],
         ),
       )).toList(),
     );
  }

  Widget _buildFormattedRelatedConditions(ThemeData theme, String content) {
     if (content.isEmpty) return _buildSimpleTextContent(theme, 'N/A');

     // Split by comma, handle potential quotes and extra spaces
     final items = content
         .split(',')
         .map((item) => item.trim().replaceAll('"', '')) // Remove quotes and trim
         .where((item) => item.isNotEmpty) // Filter out empty items
         .toList();

     if (items.isEmpty) return _buildSimpleTextContent(theme, content);

     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: items.map((item) => Padding(
         padding: const EdgeInsets.only(bottom: 4.0),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('• ', style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8), height: 1.5)),
             Expanded(
               child: Text(
                 item,
                 style: theme.textTheme.bodyLarge?.copyWith(
                   color: theme.colorScheme.onSurface.withOpacity(0.8),
                   fontWeight: FontWeight.w500,
                   height: 1.5,
                 ),
               ),
             ),
           ],
         ),
       )).toList(),
     );
  }
}