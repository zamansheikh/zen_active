import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class CustomPopupMenu extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final String? hintText;
  final List<String> options;
  final List<String>? svgPaths;
  final bool supportsMultiSelection;
  final bool isActive;
  final Function(String)? onChanged;

  const CustomPopupMenu({
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
  State<CustomPopupMenu> createState() => CustomPopupMenuState();
}

class CustomPopupMenuState extends State<CustomPopupMenu> {
  String? selectedOption;
  List<String> selectedOptions = [];

  void _onOptionSelected(String option) {
    if (widget.supportsMultiSelection) {
      setState(() {
        if (selectedOptions.contains(option)) {
          selectedOptions.remove(option);
        } else {
          selectedOptions.add(option);
        }
        selectedOption = selectedOptions.join(', ');
      });
    } else {
      setState(() {
        selectedOption = option;
      });
      widget.onChanged?.call(option);
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
            color: const Color(0xff2d2d2d),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfffefeff),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.0,
              color: const Color(0xff79CDFF),
            ),
          ),
          child: PopupMenuButton<String>(
            enabled: widget.isActive,
            onSelected: _onOptionSelected,
            itemBuilder: (BuildContext context) {
              return widget.options.map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Row(
                    children: [
                      if (widget.svgPaths != null &&
                          widget.svgPaths!.length >
                              widget.options.indexOf(option))
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: svgViewer(
                            asset: widget
                                .svgPaths![widget.options.indexOf(option)],
                            height: 16,
                            width: 16,
                          ),
                        ),
                      Text(
                        option,
                        style: const TextStyle(
                          color: Color(0xff525252),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedOption ?? widget.hintText ?? 'Select an option',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: widget.isActive
                          ? const Color(0xff4B4B4B)
                          : const Color(0xff757575),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Color(0xff8B8B8B)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
