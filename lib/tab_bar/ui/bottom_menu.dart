import 'package:flutter/material.dart';

enum BottomTab { home, favorites }

class BottomMenu extends StatelessWidget {
  final BottomTab selected;
  final VoidCallback? onHomeTap;
  final VoidCallback? onFavoritesTap;

  const BottomMenu({
    super.key,
    required this.selected,
    this.onHomeTap,
    this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFCECECE), width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15), // цвет тени
                  offset: Offset(0, 3), // смещение: x=0, y=4 — только вниз
                  blurRadius: 6.1, // размытие тени
                  spreadRadius: 0, // насколько тень распространяется
                ),
              ],
            ),
            child: SizedBox(
              height: 84,
              child: Row(
                children: [
                  _BottomItem(
                    asset:
                        selected == BottomTab.home
                            ? 'assets/home_selected.png'
                            : 'assets/home.png',
                    onTap: onHomeTap,
                    width: 36,
                    height: 27,
                  ),

                  _BottomItem(
                    asset:
                        selected == BottomTab.favorites
                            ? 'assets/favorites_selected.png'
                            : 'assets/favorites.png',
                    onTap: onFavoritesTap,
                    width: 41,
                    height: 33,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final String asset;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const _BottomItem({required this.asset, this.onTap, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(height: 26),
            SizedBox(child: Image.asset(asset, width: width, height: height)),
          ],
        ),
      ),
    );
  }
}
