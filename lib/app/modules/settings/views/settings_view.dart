import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quranapp/app/constant/theme.dart';
import 'package:quranapp/app/modules/detail_surah/controllers/detail_surah_controller.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  final detailSurahC = Get.find<DetailSurahController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: appWhite),
        title: Text(
          'Settings',
          style: TextStyle(
            color: appWhite,
          ),
        ),
        backgroundColor: appGreen,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getReciter(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kata per Kata",
                    style: TextStyle(fontSize: 16),
                  ),
                  GetBuilder<SettingsController>(
                    builder: (_) {
                      return Switch(
                        value: controller.isWBW,
                        onChanged: (value) {
                          detailSurahC.isWBW = value;
                          detailSurahC.update();
                          controller.changeSwitchWBW(value);
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Pilih Qari",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              GetBuilder<SettingsController>(
                builder: (c) {
                  return DropdownButtonFormField(
                    value: c.idSelectedReciter,
                    hint: Text(c.allReciters[c.idSelectedReciter].reciterName ??
                        "null"),
                    items: [
                      for (int i = 0; i <= c.allReciters.length - 1; i++)
                        DropdownMenuItem(
                          child: Text(
                              "${c.allReciters[i].reciterName ?? "null"} - ${c.allReciters[i].style == "" ? "Murattal" : c.allReciters[i].style}"),
                          value: i + 1,
                        ),
                    ],
                    onChanged: (value) {
                      c.selectIDReciter(value ?? 6);
                      detailSurahC.update();
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pilih Tafsir",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              GetBuilder<SettingsController>(
                builder: (c) {
                  return DropdownButtonFormField(
                    value: c.idSelectedReciter,
                    hint: Text(c.allReciters[c.idSelectedReciter].reciterName ??
                        "null"),
                    items: [
                      for (int i = 0; i <= c.allReciters.length - 1; i++)
                        DropdownMenuItem(
                          child: Text(
                              "${c.allReciters[i].reciterName ?? "null"} - ${c.allReciters[i].style == "" ? "Murattal" : c.allReciters[i].style}"),
                          value: i + 1,
                        ),
                    ],
                    onChanged: (value) {
                      c.selectIDReciter(value ?? 6);
                      detailSurahC.update();
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
