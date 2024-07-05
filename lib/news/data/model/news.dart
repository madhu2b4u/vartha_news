import 'dart:convert';
import '../../api/api_gemini_service.dart';

/// loc : "https://www.rnz.co.nz/news/national/519752/search-on-for-67-year-old-woman-missing-in-waikato-bush"
/// source : "RNZ"
/// publicationDate : "2024-06-17T12:33:15+12:00"
/// title : "Search on for 67-year-old woman missing in Waikato bush"
/// images : ["https://media.rnztools.nz/rnz/image/upload/s--gmyi0DX8--/c_crop,h_300,w_480,x_0,y_43/c_scale,h_300,w_480/c_scale,f_auto,q_auto,w_1050/v1718583614/4KOGAQQ_pauline_grey_photo_jpg"]
/// caption : ""
/// category : "nz-news"

List<News> newsModelFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsModelToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class News {
  String? loc;
  String? source;
  String? publicationDate;
  String? title;
  List<String>? images;
  String? caption;
  String? category;
  String? id;
  String? summary; // Added field for summary

  News({
    this.loc,
    this.source,
    this.publicationDate,
    this.title,
    this.images,
    this.caption,
    this.category,
    this.id,
    this.summary,
  }){
    // Sanitize images URLs
    images = images?.map((url) => sanitizeUrl(url)).toList();
  }

  // Method to sanitize URLs
  String sanitizeUrl(String url) {
    return url.replaceAll('&amp;', '&');
  }

  // Method to fetch summary asynchronously
  Future<String?> fetchSummary() async {
    try {
      // Assuming summarizeNews is a global function or part of a service
      String summaryText = await summarizeNews(loc!);

      summary = summaryText;

      return summaryText;

    } catch (e) {
      print('Error fetching summary: $e');
      summary = "";
      return null;
    }
  }

  News.fromJson(dynamic json) {
    loc = json['loc'];
    source = json['source'];
    publicationDate = json['publicationDate'];
    title = json['title'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
    caption = json['caption'];
    summary = json['summary'];
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loc'] = loc;
    data['source'] = source;
    data['publicationDate'] = publicationDate;
    data['title'] = title;
    data['images'] = images;
    data['caption'] = caption;
    data['summary'] = summary;
    data['category'] = category;
    data['id'] = id;
    return data;
  }
}
