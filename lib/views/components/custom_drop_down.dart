import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class CustomDropDown extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final List<String> options;
  final List<String>? svgPaths;
  final bool supportsMultiSelection;
  final bool isActive;
  final Function(String)? onChanged;
  const CustomDropDown({
    super.key,
    required this.title,
    this.controller,
    this.hintText,
    this.options = const [],
    this.isActive = true,
    this.supportsMultiSelection = false,
    this.svgPaths,
    this.onChanged,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool isExpanded = false;
  String? seletedOption;
  List<String> selectedOptions = [];
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
                enabled: widget.isActive,
                title: Text(
                  seletedOption ?? widget.hintText ?? 'Select an option',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color:
                        widget.isActive ? Color(0xff4B4B4B) : Color(0xff757575),
                  ),
                ),
                iconColor: Color(0xff8B8B8B),
                collapsedIconColor: Color(0xff8B8B8B),
                shape: Border.all(width: 0.0),
                children: [
                  for (int i = 0; i < widget.options.length; i++)
                    InkWell(
                      onTap: widget.isActive
                          ? () {
                              if (widget.onChanged != null) {
                                widget.onChanged!(widget.options[i]);
                              }
                              if (!widget.supportsMultiSelection) {
                                setState(() {
                                  seletedOption = widget.options[i];
                                });
                                controller.collapse();
                              } else {
                                if (selectedOptions
                                    .contains(widget.options[i])) {
                                  selectedOptions.remove(widget.options[i]);
                                } else {
                                  selectedOptions.add(widget.options[i]);
                                }
                                setState(() {
                                  seletedOption = selectedOptions.toString();
                                  seletedOption =
                                      seletedOption.toString().substring(
                                            1,
                                            seletedOption!.length - 1,
                                          );
                                });
                              }
                            }
                          : null,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: (selectedOptions.contains(widget.options[i]) ||
                                  seletedOption == widget.options[i])
                              ? Color(0xffc1e8ff)
                              : null,
                          border: Border(
                            top: BorderSide(
                              color: Color(0xff79CDFF),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.svgPaths != null &&
                                  widget.svgPaths!.length > i)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: svgViewer(
                                    asset: widget.svgPaths![i],
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              Text(
                                widget.options[i],
                                style: TextStyle(
                                  color: Color(0xff525252),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
