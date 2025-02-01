import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class SlidableTabBar extends StatelessWidget {
  final List<String> options;
  final Function(int)? onChanged;
  final int index;
  const SlidableTabBar({
    super.key,
    required this.options,
    this.onChanged,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      child: Row(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < options.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(
                      onTap: () {
                        if(onChanged!=null) {
                          onChanged!(i);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffC1E8FF),
                          border: Border.all(
                            width: index == i ? 1.5 : 0,
                            color: Color(0xff37B5FF),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          heightFactor: 5,
                          child: Text(
                            options[i],
                            style: kTextStyle.copyWith(
                              fontSize: 14,
                              color: Color(
                                index == i ? 0xff174C6B : 0xff32A5E8,
                              ),
                              height: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
