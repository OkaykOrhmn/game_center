import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  static late GenerativeModel model;
  static initial() {
    model = GenerativeModel(
        model: 'gemini-2.0-flash-lite',
        apiKey: 'AIzaSyAwO45ZfGqo4IJsbAuHXxuTgjOHlgmFsqg');
  }

  static Future<String?> getResponse(String prompt) async {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text;
  }
}
