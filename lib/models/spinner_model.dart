class SpinnerModel {
  final String text;
  final int numberOfTexts;

  const SpinnerModel({
    required this.text,
    this.numberOfTexts = 20,
  });

  bool get isValid => text.length >= 6;
}
