import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomTextFieldWithButton extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final bool isDisabled;
  final bool multiline;
  final Function()? onTap;
  final String? hintText;
  const CustomTextFieldWithButton({
    super.key,
    required this.title,
    this.controller,
    this.isDisabled = false,
    this.multiline = false,
    this.onTap,
    this.hintText,
  });

  @override
  State<CustomTextFieldWithButton> createState() =>
      _CustomTextFieldWithButtonState();
}

class _CustomTextFieldWithButtonState extends State<CustomTextFieldWithButton> {
  int _amount = 0;
  @override
  initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.addListener(() {
        setState(() {
          _amount = int.tryParse(widget.controller!.text) ?? 0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: kTextStyle.copyWith(
            color: Color(
              0xff2d2d2d,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            // height: 52,
            constraints: BoxConstraints(
              minHeight: 52,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xfffefeff),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.0,
                color: Color(
                  0xff79CDFF,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Row(
                  children: [
                    TextField(
                      controller: widget.controller,
                      maxLines: widget.multiline ? 2 : 1,
                      enabled: !widget.isDisabled,
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
                    Column(
                      children: [
                        SizedBox(
                          width: 36, // Set a fixed width
                          height: 36, // Set a fixed height
                          child: IconButton(
                            onPressed: () {
                              if (_amount > 0) {
                                setState(() {
                                  _amount--;
                                  widget.controller!.text = _amount.toString();
                                });
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Color(0xff79CDFF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 36, // Set a fixed width
                          height: 36, // Set a fixed height
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _amount++;
                                widget.controller!.text = _amount.toString();
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Color(0xff79CDFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
