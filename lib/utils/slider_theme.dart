import 'package:flutter/material.dart';

class CustomSliderTheme extends StatelessWidget {
  final Widget child;

  const CustomSliderTheme({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double thumbRadius = 14;
    const double tickMarkRadius = 8;

    final activeColor = Colors.blue[600];
    const inactiveColor = Color.fromRGBO(109, 114, 120, 1);

    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 15,

        /// Thumb
        thumbShape: const RoundSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),
        rangeThumbShape: const RoundRangeSliderThumbShape(
          disabledThumbRadius: thumbRadius,
          enabledThumbRadius: thumbRadius,
        ),

        /// Tick Mark
        tickMarkShape:
            const RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),

        /// Inactive
        inactiveTickMarkColor: inactiveColor,
        inactiveTrackColor: inactiveColor,

        /// Active
        thumbColor: Colors.grey,
        activeTrackColor: activeColor,
        activeTickMarkColor: activeColor,
      ),
      child: child,
    );
  }
}
