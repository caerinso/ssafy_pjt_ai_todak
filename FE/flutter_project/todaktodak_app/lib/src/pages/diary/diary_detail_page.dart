import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/src/components/diary/detail/diary_detail_diarycontents_component.dart';
import 'package:test_app/src/components/diary/detail/diary_detail_icon_component.dart';
import 'package:test_app/src/components/diary/detail/diray_detail_appbar.dart';
import 'package:test_app/src/controller/diary/diary_datail_controller.dart';

class DiaryDetailPage extends StatefulWidget {
  const DiaryDetailPage({super.key});

  @override
  State<DiaryDetailPage> createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  final String date = Get.arguments;
  final _controller = Get.put(DiaryDetailController());

  @override
  void initState() {
    final diaryId = Get.parameters["diaryId"];
    Get.find<DiaryDetailController>().getDiaryDetail(diaryId);
    super.initState();
  }

  _box() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 0.5,
            color: Color(0x35531F13),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
          style: const TextStyle(color: Color(0xff212529)),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        iconTheme: const IconThemeData(color: Color(0xff212529)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: const [DiaryDetailAppbar()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: FutureBuilder(
          future: _controller.getDiaryDetail(Get.parameters["diaryId"]),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const DiaryDetailIconComponent(),
                  const SizedBox(
                    height: 16,
                  ),
                  DiaryDetailDiaryContentsComponent(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}