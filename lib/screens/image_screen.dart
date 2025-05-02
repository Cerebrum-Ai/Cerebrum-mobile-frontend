import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../theme_provider.dart';
import '../models/analysis_result.dart';

class ImageScreen extends StatefulWidget {
  final Function(AnalysisResult) onComplete;

  const ImageScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> with SingleTickerProviderStateMixin {
  bool _isAnalyzing = false;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  late AnimationController _shimmerController;
  bool _showQuickActions = false;

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

  Future<bool> _requestPermissions(ImageSource source) async {
    if (source == ImageSource.camera) {
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) return false;
      
      // For saving images we also need storage permission
      if (Platform.isAndroid) {
        final storageStatus = await Permission.storage.request();
        return storageStatus.isGranted;
      }
      return true;
    } else {
      if (Platform.isAndroid) {
        // For Android 13 and above
        if (await Permission.photos.request().isGranted) {
          return true;
        }
        // For older Android versions
        final storageStatus = await Permission.storage.request();
        return storageStatus.isGranted;
      }
      return true;
    }
  }

  void _toggleQuickActions() {
    setState(() {
      _showQuickActions = !_showQuickActions;
    });
  }

  Future<void> _openGallery() async {
    final hasPermission = await _requestPermissions(ImageSource.gallery);
    if (!hasPermission) {
      if (mounted) {
        // Show settings option if permission is permanently denied
        final showRationale = await Permission.photos.shouldShowRequestRationale;
        final message = showRationale
            ? 'Storage permission is required to select images'
            : 'Storage permission was denied. Please enable it in settings.';
            
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            action: !showRationale
                ? SnackBarAction(
                    label: 'Settings',
                    onPressed: () => openAppSettings(),
                  )
                : null,
          ),
        );
      }
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (image != null && mounted) {
        final file = File(image.path);
        if (await file.exists()) {
          setState(() {
            _selectedImages.add(file);
          });
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error: Selected image file not found'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _openCamera() async {
    try {
      print('Starting camera...');
      
      // Check if we're running in an emulator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening camera...'),
            duration: Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
        maxWidth: 1800,
        maxHeight: 1800,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Camera timed out. Please try again.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return null;
        },
      );

      print('Camera result: ${photo != null ? 'Photo captured' : 'No photo taken'}');

      if (photo != null && mounted) {
        final file = File(photo.path);
        print('Photo path: ${file.path}');
        
        if (await file.exists()) {
          print('Photo file exists, adding to list');
          setState(() {
            _selectedImages.add(file);
          });
          
          // Show success message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Photo captured successfully'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } else {
          print('Photo file does not exist');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error: Captured image file not found'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      }
    } catch (e, stackTrace) {
      print('Error capturing image: $e');
      print('Stack trace: $stackTrace');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera error: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Try Again',
              onPressed: _openCamera,
            ),
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _analyzeImages() {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one image'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate image analysis with a delay
    Future.delayed(const Duration(seconds: 2), () {
      final result = AnalysisResult(
        type: 'image',
        data: {
          'summary': 'Multiple image analysis complete. Here are the key findings from your images.',
          'details': [
            {
              'description': 'Images Analyzed',
              'value': '${_selectedImages.length}'
            },
            {
              'description': 'Image Quality',
              'value': 'Good'
            },
            {
              'description': 'Objects Detected',
              'value': '${_selectedImages.length * 2}'
            },
            {
              'description': 'Confidence Score',
              'value': '85%'
            }
          ],
          'imagePaths': _selectedImages.map((file) => file.path).toList(),
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Bar with Shimmer Title
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
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
                            'Image Analysis',
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
                  const SizedBox(width: 40), // To balance the back button
                ],
              ),
              const SizedBox(height: 16),
              // Description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                  ),
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
                        'Upload multiple medical images, X-rays, or visual symptoms. Our AI will analyze all images to provide comprehensive insights.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.75),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Image Grid or Picker
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Take a Photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _openCamera();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Choose from Gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _openGallery();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    child: _selectedImages.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 64,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tap anywhere to add images',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: _selectedImages.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.surface,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.file(
                                            _selectedImages[index],
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 48,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () => _removeImage(index),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.error.withOpacity(0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              size: 16,
                                              color: theme.colorScheme.onError,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              // Add text overlay for adding more images
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate_outlined,
                                          size: 20,
                                          color: theme.colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Tap anywhere to add more images',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Analyze Button
              ElevatedButton(
                onPressed: _isAnalyzing ? null : _analyzeImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  _isAnalyzing ? 'Analyzing...' : 'Analyze Images',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
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