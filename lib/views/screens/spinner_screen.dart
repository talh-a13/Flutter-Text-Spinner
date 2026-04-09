import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../../viewmodels/spinner_viewmodel.dart';
import '../../models/spinner_model.dart';
import '../components/spintext_widget.dart';

class SpinnerScreen extends StatefulWidget {
  final SpinnerModel model;

  const SpinnerScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<SpinnerScreen> createState() => _SpinnerScreenState();
}

class _SpinnerScreenState extends State<SpinnerScreen>
    with SingleTickerProviderStateMixin {
  late SpinnerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SpinnerViewModel(model: widget.model);
    _viewModel.initAnimation(this);
  }

  @override
  void dispose() {
    _viewModel.disposeAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: Text(
          'Spinning',
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Hero(
        tag: 'spinner_logo',
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(widget.model.numberOfTexts, (index) {
              return AnimatedBuilder(
                animation: _viewModel.animationController,
                child: SpinnerText(text: widget.model.text),
                builder: (context, child) {
                  final rotation = _viewModel.calcRotation(
                    index,
                    _viewModel.animationController.value,
                  );
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotation)
                      ..translateByVector3(Vector3(-120.0, 0, 0)),
                    child: child,
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
