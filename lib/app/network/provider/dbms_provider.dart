// import 'package:callink_flutter/features/callink_chat/infrastructure/chat/models/object/message_documents_object.dart';
// import 'package:callink_flutter/features/callink_chat/infrastructure/chat/models/object/message_files_object.dart';
// import 'package:callink_flutter/features/callink_chat/infrastructure/chat/models/object/message_multimedia_object.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// import '../../../features/callink_chat/infrastructure/chat/models/object/chat_message_object.dart';
// import '../../../features/callink_chat/infrastructure/chat/models/object/chat_room_object.dart';
// import '../../../features/callink_core/infrastructure/auth/models/object/user_config_object.dart';

// late final Future<Isar> isar;

class DbmsProvider {
  Isar isar;

  DbmsProvider({required this.isar});

  IsarCollection readCollections({required TableEnum tableEnum}) {
    var collect = {
      // TableEnum.tableRoom: isar.chatRooms,
      // TableEnum.tableMessage: isar.chatMessages,
      // TableEnum.tableUser: isar.userConfigs,
      // TableEnum.tableMultimedia: isar.messageMultiMedias,
      // TableEnum.tableFiles: isar.messageFiles,
      // TableEnum.tableDocuments: isar.messageDocuments,
    };

    return collect[tableEnum] as IsarCollection;
  }

  dbInsert({required TableEnum tableEnum, required dynamic object}) async {
    await isar.writeTxn(() async {
      var collect = readCollections(tableEnum: tableEnum);
      await collect.put(object);
    });
  }

  dbInsertAll({required TableEnum tableEnum, required List list}) async {
    await isar.writeTxn(() async {
      var collect = readCollections(tableEnum: tableEnum);
      await collect.putAll(list);
    });
  }

  dbDelete({required TableEnum tableEnum, required int id}) async {
    await isar.writeTxn(() async {
      var collect = readCollections(tableEnum: tableEnum);
      await collect.delete(id);
    });
  }

  // checkAvailable(
  //     {required TableEnum tableEnum, required dynamic object}) async {
  //   var collect = readCollections(tableEnum: tableEnum);
  //   // if (collect.filter().equ)
  // }

  reset() async => await isar.clear();
}

initIsar() async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = Isar.open([
    // UserConfigSchema,
    // ChatRoomSchema,
    // ChatMessageSchema,
    // MessageMultiMediaSchema,
    // MessageFilesSchema,
    // MessageDocumentsSchema
  ], inspector: true, directory: dir.path);
  return isar;
}

enum TableEnum {
  tableRoom,
  tableMessage,
  tableUser, //UserConfig
  tableMultimedia,
  tableFiles,
  tableDocuments,
}
