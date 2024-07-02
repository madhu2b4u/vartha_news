import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> summarizeNews(String url) async {
  try {
    const String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"; // Replace with your Gemini API URL
    const String apiKey = "xxx"; // Replace with your Gemini API Key

    // Prepare request body
    Map<String, dynamic> requestBody = {
      "contents": [
        {"parts": [{"text": "Summarize the news from $url in 100 words"}]}
      ]
    };

    // Encode request body to JSON
    String requestBodyJson = jsonEncode(requestBody);

    // Make POST request to Gemini API
    http.Response response = await http.post(
      Uri.parse("$apiUrl?key=$apiKey"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      // Parse response JSON
      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Extract summarized text
      String summarizedText = responseData['candidates'][0]['content']['parts'][0]['text'];

      return summarizedText;
    } else {
      throw Exception('Failed to load summarized news');
    }
  } catch (e) {
    print('Error summarizing article: $e');
    return 'Error summarizing article: $e';
  }
}
