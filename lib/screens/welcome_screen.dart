import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late AnimationController _transitionController;
  late AnimationController _continuousController;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _contentOpacityAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _titleFadeAnimation;
  bool _showContinuousAnimations = false;

  @override
  void initState() {
    super.initState();
    // Controller for the initial transition animation
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Controller for continuous animations after transition
    _continuousController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Initial transition animations
    _logoPositionAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _transitionController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _transitionController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    ));

    // Continuous animations
    _logoScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _continuousController,
      curve: Curves.easeInOut,
    ));

    _titleFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _continuousController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
    ));

    // Start sequence
    Future.delayed(const Duration(seconds: 2), () {
      _transitionController.forward().then((_) {
        setState(() {
          _showContinuousAnimations = true;
        });
        _continuousController.repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    _transitionController.dispose();
    _continuousController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = themeProvider.currentTheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.14),
              theme.colorScheme.secondary.withOpacity(0.10),
              theme.scaffoldBackgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar with transparent background and shadow
              if (_contentOpacityAnimation.value > 0)
                Opacity(
                  opacity: _contentOpacityAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 8.0),
                          child: IconButton(
                            icon: Icon(
                              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                              color: theme.colorScheme.primary,
                              size: 28,
                            ),
                            onPressed: () {
                              themeProvider.toggleTheme();
                            },
                            splashRadius: 24,
                            tooltip: 'Toggle Theme',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              AnimatedBuilder(
                animation: _transitionController,
                builder: (context, child) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: Tween<double>(
                        begin: (screenHeight - 400) / 2, // Center position
                        end: 20.0, // Final top position
                      ).evaluate(_logoPositionAnimation),
                    ),
                    child: Column(
                      children: [
                        // Animated Logo and Title Section
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _showContinuousAnimations ? _continuousController : _transitionController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _showContinuousAnimations ? _logoScaleAnimation.value : 1.0,
                                    child: Container(
                                      width: 110,
                                      height: 110,
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
                                            color: theme.colorScheme.primary.withOpacity(0.24),
                                            blurRadius: 32,
                                            spreadRadius: 8,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.medical_services_outlined,
                                          size: 58,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: theme.colorScheme.secondary.withOpacity(0.25),
                                              blurRadius: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 28),
                              FadeTransition(
                                opacity: _showContinuousAnimations ? _titleFadeAnimation : const AlwaysStoppedAnimation(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cerebrum',
                                      style: theme.textTheme.displayLarge?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 44,
                                        letterSpacing: 1.4,
                                        shadows: [
                                          Shadow(
                                            color: theme.colorScheme.primary.withOpacity(0.10),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'AI',
                                      style: theme.textTheme.displayLarge?.copyWith(
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 44,
                                        letterSpacing: 1.4,
                                        shadows: [
                                          Shadow(
                                            color: theme.colorScheme.secondary.withOpacity(0.18),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_contentOpacityAnimation.value > 0) ...[
                                const SizedBox(height: 18),
                                Opacity(
                                  opacity: _contentOpacityAnimation.value,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          theme.colorScheme.primary.withOpacity(0.18),
                                          theme.colorScheme.secondary.withOpacity(0.10),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: theme.colorScheme.primary.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'INTELLIGENT MEDICAL ASSISTANT',
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: theme.colorScheme.primary,
                                        letterSpacing: 1.4,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (_contentOpacityAnimation.value > 0) ...[
                const Spacer(flex: 1),
                // Description Text
                Opacity(
                  opacity: _contentOpacityAnimation.value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32.0),
                    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.13),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'Advanced AI-powered medical diagnosis system\nfor accurate and efficient healthcare solutions',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                        fontSize: 17,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                // Heartbeat Animation
                SizedBox(
                  height: 40,
                  child: AnimatedBuilder(
                    animation: _showContinuousAnimations ? _continuousController : _transitionController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: HeartbeatPainter(
                          color: theme.colorScheme.primary,
                          progress: _showContinuousAnimations ? _continuousController.value : 0,
                        ),
                        size: const Size(double.infinity, 40),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 38),
                // Get Started Button
                Opacity(
                  opacity: _contentOpacityAnimation.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            LoginScreen.route(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 6,
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          minimumSize: const Size(0, 60),
                          shadowColor: theme.colorScheme.primary.withOpacity(0.22),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'GET STARTED',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.4,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: theme.colorScheme.onPrimary,
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class HeartbeatPainter extends CustomPainter {
  final Color color;
  final double progress;

  HeartbeatPainter({
    required this.color,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final patternWidth = size.width * 0.15;
    final xOffset = -patternWidth * progress;
    path.moveTo(0, size.height / 2);
    double x = xOffset;
    while (x < size.width + patternWidth) {
      x = drawHeartbeatPattern(path, x, size.height / 2, patternWidth);
    }
    canvas.drawPath(path, paint);
  }

  double drawHeartbeatPattern(Path path, double x, double baseY, double width) {
    final segmentWidth = width / 6;
    x += segmentWidth;
    path.lineTo(x, baseY);
    x += segmentWidth * 0.2;
    path.lineTo(x, baseY - (segmentWidth * 1.2));
    x += segmentWidth * 0.2;
    path.lineTo(x, baseY + (segmentWidth * 0.6));
    x += segmentWidth * 0.2;
    path.lineTo(x, baseY);
    x += segmentWidth * 1.4;
    path.lineTo(x, baseY);
    return x;
  }

  @override
  bool shouldRepaint(covariant HeartbeatPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
} 