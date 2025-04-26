import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:math' as math;

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
                    const Text(
                      'CerebrumAI',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2B3D).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF4AEDC4).withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: const Text(
                    'Advanced AI-powered medical diagnosis system for accurate and efficient healthcare solutions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
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
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
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

  void _navigateToInputScreens() {
    if (!_isTextSelected && !_isImageSelected && !_isVoiceSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one input method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to the first selected screen
    if (_isTextSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TextInputScreen(),
        ),
      ).then((_) {
        if (_isImageSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ImageInputScreen(),
            ),
          ).then((_) {
            if (_isVoiceSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VoiceInputScreen(),
                ),
              ).then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultsScreen(),
                  ),
                );
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResultsScreen(),
                ),
              );
            }
          });
        } else if (_isVoiceSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VoiceInputScreen(),
            ),
          ).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultsScreen(),
              ),
            );
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResultsScreen(),
            ),
          );
        }
      });
    } else if (_isImageSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ImageInputScreen(),
        ),
      ).then((_) {
        if (_isVoiceSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VoiceInputScreen(),
            ),
          ).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultsScreen(),
              ),
            );
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResultsScreen(),
            ),
          );
        }
      });
    } else if (_isVoiceSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VoiceInputScreen(),
        ),
      ).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultsScreen(),
          ),
        );
      });
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
              const Text(
                'Describe Your Symptoms',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please provide detailed information about your symptoms, including when they started and how they affect you.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _hasError ? Colors.red : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: 10,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Type your symptoms here...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
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

// Image Input Screen
class ImageInputScreen extends StatefulWidget {
  const ImageInputScreen({super.key});

  @override
  State<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends State<ImageInputScreen> {
  bool _hasImage = false;
  bool _hasError = false;

  void _handleSubmit() {
    if (!_hasImage) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.pop(context);
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
              const Text(
                'Upload Medical Images',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                onTap: () {
                  setState(() {
                    _hasImage = true;
                    _hasError = false;
                  });
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _hasError ? Colors.red : Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: _hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://placeholder.com/medical-image',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 64,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tap to upload image',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                ),
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
  final bool _isRecording = false;
  bool _hasRecording = false;
  bool _hasError = false;

  void _handleSubmit() {
    if (!_hasRecording) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please record your voice before proceeding'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultsScreen(),
      ),
    );
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
              const Text(
                'Voice Description',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Record your voice describing your symptoms. Speak clearly and provide as much detail as possible.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _hasRecording = true;
                    _hasError = false;
                  });
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _hasError ? Colors.red : Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _hasRecording ? Icons.play_circle : Icons.mic,
                        size: 64,
                        color: _isRecording ? const Color(0xFFEE1E82) : Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isRecording
                            ? 'Recording...'
                            : _hasRecording
                                ? 'Tap to play recording'
                                : 'Tap to start recording',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_hasError)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please record your voice',
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Increased from 8 seconds to 10 seconds
    )..repeat();

    // Initialize EKG points
    for (int i = 0; i < 100; i++) {
      _ekgPoints.add(0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Update EKG points
          _currentX += 0.02;
          if (_currentX > 1.0) {
            _currentX = 0.0;
          }
          
          // Generate EKG pattern
          double y = 0.0;
          if (_currentX < 0.2) {
            y = 0.0;
          } else if (_currentX < 0.3) {
            y = 1.0;
          } else if (_currentX < 0.4) {
            y = -0.5;
          } else if (_currentX < 0.5) {
            y = 0.5;
          } else if (_currentX < 0.6) {
            y = 0.0;
          } else if (_currentX < 0.7) {
            y = -0.5;
          } else if (_currentX < 0.8) {
            y = 0.5;
          } else {
            y = 0.0;
          }

          _ekgPoints.removeAt(0);
          _ekgPoints.add(y);

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
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final pointWidth = width / points.length;

    // Draw grid lines
    final gridPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 1.0;

    // Vertical grid lines
    for (int i = 0; i < 10; i++) {
      final x = width * (i / 10);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, height),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i < 5; i++) {
      final y = height * (i / 5);
      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
        gridPaint,
      );
    }

    // Draw EKG line
    path.moveTo(0, height / 2);
    for (int i = 0; i < points.length; i++) {
      final x = i * pointWidth;
      final y = height / 2 - points[i] * height / 4;
      path.lineTo(x, y);
    }

    // Add glow effect
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(path, glowPaint);

    // Draw main line
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(EKGPainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.color != color;
  }
}
