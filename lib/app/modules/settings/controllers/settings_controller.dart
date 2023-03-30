import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quranapp/app/constant/api.dart';
import 'package:quranapp/app/data/models/reciter.dart';
import 'package:http/http.dart' as http;
import 'package:quranapp/app/data/models/tafsir.dart' as tafsir;
import 'package:quranapp/app/data/models/verse.dart';

class SettingsController extends GetxController {
  final switchWBWController = GetStorage();
  final selectedIDController = GetStorage();
  var isWBW = false;
  var idSelectedReciter = 6;
  List<Reciter> allReciters = [];
  var idSelectedTafsir = 1;
  var indexSelectedTafsir = 0;
  List<tafsir.Tafsir> allTafsirs = [];

  SettingsController() {
    if (switchWBWController.read("switchWBW") != null) {
      isWBW = switchWBWController.read("switchWBW");
      update();
      print("isWBW : ${isWBW}");
    }
    if (selectedIDController.read("idReciter") != null) {
      idSelectedReciter = selectedIDController.read("idReciter");
      update();
      print("idSelectedReciter : ${idSelectedReciter}");
    }
    if (selectedIDController.read("idTafsir") != null &&
        selectedIDController.read("indexTafsir") != null) {
      idSelectedTafsir = selectedIDController.read("idTafsir");
      indexSelectedTafsir = selectedIDController.read("indexTafsir");
      update();
      print(
          "idSelectedReciter : ${idSelectedTafsir} - index : $indexSelectedTafsir");
    }
  }

  changeSwitchWBW(bool value) {
    isWBW = value;
    switchWBWController.write("switchWBW", isWBW);
    update();
    print("isWBW : ${isWBW}");
  }

  selectIDReciter(int id) {
    idSelectedReciter = id;
    selectedIDController.write("idReciter", id);
    update();
    print(id);
  }

  Future<List<Reciter>> getReciter() async {
    var res = await http.get(Uri.parse("${APIENDPOINT}recitations"));
    List data = json.decode(res.body);

    List<Reciter> listReciter = data.map((e) => Reciter.fromJson(e)).toList();
    allReciters = listReciter;
    return listReciter;
  }

  selectIDTafsir(int id) {
    idSelectedTafsir = id;
    selectedIDController.write("idTafsir", id);
    update();
    print(id);
  }

  Future<List<tafsir.Tafsir>> getTafsirs() async {
    var res = await http.get(Uri.parse("${APIENDPOINT}tafsirs"));
    List data = json.decode(res.body);

    List<tafsir.Tafsir> listTafsir =
        data.map((e) => tafsir.Tafsir.fromJson(e)).toList();
    allTafsirs = listTafsir;
    return listTafsir;
  }
}
