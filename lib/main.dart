import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_gemini_sample/app/app.dart';
import 'package:google_gemini_sample/app/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: Constants.googleGeminiApiKey);
  runApp(MyApp());
}
