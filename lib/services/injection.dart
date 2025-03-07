import 'package:chatgpt/services/chat_gpt_service.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';
import './chat_gpt_service.dart';
import 'package:uuid/uuid.dart';

final chatgpt = ChatGPTService();
final logger = Logger(level: kDebugMode ? Level.trace : Level.info);
const uuid = Uuid();
