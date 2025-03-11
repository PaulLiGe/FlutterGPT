import 'dart:async';
import 'package:chatgpt/data/converter/datetime_converter.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/message_dao.dart';
import '../models/message.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Message])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  MessageDao get messageDao;
}
