import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ThemeButton extends StatefulWidget {
  final Widget? centreWidget;
  final Color? color;
  final Function onPress;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;

  ThemeButton(
      {super.key,
      this.centreWidget,
      required this.color,
      required this.onPress,
      this.decoration,
      this.textStyle});

  @override
  _ThemeButtonState createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
   
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        _animationController.reverse();
      },
      onTap: () {
        _animationController.forward();
        Future.delayed(Duration(milliseconds: 50), () {
          _animationController.reverse();
          widget.onPress();
        });
      },
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          height: 50.h,
          decoration: widget.decoration ??
              BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.themeShadow,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
          child: Center(
            child: widget.centreWidget ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}
