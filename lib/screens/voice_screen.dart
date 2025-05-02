import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../models/analysis_result.dart';

class VoiceScreen extends StatefulWidget {
  final Function(AnalysisResult) onComplete;

  const VoiceScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> with TickerProviderStateMixin {
  bool _isRecording = false;
  bool _isAnalyzing = false;
  int _recordingDuration = 0;
  Timer? _timer;
  late AnimationController _shimmerController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _recordingDuration = 0;
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopTimer();
      setState(() {
        _isRecording = false;
        _isAnalyzing = true;
      });

      // Simulate voice analysis with a delay
      Future.delayed(const Duration(seconds: 2), () {
        final result = AnalysisResult(
          type: 'voice',
          data: {
            'summary': 'Voice analysis complete. Here are the key findings from your recording.',
            'details': [
              {
                'description': 'Recording Duration',
                'value': '${_recordingDuration}s'
              },
              {
                'description': 'Voice Clarity',
                'value': 'Good'
              },
              {
                'description': 'Background Noise',
                'value': 'Low'
              },
              {
                'description': 'Confidence Score',
                'value': '90%'
              }
            ],
            'recordingDuration': _recordingDuration,
          },
        );
        widget.onComplete(result);
      });
    } else {
      setState(() {
        _isRecording = true;
        _recordingDuration = 0;
      });
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shimmerController.dispose();
    _waveController.dispose();
    super.dispose();
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
                        'Voice Analysis',
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
                        'Record your voice describing your symptoms or concerns. Our AI will analyze your speech patterns and content to provide medical insights.',
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
              const Spacer(),
              // Animated Mic & Recording Waves
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isRecording)
                      AnimatedBuilder(
                        animation: _waveController,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(160, 160),
                            painter: WavePainter(
                              color: theme.colorScheme.primary.withOpacity(0.28),
                              progress: _waveController.value,
                            ),
                          );
                        },
                      ),
                    Container(
                      decoration: BoxDecoration(
                        color: _isRecording
                            ? theme.colorScheme.primary.withOpacity(0.18)
                            : theme.cardColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(_isRecording ? 0.25 : 0.10),
                            blurRadius: _isRecording ? 32 : 12,
                            spreadRadius: _isRecording ? 6 : 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isRecording ? Icons.mic : Icons.mic_none,
                        size: 72,
                        color: _isRecording
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Timer and Status
              if (_isRecording || _recordingDuration > 0)
                Text(
                  _formatDuration(_recordingDuration),
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 6),
              Text(
                _isRecording
                    ? 'Recording...'
                    : _isAnalyzing
                        ? 'Analyzing...'
                        : 'Tap to Start Recording',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Action Buttons
              Row(
                children: [
                  if (_isRecording || _recordingDuration > 0) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isAnalyzing
                            ? null
                            : () {
                                if (_isRecording) {
                                  _stopTimer();
                                }
                                setState(() {
                                  _isRecording = false;
                                  _recordingDuration = 0;
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
                  ],
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isAnalyzing
                          ? null
                          : () {
                              if (!_isRecording && _recordingDuration == 0) {
                                // Start recording
                                setState(() {
                                  _isRecording = true;
                                  _recordingDuration = 0;
                                });
                                _startTimer();
                              } else {
                                // Stop recording and analyze
                                _toggleRecording();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isRecording
                            ? theme.colorScheme.error.withOpacity(0.13)
                            : theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: Icon(_isRecording
                          ? Icons.stop
                          : (_recordingDuration > 0 ? Icons.check : Icons.mic)),
                      label: Text(
                        _isAnalyzing
                            ? 'Analyzing...'
                            : (_isRecording
                                ? 'Stop Recording'
                                : (_recordingDuration > 0
                                    ? 'Confirm'
                                    : 'Start Recording')),
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

// Animated voice wave painter for recording animation
class WavePainter extends CustomPainter {
  final Color color;
  final double progress;

  WavePainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 40.0 + (progress * 20.0);

    // Draw multiple circles with different opacities
    for (var i = 0; i < 3; i++) {
      final waveProgress = (progress + (i * 0.2)) % 1.0;
      final waveRadius = radius + (i * 20.0);
      final waveOpacity = 1.0 - (i * 0.2);

      paint.color = color.withOpacity(waveOpacity);
      canvas.drawCircle(
        center,
        waveRadius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
} 