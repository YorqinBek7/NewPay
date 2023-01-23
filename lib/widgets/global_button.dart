import 'package:flutter/cupertino.dart';
import 'package:new_pay/utils/colors.dart';
import 'package:new_pay/utils/styles.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    this.backgroundColor,
    required this.buttonText,
    this.onTap,
  });
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 43.0),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: backgroundColor,
          border: backgroundColor == null
              ? Border.all(color: NewPayColors.black)
              : null,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: NewPayStyles.w500.copyWith(
              fontSize: 20.0,
              color: backgroundColor != null
                  ? NewPayColors.white
                  : NewPayColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
