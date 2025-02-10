import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomDOBField extends StatefulWidget {
  final String title;
  final bool isDisabled;
  final Function()? onTap;
  final String? hintText;
  final Function(String, DateTime)? onChanged;

  const CustomDOBField({
    super.key,
    required this.title,
    this.onChanged,
    this.isDisabled = false,
    this.onTap,
    this.hintText,
  });

  @override
  CustomDOBFieldState createState() => CustomDOBFieldState();
}

class CustomDOBFieldState extends State<CustomDOBField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: kTextStyle.copyWith(
            color: Color(0xff2d2d2d),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: () async {
            if (widget.isDisabled) return;

            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              widget.onChanged!(formattedDate, pickedDate);
            }
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: 52,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xfffefeff),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.0,
                color: Color(0xff79CDFF),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: TextField(
                  maxLines: 1,
                  enabled: false, // Disable editing
                  style: kTextStyle.copyWith(
                    color: widget.isDisabled
                        ? Color(0xff757575)
                        : Color(0xff4B4B4B),
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText ??
                        'Enter your ${widget.title.toLowerCase()}',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
