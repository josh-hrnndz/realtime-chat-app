// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

String TALK_TO_STRANGER = "Talk to a Stranger!";
String NEXT = "NEXT";
String STOP = "STOP";
String CHATBOX_HINTTEXT = "Send a message...";

String API = dotenv.get('API', fallback: 'http://10.0.2.2:3333/');
