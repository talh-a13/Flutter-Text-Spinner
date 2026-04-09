import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../models/spinner_model.dart';
import '../components/torch_overlay.dart';
import 'spinner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  final HomeViewModel _viewModel = HomeViewModel();

  late AnimationController _fadeController;
  late AnimationController _glowController;
  late AnimationController _staggerController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _taglineAnimation;
  late Animation<double> _subtitleAnimation;
  late Animation<double> _fieldAnimation;
  late Animation<double> _ctaAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _glowAnimation = CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    );

    _taglineAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    _subtitleAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
    );

    _fieldAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
    );

    _ctaAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );

    _viewModel.addListener(() {
      if (mounted) setState(() {});
    });

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _glowController.dispose();
    _staggerController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _navigate() {
    FocusManager.instance.primaryFocus?.unfocus();
    final model = SpinnerModel(text: _viewModel.textController.text);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SpinnerScreen(model: model),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canNavigate = _viewModel.canNavigate;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    _buildHeroCenterpiece(),

                    const SizedBox(height: 48),

                    _buildStaggeredText(),

                    const SizedBox(height: 40),

                    _buildInputField(),

                    const SizedBox(height: 28),

                    _buildCTAButton(canNavigate),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCenterpiece() {
    return Center(
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          final glowOpacity = 0.4 + (_glowAnimation.value * 0.4);
          final glowSpread = 12.0 + (_glowAnimation.value * 20.0);
          final glowBlur = 24.0 + (_glowAnimation.value * 30.0);

          return Hero(
            tag: 'spinner_logo',
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF111111),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: glowOpacity * 0.15),
                    blurRadius: glowBlur,
                    spreadRadius: glowSpread * 0.3,
                  ),
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: glowOpacity * 0.5),
                    blurRadius: glowBlur * 1.5,
                    spreadRadius: glowSpread * 0.5,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.06,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.white, Color(0xFF6C63FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'S',
                      style: GoogleFonts.inter(
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStaggeredText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _taglineAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(_taglineAnimation),
            child: Text(
              'Spin Your\nText in 3D.',
              style: GoogleFonts.inter(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
                letterSpacing: -1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        FadeTransition(
          opacity: _subtitleAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(_subtitleAnimation),
            child: Text(
              'Enter any word and watch it come alive\nwith a stunning 3D rotation effect.',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.44),
                height: 1.6,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField() {
    return FadeTransition(
      opacity: _fieldAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_fieldAnimation),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your text',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.36),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                TextFormField(
                  controller: _viewModel.textController,
                  onChanged: (_) => _viewModel.onTextChanged(),
                  maxLength: 8,
                  obscureText: _viewModel.showTorch,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 11,
                    ),
                    hintText: 'e.g. Flutter',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.18),
                      fontSize: 16,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: _viewModel.toggleTorch,
                      child: Icon(
                        _viewModel.showTorch
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Colors.white.withValues(alpha: 0.4),
                        size: 20,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.04),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.10),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF6C63FF),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                if (_viewModel.showTorch)
                  TorchOverlay(text: _viewModel.textController.text),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButton(bool canNavigate) {
    return FadeTransition(
      opacity: _ctaAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_ctaAnimation),
        child: SizedBox(
          width: double.infinity,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: canNavigate ? 1.0 : 0.35,
            child: GestureDetector(
              onTap: canNavigate ? _navigate : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: canNavigate
                      ? const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null,
                  color: canNavigate ? null : Colors.white.withValues(alpha: 0.08),
                  boxShadow: canNavigate
                      ? [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withValues(alpha: 0.45),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Spin Text',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
