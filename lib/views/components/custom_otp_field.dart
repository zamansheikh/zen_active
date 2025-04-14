import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_button.dart';

class CustomOTPField extends StatefulWidget {
  const CustomOTPField({super.key, this.onPressed, this.isLoading = false});
  final Function(String)? onPressed;
  final bool isLoading;

  @override
  CustomOTPFieldState createState() => CustomOTPFieldState();

  @override
  String toStringShort() => 'Rounded With Cursor';
}

class CustomOTPFieldState extends State<CustomOTPField> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color focusedBorderColor = AppColors.splashColor;
    Color fillColor = Color.fromRGBO(243, 246, 249, 0);
    Color borderColor = AppColors.splashColor;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              validator: (value) {
                return (value?.length == 6)
                    ? null
                    : 'Pin is incorrect'; // Update the validation logic if needed
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          SizedBox(height: 24),
          CustomButton(
            buttonName: "Verify",
            isLoading: widget.isLoading,
            onPressed: widget.onPressed != null
                ? () => widget.onPressed!(pinController.text)
                : null,
          ),
        ],
      ),
    );
  }
}
