import 'package:material_ui/material_ui.dart';

/// The rounded "pill" card used for course units and Kids section topics.
class UnitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle subtitleStyle;
  final double heightFactor;
  final double elevation;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleStyle = kannadaSubtitle,
    this.heightFactor = 0.22,
    this.elevation = 15,
    this.onTap,
  });

  static const kannadaSubtitle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.blue);
  static const englishSubtitle =
      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size.height * heightFactor,
        width: size.width * 0.8,
        child: Card(
          elevation: elevation,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: subtitleStyle,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
