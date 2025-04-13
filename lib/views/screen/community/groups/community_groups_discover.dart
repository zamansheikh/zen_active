import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_loading.dart';

class CommunityGroupsDiscover extends StatefulWidget {
  const CommunityGroupsDiscover({super.key});

  @override
  State<CommunityGroupsDiscover> createState() =>
      _CommunityGroupsDiscoverState();
}

class _CommunityGroupsDiscoverState extends State<CommunityGroupsDiscover> {
  final CommunityGroupController _controller =
      Get.find<CommunityGroupController>();
  @override
  void initState() {
    _controller.getAllDiscoverGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Suggested for you",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => _controller.isLoading.value
                ? Center(
                    child: CustomLoading(),
                  )
                : Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.only(
                        bottom: 24,
                      ),
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: (168 / 226),
                      children: [
                        for (int i = 0;
                            i < _controller.discoverGroups.length;
                            i++)
                          groupInfo(
                            _controller.discoverGroups[i].name,
                            _controller.discoverGroups[i].totalMembers,
                            _controller.discoverGroups[i].image,
                            _controller.discoverGroups[i].id!,
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget groupInfo(String? groupName, int? groupMembers, String? coverImage, String groupId) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(
            0xff79CDFF,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.network(
                imageUrl(coverImage),
                width: double.infinity,
                height: 100,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: Center(
                      child: Icon(
                        Icons.error_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              groupName ?? "Group Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff2D2D2D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Public group · ${groupMembers ?? 0} members",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xff8B8B8B),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              buttonName: "Join",
              height: 35,
              textSize: 16,
              onPressed: () {
                _controller.joinAgroup(groupId);
              },
            ),
          ),
        ],
      ),
    );
  }
}
