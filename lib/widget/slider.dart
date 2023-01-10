import 'package:bluetooth_app/utils/slider_theme.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final ValueSetter<double> onValueChange;
  final double? value;
  const CustomSlider({Key? key, required this.onValueChange, this.value})
      : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    double value = widget.value ?? 30;
    return CustomSliderTheme(
      child: Slider(
        value: value,
        min: 0,
        max: 100,
        divisions: 20,
        label: value.round().toString(),
        onChanged: (val) => setState(() {
          value = val;
          widget.onValueChange(value);
        }),
      ),
    );
  }
}
