import 'package:flutter/material.dart';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';

void main() {
  runApp(const CareCompassApp());
}

class CareCompassApp extends StatelessWidget {
  const CareCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CerebrumAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4AEDC4), // Updated to teal
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4AEDC4), // Updated to teal
          secondary: const Color(0xFF1E2B3D), // Updated to dark blue
        ),
        scaffoldBackgroundColor: const Color(0xFF101520), // Keeping dark background
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Welcome Screen with Enhanced Medical-Technical Design
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin() async {
    setState(() => _isNavigating = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),

          if (_isNavigating)
            const HyperspaceAnimation(child: SizedBox.expand()),

          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                // Logo and Title
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4AEDC4), Color(0xFF1E2B3D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4AEDC4).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.medical_information,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlickeringText(
                          text: 'Cerebrum',
                          baseColor: Colors.white,
                          flickerColor: Color(0xFF4AEDC4),
                        ),
                        FlickeringText(
                          text: 'AI',
                          baseColor: Color(0xFF4AEDC4),
                          flickerColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2B3D).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFF4AEDC4).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'INTELLIGENT MEDICAL ASSISTANT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: Color(0xFF4AEDC4),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
                // Description
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2B3D).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF4AEDC4).withOpacity(0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4AEDC4).withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Text(
                    'Advanced AI-powered medical diagnosis system for accurate and efficient healthcare solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // EKG Animation above Get Started button
                const SizedBox(
                  height: 100,
                  child: EKGAnimation(),
                ),
                const SizedBox(height: 32),
                // Get Started Button
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4AEDC4), Color(0xFF1E2B3D)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4AEDC4).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _navigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Particle {
  final double x = Random().nextDouble();
  final double y = Random().nextDouble();
  final double size = Random().nextDouble() * 2 + 1;
  final double speed = Random().nextDouble() * 0.2 + 0.1;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final x = (particle.x + progress * particle.speed) % 1.0;
      final y = (particle.y + progress * particle.speed * 0.5) % 1.0;
      
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

// Add HyperspaceAnimation class at the top level
class HyperspaceAnimation extends StatefulWidget {
  final Widget child;
  const HyperspaceAnimation({super.key, required this.child});

  @override
  State<HyperspaceAnimation> createState() => _HyperspaceAnimationState();
}

class _HyperspaceAnimationState extends State<HyperspaceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = List.generate(200, (index) => Star());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: HyperspacePainter(
            progress: _controller.value,
            stars: _stars,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class Star {
  final double x = Random().nextDouble() * 2 - 1;
  final double y = Random().nextDouble() * 2 - 1;
  final double z = Random().nextDouble();
  final double size = Random().nextDouble() * 2 + 1;
}

class HyperspacePainter extends CustomPainter {
  final double progress;
  final List<Star> stars;

  HyperspacePainter({required this.progress, required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4AEDC4)
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    for (final star in stars) {
      final z = (star.z + progress) % 1.0;
      final speed = progress * 2;
      
      final sx = star.x / z * speed;
      final sy = star.y / z * speed;
      
      final x = center.dx + sx * center.dx;
      final y = center.dy + sy * center.dy;
      
      final previousZ = (star.z + progress - 0.1) % 1.0;
      final previousSx = star.x / previousZ * speed;
      final previousSy = star.y / previousZ * speed;
      final previousX = center.dx + previousSx * center.dx;
      final previousY = center.dy + previousSy * center.dy;

      paint.strokeWidth = star.size * (1 - z);
      paint.color = const Color(0xFF4AEDC4).withOpacity((1 - z) * 0.8);

      canvas.drawLine(
        Offset(previousX, previousY),
        Offset(x, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(HyperspacePainter oldDelegate) => true;
}

// Login Screen with Brain Animation
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_animationController);

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Ambient glow effect
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4AEDC4).withOpacity(0.2),
                    const Color(0xFF4AEDC4).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          
          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: 1.0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4AEDC4),
                                Color(0xFF1E2B3D),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4AEDC4).withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.medical_services,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const ShimmerGradientText(
                          text: 'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.white70),
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              prefixIcon: const Icon(
                                Icons.email,
                                size: 20,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF4AEDC4),
                                  width: 2,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white70),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 20,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF4AEDC4),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF4AEDC4),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF4AEDC4),
                                  Color(0xFF1E2B3D),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4B39EF).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const InputSelectionScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF4AEDC4),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Forgot Password Screen
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Ambient glow effect
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4AEDC4).withOpacity(0.2),
                    const Color(0xFF4AEDC4).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Enter your email address and we will send you instructions to reset your password.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.white70),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 20,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF4AEDC4),
                                width: 2,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4AEDC4),
                                Color(0xFF1E2B3D),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4B39EF).withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password reset instructions sent to your email'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Send Reset Link',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareCompass'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: 1.0,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 48,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Find a Doctor',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Search for doctors and book appointments',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: 1.0,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildFeatureCard(
                        context,
                        icon: Icons.medical_information,
                        title: 'Medical Records',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFeatureCard(
                        context,
                        icon: Icons.medication,
                        title: 'Medications',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced Input Selection Screen with Brain Animation
class InputSelectionScreen extends StatefulWidget {
  const InputSelectionScreen({super.key});

  @override
  State<InputSelectionScreen> createState() => _InputSelectionScreenState();
}

class _InputSelectionScreenState extends State<InputSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  bool _isTextSelected = false;
  bool _isImageSelected = false;
  bool _isVoiceSelected = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_animationController);

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToInputScreens() async {
    if (!_isTextSelected && !_isImageSelected && !_isVoiceSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one input method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Helper function for navigation with transition
    Future<void> navigateWithTransition(Widget screen, {bool isResultsScreen = false}) async {
      await Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = isResultsScreen 
                ? const Offset(1.0, 0.0)  // Right to left for Results
                : const Offset(0.0, 1.0); // Bottom to top for Input screens
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600), // Slightly longer duration
          reverseTransitionDuration: const Duration(milliseconds: 600),
          opaque: false,
        ),
      );
    }

    try {
      if (_isTextSelected) {
        await navigateWithTransition(const TextInputScreen());
        
        if (_isImageSelected) {
          await navigateWithTransition(const ImageInputScreen());
          
          if (_isVoiceSelected) {
            await navigateWithTransition(const VoiceInputScreen());
            await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
          } else {
            await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
          }
        } else if (_isVoiceSelected) {
          await navigateWithTransition(const VoiceInputScreen());
          await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
        } else {
          await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
        }
      } else if (_isImageSelected) {
        await navigateWithTransition(const ImageInputScreen());
        
        if (_isVoiceSelected) {
          await navigateWithTransition(const VoiceInputScreen());
          await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
        } else {
          await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
        }
      } else if (_isVoiceSelected) {
        await navigateWithTransition(const VoiceInputScreen());
        await navigateWithTransition(const ResultsScreen(), isResultsScreen: true);
      }
    } catch (e) {
      // Handle any navigation errors gracefully
      debugPrint('Navigation error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Select Input Type',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Ambient glow effects
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4AEDC4).withOpacity(0.2),
                    const Color(0xFF4AEDC4).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with shimmer effect
                  const ShimmerText(
                    text: 'Choose Input Method',
                    baseColor: Colors.white,
                    highlightColor: Color(0xFF4AEDC4),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Select one or more ways to describe your condition',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Input options
                  _buildInputOption(
                    icon: Icons.text_fields,
                    title: 'Text Description',
                    description: 'Describe your symptoms in detail',
                    isSelected: _isTextSelected,
                    onTap: () => setState(() => _isTextSelected = !_isTextSelected),
                  ),
                  const SizedBox(height: 20),
                  _buildInputOption(
                    icon: Icons.image,
                    title: 'Image Upload',
                    description: 'Upload clear images of affected areas',
                    isSelected: _isImageSelected,
                    onTap: () => setState(() => _isImageSelected = !_isImageSelected),
                  ),
                  const SizedBox(height: 20),
                  _buildInputOption(
                    icon: Icons.mic,
                    title: 'Voice Recording',
                    description: 'Describe your symptoms verbally',
                    isSelected: _isVoiceSelected,
                    onTap: () => setState(() => _isVoiceSelected = !_isVoiceSelected),
                  ),
                  const SizedBox(height: 40),

                  // Continue Button
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4AEDC4), Color(0xFF1E2B3D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4AEDC4).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _navigateToInputScreens,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputOption({
    required IconData icon,
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSelected
              ? [const Color(0xFF4AEDC4).withOpacity(0.2), const Color(0xFF1E2B3D).withOpacity(0.3)]
              : [const Color(0xFF1E2B3D).withOpacity(0.2), const Color(0xFF1E2B3D).withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF4AEDC4) : const Color(0xFF4AEDC4).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF4AEDC4).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: const Color(0xFF4AEDC4).withOpacity(0.1),
          highlightColor: const Color(0xFF4AEDC4).withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4AEDC4) : const Color(0xFF1E2B3D),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? const Color(0xFF1E2B3D) : const Color(0xFF4AEDC4),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF4AEDC4) : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? const Color(0xFF4AEDC4) : Colors.white54,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Text Input Screen
class TextInputScreen extends StatefulWidget {
  const TextInputScreen({super.key});

  @override
  State<TextInputScreen> createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _hasError = false;

  void _handleSubmit() {
    if (_textController.text.trim().isEmpty) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your symptoms before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ShimmerGradientText(
                text: 'Describe Your Symptoms',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2B3D).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Please provide detailed information about your symptoms',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _hasError ? Colors.red : const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4AEDC4).withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 8,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type your symptoms here...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    errorText: _hasError ? 'Please enter your symptoms' : null,
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  onChanged: (value) {
                    if (_hasError && value.trim().isNotEmpty) {
                      setState(() => _hasError = false);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cross Button
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade400,
                          Colors.red.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _textController.clear();
                          setState(() => _hasError = false);
                        },
                        borderRadius: BorderRadius.circular(35),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Tick Button
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4AEDC4),
                          Color(0xFF2A9D8F),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4AEDC4).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleSubmit,
                        borderRadius: BorderRadius.circular(35),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Image Input Screen
class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key});

  @override
  State<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  bool _hasImage = false;
  bool _hasError = false;
  bool _isScanning = false;
  final List<String> _images = [];

  void _handleSubmit() {
    if (!_hasImage && _images.isEmpty) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload at least one image before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context);
  }

  void _handleImageTap() async {
    setState(() {
      _hasImage = true;
      _hasError = false;
      _isScanning = true;
    });
    
    // Simulate scanning process
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      setState(() {
        _isScanning = false;
        if (!_images.contains('https://placeholder.com/medical-image')) {
          _images.add('https://placeholder.com/medical-image');
        }
      });
    }
  }

  void _handleAddMoreImages() {
    setState(() {
      _images.add('https://placeholder.com/medical-image');
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_images.isEmpty) {
        _hasImage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ShimmerGradientText(
                text: 'Upload Medical Images',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Upload clear images of affected areas or medical reports. You can upload multiple images.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _handleImageTap,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2B3D).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _hasError ? Colors.red : const Color(0xFF4AEDC4).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ScanningFrame(
                      isScanning: _isScanning,
                      child: _hasImage
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                'https://placeholder.com/medical-image',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.transparent,
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.5),
                                    ],
                                    stops: const [0.0, 0.2, 0.8, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 64,
                                color: const Color(0xFF4AEDC4).withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              const ShimmerGradientText(
                                text: 'Tap to capture or upload image',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Additional Images Section
              if (_images.isNotEmpty || _hasImage)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 12),
                      child: Text(
                        'Additional Images',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Add More Button
                          GestureDetector(
                            onTap: _handleAddMoreImages,
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2B3D).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF4AEDC4).withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: const Color(0xFF4AEDC4).withOpacity(0.7),
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Add More',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Image Thumbnails
                          ..._images.asMap().entries.map((entry) {
                            final index = entry.key;
                            final image = entry.value;
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF4AEDC4).withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              
              if (_hasError)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please upload an image',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4AEDC4),
                      Color(0xFF1E2B3D),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4B39EF).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
}

// Voice Input Screen
class VoiceInputScreen extends StatefulWidget {
  const VoiceInputScreen({super.key});

  @override
  State<VoiceInputScreen> createState() => _VoiceInputScreenState();
}

class _VoiceInputScreenState extends State<VoiceInputScreen> {
  bool _isRecording = false;
  String _recordingText = '';
  final List<String> _sampleTexts = [
    'I have been experiencing severe headache and dizziness for the past two days.',
    'My throat is sore and I have a mild fever since yesterday.',
    'I feel shortness of breath when climbing stairs.',
    'I have a persistent cough and runny nose.',
  ];

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingText = '';
    });
  }

  void _stopRecording() {
    if (_isRecording) {
      setState(() {
        _isRecording = false;
        // Simulate voice recording by selecting a random sample text
        _recordingText = _sampleTexts[Random().nextInt(_sampleTexts.length)];
      });
    }
  }

  void _resetRecording() {
    setState(() {
      _recordingText = '';
    });
  }

  void _confirmRecording() {
    if (_recordingText.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const ShimmerGradientText(
                    text: 'Voice Description',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isRecording 
                      ? 'Recording your voice...'
                      : _recordingText.isEmpty 
                        ? 'Press and hold the microphone button to start recording your symptoms'
                        : 'Review your recorded description. Press the green button to proceed or the red button to record again.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  
                  // Text Display Area
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF4AEDC4).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: _recordingText.isEmpty 
                          ? ShimmerGradientText(
                              text: 'Your recording will appear here...',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.3),
                                height: 1.5,
                              ),
                            )
                          : Text(
                              _recordingText,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                height: 1.5,
                              ),
                            ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Control Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Cross Button (Reset)
                      if (_recordingText.isNotEmpty)
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.withOpacity(0.8),
                                Colors.red.shade900,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _resetRecording,
                              borderRadius: BorderRadius.circular(35),
                              child: const Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      // Microphone Button with Glow Effect
                      AvatarGlow(
                        animate: _isRecording,
                        endRadius: 75.0,
                        glowColor: const Color(0xFF4AEDC4),
                        duration: const Duration(milliseconds: 2000),
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Orbital Animation
                            if (!_isRecording) OrbitalAnimation(isRecording: _isRecording),
                            
                            // Microphone Button
                            GestureDetector(
                              onTapDown: (details) => _startRecording(),
                              onTapUp: (details) => _stopRecording(),
                              onTapCancel: () => _stopRecording(),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      _isRecording 
                                        ? const Color(0xFF4AEDC4)
                                        : const Color(0xFF1E2B3D),
                                      _isRecording
                                        ? const Color(0xFF1E2B3D)
                                        : const Color(0xFF4AEDC4),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4AEDC4).withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isRecording ? Icons.mic : Icons.mic_none,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Tick Button (Confirm)
                      if (_recordingText.isNotEmpty)
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4AEDC4),
                                Color(0xFF2A9D8F),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4AEDC4).withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _confirmRecording,
                              borderRadius: BorderRadius.circular(35),
                              child: const Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Instructions Text
                  if (_recordingText.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF4AEDC4).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF4AEDC4),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tap ✓ to confirm or × to record again',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Add this new widget before the VoiceInputScreen class
class OrbitalAnimation extends StatefulWidget {
  final bool isRecording;
  
  const OrbitalAnimation({
    super.key,
    required this.isRecording,
  });

  @override
  State<OrbitalAnimation> createState() => _OrbitalAnimationState();
}

class _OrbitalAnimationState extends State<OrbitalAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer orbit
            Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Middle orbit
            Transform.rotate(
              angle: -_controller.value * 2 * pi * 1.5,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Inner orbit
            Transform.rotate(
              angle: _controller.value * 2 * pi * 2,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.4),
                    width: 2,
                  ),
                ),
              ),
            ),
            // Orbital dots
            ...List.generate(3, (index) {
              final angle = _controller.value * 2 * pi + (index * 2 * pi / 3);
              const radius = 80.0;
              final x = cos(angle) * radius;
              final y = sin(angle) * radius;
              return Transform.translate(
                offset: Offset(x, y),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4AEDC4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4AEDC4).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

// Results Screen
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Analysis Icon with updated gradient
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4AEDC4), Color(0xFF1E2B3D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4AEDC4).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.analytics,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              
              // Disease Summary Section with updated colors
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2B3D).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Disease Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4AEDC4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Based on your symptoms and medical history, the analysis suggests a potential diagnosis of [Disease Name]. This condition typically presents with symptoms similar to what you described.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.warning, 'Severity: Moderate'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.access_time, 'Recommended Action: Immediate Consultation'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Possible Cases Section with updated colors
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2B3D).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Possible Cases',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4AEDC4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCaseItem('Primary Diagnosis', '85% match'),
                    const SizedBox(height: 12),
                    _buildCaseItem('Alternative Diagnosis 1', '65% match'),
                    const SizedBox(height: 12),
                    _buildCaseItem('Alternative Diagnosis 2', '45% match'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.local_hospital,
                      label: 'Nearby Hospitals',
                      onPressed: () {
                        // Navigate to hospitals map
                      },
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.emergency,
                      label: 'Emergency Call',
                      onPressed: () {
                        // Make emergency call
                      },
                      isPrimary: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Navigation Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.home,
                      label: 'Go to Home',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          (route) => false,
                        );
                      },
                      isPrimary: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.add_circle,
                      label: 'New Description',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const InputSelectionScreen()),
                          (route) => false,
                        );
                      },
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF4AEDC4),
          size: 20,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCaseItem(String title, String match) {
    return HoverWidget(
      builder: (isHovered) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: isHovered ? 16 : 12,
          vertical: isHovered ? 12 : 8,
        ),
        decoration: BoxDecoration(
          color: isHovered 
              ? const Color(0xFF4AEDC4).withOpacity(0.1)
              : const Color(0xFF1E2B3D).withOpacity(0.3),
          borderRadius: BorderRadius.circular(isHovered ? 16 : 12),
          border: Border.all(
            color: isHovered
                ? const Color(0xFF4AEDC4)
                : const Color(0xFF4AEDC4).withOpacity(0.2),
            width: isHovered ? 2 : 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF4AEDC4).withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isHovered ? 16 : 14,
                  color: isHovered ? const Color(0xFF4AEDC4) : Colors.white,
                  fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              match,
              style: TextStyle(
                fontSize: isHovered ? 14 : 12,
                color: const Color(0xFF4AEDC4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return HoverWidget(
      builder: (isHovered) => Container(
        height: isHovered ? 65 : 60,
        decoration: BoxDecoration(
          gradient: isPrimary ? LinearGradient(
            colors: [
              isHovered ? const Color(0xFF5FFFD4) : const Color(0xFF4AEDC4),
              isHovered ? const Color(0xFF2E3B4D) : const Color(0xFF1E2B3D),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ) : null,
          color: !isPrimary ? (isHovered 
              ? const Color(0xFF4AEDC4).withOpacity(0.1)
              : const Color(0xFF1E2B3D).withOpacity(0.3)) : null,
          borderRadius: BorderRadius.circular(isHovered ? 16 : 12),
          border: !isPrimary ? Border.all(
            color: isHovered
                ? const Color(0xFF4AEDC4)
                : const Color(0xFF4AEDC4).withOpacity(0.2),
            width: isHovered ? 2 : 1,
          ) : null,
          boxShadow: isPrimary ? [
            BoxShadow(
              color: const Color(0xFF4AEDC4).withOpacity(isHovered ? 0.4 : 0.2),
              blurRadius: isHovered ? 25 : 15,
              offset: Offset(0, isHovered ? 8 : 6),
              spreadRadius: isHovered ? 3 : 1,
            ),
          ] : null,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: isHovered ? 12 : 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isHovered ? 16 : 12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon, 
                color: isPrimary ? Colors.white : const Color(0xFF4AEDC4),
                size: isHovered ? 24 : 20
              ),
              SizedBox(width: isHovered ? 8 : 4),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isHovered ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: isPrimary ? Colors.white : const Color(0xFF4AEDC4),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_animationController);

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101520),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF101520),
                  const Color(0xFF1E2B3D).withOpacity(0.8),
                ],
              ),
            ),
          ),
          
          // Ambient glow effect
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4AEDC4).withOpacity(0.2),
                    const Color(0xFF4AEDC4).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header with Icon
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: 1.0,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4AEDC4),
                                Color(0xFF1E2B3D),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4AEDC4).withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_add,
                            size: 64,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Join our medical AI community',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Sign Up Form
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: 1.0,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Full Name Field
                          HoverWidget(
                            builder: (isHovered) => TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: const TextStyle(color: Colors.white70),
                                hintText: 'Enter your full name',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: isHovered ? 24 : 20,
                                  color: Colors.white70,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF4AEDC4),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          HoverWidget(
                            builder: (isHovered) => TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.white70),
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: isHovered ? 24 : 20,
                                  color: Colors.white70,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF4AEDC4),
                                    width: 2,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          HoverWidget(
                            builder: (isHovered) => TextField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  size: isHovered ? 24 : 20,
                                  color: Colors.white70,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF4AEDC4),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password Field
                          HoverWidget(
                            builder: (isHovered) => TextField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                hintText: 'Confirm your password',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  size: isHovered ? 24 : 20,
                                  color: Colors.white70,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF4AEDC4),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Sign Up Button
                          HoverWidget(
                            builder: (isHovered) => Container(
                              height: isHovered ? 65 : 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    isHovered ? const Color(0xFF6B59FF) : const Color(0xFF4B39EF),
                                    isHovered ? const Color(0xFFFF3E92) : const Color(0xFFEE1E82),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(isHovered ? 16 : 12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4B39EF).withOpacity(isHovered ? 0.7 : 0.4),
                                    blurRadius: isHovered ? 25 : 15,
                                    offset: Offset(0, isHovered ? 8 : 6),
                                    spreadRadius: isHovered ? 3 : 1,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle sign up logic
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const InputSelectionScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isHovered ? 16 : 12),
                                  ),
                                ),
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: isHovered ? 20 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      HoverWidget(
                        builder: (isHovered) => TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: const Color(0xFF4AEDC4),
                              fontWeight: FontWeight.w600,
                              fontSize: isHovered ? 17 : 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Shimmer Text Effect Widget
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Color baseColor;
  final Color highlightColor;
  
  const ShimmerText({
    Key? key,
    required this.text,
    required this.style,
    required this.baseColor,
    required this.highlightColor,
  }) : super(key: key);
  
  @override
  _ShimmerTextState createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  
  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            widget.baseColor,
            widget.highlightColor,
            widget.baseColor,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: AnimatedBuilder(
        animation: _shimmerController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0.0,
              4.0 * sin(_shimmerController.value * 2 * pi),
            ),
            child: child,
          );
        },
        child: Text(
          widget.text,
          style: widget.style,
        ),
      ),
    );
  }
}

// Pulse Animation Widget for buttons
class PulseAnimationWidget extends StatefulWidget {
  final Widget child;
  
  const PulseAnimationWidget({
    super.key,
    required this.child,
  });
  
  @override
  State<PulseAnimationWidget> createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}

// Hover Animation Widget
class HoverWidget extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final Duration duration;

  const HoverWidget({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeInOut,
        transform: Matrix4.identity()
          ..scale(isHovered ? 1.1 : 1.0)
          ..translate(0.0, isHovered ? -5.0 : 0.0),
        child: widget.builder(isHovered),
      ),
    );
  }
}

// Replace BrainAnimation classes with EKGAnimation
class EKGAnimation extends StatefulWidget {
  const EKGAnimation({super.key});

  @override
  _EKGAnimationState createState() => _EKGAnimationState();
}

class _EKGAnimationState extends State<EKGAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _ekgPoints = [];
  double _currentX = 0;
  final int _totalPoints = 150;  // Increased points for smoother animation

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),  // Faster animation for more realistic effect
    )..repeat();

    // Initialize EKG points
    for (int i = 0; i < _totalPoints; i++) {
      _ekgPoints.add(0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Generate a single EKG beat pattern
  double _generateEKGPoint(double x) {
    // Normalize x to 0-1 range for one complete beat
    double normalizedX = (x % 0.4); // Reduced from 1.0 to 0.4 to show more peaks
    
    // Initial flat segment
    if (normalizedX < 0.04) {
      return 0.0;
    }
    // Sharp upward spike (R wave)
    else if (normalizedX < 0.06) {
      return 1.5 * (normalizedX - 0.04) / 0.02;  // Sharp upward line
    }
    // Sharp downward spike (S wave)
    else if (normalizedX < 0.08) {
      return 1.5 - 3.0 * (normalizedX - 0.06) / 0.02;  // Sharp downward line
    }
    // Return to baseline with small bump
    else if (normalizedX < 0.10) {
      return -1.5 + 1.8 * (normalizedX - 0.08) / 0.02;  // Return to baseline
    }
    // Small secondary wave
    else if (normalizedX < 0.14) {
      return 0.3 * sin((normalizedX - 0.10) * pi * 10);
    }
    // Flat baseline until next beat
    else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Update EKG points
          _currentX += 0.008; // Slightly faster to match more frequent peaks
          if (_currentX > 1.0) {
            _currentX = 0.0;
          }

          _ekgPoints.removeAt(0);
          _ekgPoints.add(_generateEKGPoint(_currentX));

          return CustomPaint(
            painter: EKGPainter(
              points: List.from(_ekgPoints),
              color: const Color(0xFF4AEDC4),
            ),
          );
        },
      ),
    );
  }
}

class EKGPainter extends CustomPainter {
  final List<double> points;
  final Color color;

  EKGPainter({
    required this.points,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5  // Slightly thicker line
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final pointWidth = width / points.length;
    final midHeight = height / 2;

    // Draw the EKG line
    path.moveTo(0, midHeight + (points[0] * height / 4));
    
    for (int i = 1; i < points.length; i++) {
      final x = i * pointWidth;
      final y = midHeight + (points[i] * height / 4);
      path.lineTo(x, y);  // Using lineTo for sharper peaks instead of quadratic curves
    }

    // Add subtle glow effect
    final glowPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);

    // Draw grid lines with very low opacity
    final gridPaint = Paint()
      ..color = color.withOpacity(0.05)
      ..strokeWidth = 1.0;

    // Vertical grid lines
    for (int i = 0; i < width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), height),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i < height; i += 20) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(width, i.toDouble()),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(EKGPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.color != color;
  }
}

// Add this new painter class at the bottom of the file
class NeonLinePainter extends CustomPainter {
  final Color color;

  NeonLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

    // Draw diagonal lines
    for (int i = 0; i < 5; i++) {
      final path = Path();
      path.moveTo(size.width * (i / 4), 0);
      path.lineTo(size.width * ((i + 1) / 4), size.height);
      canvas.drawPath(path, paint);
    }

    // Draw horizontal lines
    for (int i = 0; i < 4; i++) {
      final path = Path();
      path.moveTo(0, size.height * (i / 3));
      path.lineTo(size.width, size.height * (i / 3));
      canvas.drawPath(path, paint);
    }

    // Draw glowing dots at intersections
    final dotPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 4; j++) {
        canvas.drawCircle(
          Offset(
            size.width * (i / 4),
            size.height * (j / 3),
          ),
          2,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant NeonLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class AnimatedNeonBox extends StatefulWidget {
  final Widget child;
  
  const AnimatedNeonBox({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedNeonBox> createState() => _AnimatedNeonBoxState();
}

class _AnimatedNeonBoxState extends State<AnimatedNeonBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.1,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2B3D).withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4AEDC4).withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              // Primary glow
              BoxShadow(
                color: const Color(0xFF4AEDC4).withOpacity(_glowAnimation.value),
                blurRadius: 20,
                spreadRadius: 1,
              ),
              // Secondary pulsing glow
              BoxShadow(
                color: const Color(0xFF4AEDC4).withOpacity(_glowAnimation.value * 0.5),
                blurRadius: 30,
                spreadRadius: 2,
              ),
              // Outer ambient glow
              BoxShadow(
                color: const Color(0xFF4AEDC4).withOpacity(_glowAnimation.value * 0.25),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background sparkle effects
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF4AEDC4).withOpacity(_glowAnimation.value),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF4AEDC4).withOpacity(_glowAnimation.value * 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Animated neon lines
              Positioned.fill(
                child: CustomPaint(
                  painter: NeonLinePainter(
                    color: const Color(0xFF4AEDC4),
                  ),
                ),
              ),
              // Main content with padding
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Add this new widget class before the AnimatedNeonBox class
class FlickeringText extends StatefulWidget {
  final String text;
  final Color baseColor;
  final Color flickerColor;

  const FlickeringText({
    super.key,
    required this.text,
    required this.baseColor,
    required this.flickerColor,
  });

  @override
  State<FlickeringText> createState() => _FlickeringTextState();
}

class _FlickeringTextState extends State<FlickeringText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flickerAnimation;
  late Animation<double> _sizeAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _flickerAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 45.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 45.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: 10.0,
      ),
    ]).animate(_controller);

    _sizeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50.0,
      ),
    ]).animate(_controller);

    _startRandomAnimation();
  }

  void _startRandomAnimation() {
    Future.delayed(Duration(milliseconds: _random.nextInt(2000) + 1000), () {
      if (mounted) {
        _controller.forward(from: 0.0).then((_) {
          if (mounted) {
            _startRandomAnimation();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _sizeAnimation.value,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Color.lerp(
                widget.baseColor,
                widget.flickerColor,
                _flickerAnimation.value,
              ),
              shadows: [
                Shadow(
                  color: widget.flickerColor.withOpacity(_flickerAnimation.value * 0.7),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
                Shadow(
                  color: widget.flickerColor.withOpacity(_flickerAnimation.value * 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Add this new widget class before the AnimatedNeonBox class
class ShimmerGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ShimmerGradientText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<ShimmerGradientText> createState() => _ShimmerGradientTextState();
}

class _ShimmerGradientTextState extends State<ShimmerGradientText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0xFF4AEDC4),  // Teal
                Colors.white,
                Color(0xFF4AEDC4),  // Teal
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_animation.value * 2 * pi),
            ).createShader(bounds);
          },
          child: Stack(
            children: [
              // Shadow layer
              Transform.translate(
                offset: const Offset(2, 2),
                child: Text(
                  widget.text,
                  style: widget.style.copyWith(
                    color: Colors.black12,
                  ),
                ),
              ),
              // Main text
              Text(
                widget.text,
                style: widget.style.copyWith(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: const Color(0xFF4AEDC4).withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                    Shadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ScanningFrame extends StatefulWidget {
  final bool isScanning;
  final Widget child;

  const ScanningFrame({
    super.key,
    required this.isScanning,
    required this.child,
  });

  @override
  State<ScanningFrame> createState() => _ScanningFrameState();
}

class _ScanningFrameState extends State<ScanningFrame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        widget.child,

        // Corner brackets
        ...List.generate(4, (index) {
          final isTop = index < 2;
          final isLeft = index.isEven;
          return Positioned(
            top: isTop ? 0 : null,
            bottom: !isTop ? 0 : null,
            left: isLeft ? 0 : null,
            right: !isLeft ? 0 : null,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isTop ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  bottom: BorderSide(
                    color: !isTop ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  left: BorderSide(
                    color: isLeft ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  right: BorderSide(
                    color: !isLeft ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
            ),
          );
        }),

        // Scanning animation
        if (widget.isScanning)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: _animation.value * 300,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF4AEDC4).withOpacity(0.8),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4AEDC4).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        // "Scanning..." text
        if (widget.isScanning)
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFF4AEDC4).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFF4AEDC4),
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    ShimmerGradientText(
                      text: 'SCANNING...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

