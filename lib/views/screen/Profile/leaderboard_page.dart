import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>> list = [
      ["You", 110],
      ["Victoria", 4],
      ["Philip", 5],
      ["Arlene", 6],
      ["Colleen", 7],
      ["Arlene", 8],
      ["Kristin", 9],
    ];
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffEBF8FF),
                    Color(0xff2781B5),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: CustomAppBar(
                  title: "Leaderboard",
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      top3(),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfffefeff),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            border: Border.all(
                              color: Color(0xff37B5FF),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (int index = 0; index < list.length; index++)
                                  Container(
                                    height: 72,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: index == 0 ? 1 : 0.5,
                                          color: index == 0
                                              ? Color(0xff2781B5)
                                              : Color(0xff79CDFF),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        avatar(size: 40),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          list[index][0],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Color(0xff4B4B4B),
                                            height: 1,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          list[index][1].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Color(0xff4B4B4B),
                                            height: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            index % 2 == 0
                                                ? svgViewer(
                                                    asset:
                                                        "assets/svg/arrow_green_up.svg",
                                                    height: 7)
                                                : SizedBox(
                                                    height: 7,
                                                  ),
                                            index % 2 == 1
                                                ? svgViewer(
                                                    asset:
                                                        "assets/svg/arrow_red_down.svg",
                                                    height: 7)
                                                : SizedBox(
                                                    height: 7,
                                                  ),
                                          ],
                                        ),
                                      ],
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
            ],
          ),
        ],
      ),
    );
  }

  Widget top3() {
    return SizedBox(
      width: double.infinity,
      height: 236,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 113,
              decoration: BoxDecoration(
                color: Color(0xff1E648C),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 122,
              height: 159,
              decoration: BoxDecoration(
                color: Color(0xff2781B5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 26,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -35,
                  child: Image.asset(
                    "assets/images/crown_bronze.png",
                    width: 60,
                  ),
                ),
                Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: Color(0xff32A5E8),
                    ),
                  ),
                  child: avatar(size: 82),
                ),
                Positioned(
                  bottom: -8,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Color(0xff32A5E8),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  child: Column(
                    children: [
                      Text(
                        "Emma",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2674",
                        style: TextStyle(
                          color: Color(0xffC1E8FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 26,
            bottom: 80,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -30,
                  child: Image.asset(
                    "assets/images/crown_silver.png",
                    width: 55,
                  ),
                ),
                Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: Color(0xff32A5E8),
                    ),
                  ),
                  child: avatar(size: 82),
                ),
                Positioned(
                  bottom: -8,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Color(0xff32A5E8),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  child: Column(
                    children: [
                      Text(
                        "Jackson",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2847",
                        style: TextStyle(
                          color: Color(0xffC1E8FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 128,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -30,
                  child: Image.asset(
                    "assets/images/crown_gold.png",
                    width: 58,
                  ),
                ),
                Container(
                  height: 82,
                  width: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3,
                      color: Color(0xffFFAA00),
                    ),
                  ),
                  child: avatar(size: 82),
                ),
                Positioned(
                  bottom: -8,
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Color(0xffFFAA00),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -65,
                  child: Column(
                    children: [
                      Text(
                        "Eiden",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "5240",
                        style: TextStyle(
                          color: Color(0xffFFAA00),
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget avatar({double size = 50}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Image.network(
        "https://thispersondoesnotexist.com/",
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return Center(
              child: Text(
                "${((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!) * 100).toInt()}",
              ),
            );
          } else {
            return child;
          }
        },
        height: size,
        width: size,
      ),
    );
  }
}
