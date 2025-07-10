import 'package:event/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ImageToggleSwitch extends StatefulWidget {
  final String firstAsset;
  final String secondAsset;
  final bool isFirstSelected;
  final Function(bool) onToggle;
  final double width;
  final double height;
  

  const ImageToggleSwitch({
    Key? key,
    required this.firstAsset,
    required this.secondAsset,
    required this.isFirstSelected,
    required this.onToggle,
    this.width = 60,
    this.height = 30,
  }) : super(key: key);

  @override
  _ImageToggleSwitchState createState() => _ImageToggleSwitchState();
}

class _ImageToggleSwitchState extends State<ImageToggleSwitch> {
  late bool isFirst;

  @override
  void initState() {
    super.initState();
    isFirst = widget.isFirstSelected;
  }

  void toggle() {
    setState(() {
      isFirst = !isFirst;
    });
    widget.onToggle(isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(widget.firstAsset, width: widget.height * 0.7),
                Image.asset(widget.secondAsset, width: widget.height * 0.7),
              ],
            ),
            AnimatedAlign(
              alignment: isFirst ? Alignment.centerLeft : Alignment.centerRight,
              duration: Duration(milliseconds: 300),
              child: Container(
                width: widget.height - 4,
                height: widget.height,
                decoration: BoxDecoration(
                 border: Border.all(
                  color: AppColors.primaryLight,
                  width: 5
                 ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}