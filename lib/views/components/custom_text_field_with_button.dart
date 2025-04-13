import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/uitls.dart';

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
            height: 52,
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
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: widget.controller,
                        maxLines: widget.multiline ? 2 : 1,
                        enabled: !widget.isDisabled,
                        style: kTextStyle.copyWith(
                          color: widget.isDisabled
                              ? Color(0xff757575)
                              : Color(0xff4B4B4B),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _amount = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: widget.hintText ??
                              'Enter your ${widget.title.toLowerCase()}',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 15,
                          height: 7,
                          child: InkWell(
                            onTap: () {
                              _amount++;
                              widget.controller?.text = _amount.toString();
                              setState(() {});
                            },
                            child: svgViewer(asset: 'assets/svg/arrow_up.svg'),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          height: 7,
                          child: InkWell(
                            onTap: () {
                              if (_amount > 0) {
                                _amount--;
                                widget.controller?.text = _amount.toString();
                              }
                              setState(() {});
                            },
                            child:
                                svgViewer(asset: 'assets/svg/arrow_down.svg'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
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
