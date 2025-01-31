import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomDropDown extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final List<String> options;
  final Function(String)? onChanged;
  const CustomDropDown({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.options = const [],
    this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isExpanded = false;
  String? seletedOption;
  ExpansionTileController controller = ExpansionTileController();

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
          onTap: () {},
          child: Container(
            // height: 52,
            // padding: EdgeInsets.symmetric(horizontal: 12),
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
              child: ExpansionTile(
                controller: controller,
                title: Text(
                  seletedOption ?? widget.hintText ?? 'Select an option',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff525252),
                  ),
                ),
                iconColor: Color(0xff8B8B8B),
                collapsedIconColor: Color(0xff8B8B8B),
                shape: Border.all(width: 0),
                children: [
                  for (int i = 0; i < widget.options.length; i++)
                    InkWell(
                      onTap: () {
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.options[i]);
                        }
                        setState(() {
                          seletedOption = widget.options[i];
                        });
                        controller.collapse();
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xff79CDFF),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.options[i],
                            style: TextStyle(
                              color: Color(0xff525252),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
