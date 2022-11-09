import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBProvider extends GetxService {
  static var tblChatRooms = 'tblChats';
  static var tblMessages = 'tblMessages';
  static var tblMultiMedia = 'tblMultiMedia';
  static var tblFiles = 'tblFiles';
  static var tblDocuments = 'tblDocuments';
  static var keyChats = 'keyChats';

  HiveInterface dbLocal = Hive;

  var encryptionKey = List<int>.empty();

  registerAdapter() async {
    return dbLocal..initFlutter();
  }

  Future<void> reset() async {
    List<String> tables = [
      tblChatRooms,
      tblMultiMedia,
      tblMessages,
      tblFiles,
      tblDocuments
    ];

    for (var key in tables) {
      var table = await Hive.openBox(key);
      table.clear();
    }
  }

  Future<Uint8List> getEncryptionKey() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryprionKey = await secureStorage.read(key: 'key');
    if (encryprionKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);
    Get.log('Encryption key: $encryptionKey');
    return encryptionKey;
  }

  Future<Box> pickBox({required String name, required bool isWriter}) async {
    encryptionKey =
        encryptionKey.isNotEmpty ? encryptionKey : await getEncryptionKey();
    if (!dbLocal.isBoxOpen(name)) {
      await dbLocal.openBox(name,
          encryptionCipher: HiveAesCipher(encryptionKey));
    }

    final encryptedBox = await dbLocal.openBox(name,
        encryptionCipher: HiveAesCipher(encryptionKey));
    return encryptedBox;
  }

  getListenableBox({required String from, required String key}) {
    return dbLocal.box(from).listenable();
  }

  Future<dynamic> read({required String from}) async {
    final box = await pickBox(name: from, isWriter: false);

    return box.values.toList();
  }

  Future<dynamic> readAt({required String from, required int index}) async {
    final box = await pickBox(name: from, isWriter: false);

    Get.log(
        'YOUR INDEX DB at {$index} IS Exist : ${index < box.keys.toList().length}');

    return await box.getAt(index);
  }

  Future<List<T>> selectAll<T>({required String from}) async {
    final box = await pickBox(name: from, isWriter: false);

    return box.values.toList().cast<T>();
  }

  Future<dynamic> readWithDefault(
      {required String from,
      required String key,
      required dynamic defaultValue}) async {
    if (!dbLocal.isBoxOpen(from)) {
      await dbLocal.openBox(from);
    }
    return await dbLocal.box(from).get(key, defaultValue: defaultValue);
  }

  Future<int> insert({required String to, required dynamic data}) async {
    final box = await pickBox(name: to, isWriter: true);
    return await box.add(data);
  }

  Future<Iterable<int>> insertAll(
      {required String to, required List<dynamic> datas}) async {
    final box = await pickBox(name: to, isWriter: true);
    return await box.addAll(datas);
  }

  Future<void> update(
      {required String to, required String key, required dynamic data}) async {
    final box = await pickBox(name: to, isWriter: true);
    return await box.put(key, data);
  }

  Future<void> updateAt(
      {required String from, required int index, required dynamic data}) async {
    final box = await pickBox(name: from, isWriter: true);

    if (!box.containsKey(index)) {
      CommonWidget.toast('sorry index not exist');
      return;
    } else {
      return await dbLocal.box(from).putAt(index, data);
    }
  }

  Future<void> updateAll(
      {required String to, required Map<dynamic, dynamic> data}) async {
    final box = await pickBox(name: to, isWriter: true);

    return await box.putAll(data);
  }

  Future<void> delete({required String from, required String key}) async {
    final box = await pickBox(name: from, isWriter: true);

    if (!box.containsKey(key)) {
      CommonWidget.toast('sorry key not exist');
      return;
    } else {
      return await box.delete(key);
    }
  }

  Future<void> deleteAt({required String from, required int index}) async {
    final box = await pickBox(name: from, isWriter: true);

    if (!box.containsKey(index)) {
      CommonWidget.toast('sorry index not exist');
      return;
    } else {
      return await dbLocal.box(from).deleteAt(index);
    }
  }

  Future<void> deleteAll(
      {required String from, required List<dynamic> keys}) async {
    final box = await pickBox(name: from, isWriter: true);

    return await box.deleteAll(keys);
  }

  Future<bool> availabilityCheck(
      {required dynamic data, required String from}) async {
    final box = await pickBox(name: from, isWriter: false);

    return box.values.toList().contains(data);
  }

  Future<int> indexIdCheck(
      {required dynamic data, required String from}) async {
    final box = await pickBox(name: from, isWriter: false);

    return box.values.toList().indexWhere((element) => element.id == data);
  }

  List getDatum({required Box box}) {
    Get.log('datanya yak : ${box.values.toList()}');
    return List.from(box.values);
  }
}
