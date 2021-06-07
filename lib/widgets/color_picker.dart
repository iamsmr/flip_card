import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Function(Color) onTap;
  final Color selectedColor;

  const ColorPicker({
    Key? key,
    required this.colors,
    required this.selectedColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: colors.map((color) => _buildColor(color)).toList(),
      ),
    );
  }

  Widget _buildColor(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: AnimatedContainer(
        duration: Duration(microseconds: 2),
        height: isSelected ? 45 : 40,
        width: isSelected ? 45 : 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
