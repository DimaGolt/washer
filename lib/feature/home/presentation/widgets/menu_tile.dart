import 'dart:math';

import 'package:flutter/material.dart';

enum TilePosition {
  upLeft,
  upRight,
  downLeft,
  downRight,
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    this.isFaded = false,
    required this.icon,
    required this.label,
    required this.position,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final TilePosition position;
  final bool isFaded;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 4,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: _getColors(isFaded),
            transform: _getRotation(position),
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              size: 46,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GradientRotation _getRotation(TilePosition position) {
    switch (position) {
      case TilePosition.upLeft:
        return const GradientRotation(-0.75 * pi);
      case TilePosition.upRight:
        return const GradientRotation(-0.25 * pi);
      case TilePosition.downLeft:
        return const GradientRotation(0.75 * pi);
      case TilePosition.downRight:
        return const GradientRotation(0.25 * pi);
    }
  }

  List<Color> _getColors(bool isFaded) => isFaded
      ? const [
          Color(0xFF8B9AB8),
          Color(0xFFBEC6EF),
        ]
      : const [
          Color(0xFF68A8C9),
          Color(0xFF808CC9),
        ];
}
