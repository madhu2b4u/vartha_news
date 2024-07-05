import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/news_controller.dart';
import '../data/model/news.dart';

class NewsListItem extends StatefulWidget {
  final News newsItem;

  const NewsListItem({Key? key, required this.newsItem}) : super(key: key);

  @override
  _NewsListItemState createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
  late NewsController newsController;

  @override
  void initState() {
    super.initState();
    newsController = Get.find<NewsController>();
    if (widget.newsItem.summary.toString().isEmpty) {
      widget.newsItem.fetchSummary(); // Fetch summary using controller
    }
  }

  void _shareNews() {
    Share.share('${widget.newsItem.title}\n${widget.newsItem.source}\n${widget.newsItem.loc.toString()}');
  }

  void _openReadMode() {
    Get.to(() => ReadModePage(newsItem: widget.newsItem), transition: Transition.rightToLeft);
  }

  void _openFullNews() async {
    String url= widget.newsItem.loc.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.newsItem.images != null && widget.newsItem.images!.isNotEmpty
              ? ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              widget.newsItem.images![0].replaceAll('&amp;', '&'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey,
                child: const Center(
                  child: Text(
                    'No image available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
              : Container(
            height: 200,
            color: Colors.grey,
            child: const Center(
              child: Text(
                'No image available',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.newsItem.title != null)
                  Text(
                    widget.newsItem.title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 8.0),
                Obx(
                      () => Text(
                    widget.newsItem.summary ?? 'Loading summary...',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                if (widget.newsItem.publicationDate != null)
                  Text(
                    widget.newsItem.publicationDate!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[500],
                    ),
                  ),
                const SizedBox(height: 4.0),
                if (widget.newsItem.source != null)
                  Text(
                    widget.newsItem.source!,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: _shareNews,
                ),
                IconButton(
                  icon: const Icon(Icons.chrome_reader_mode, color: Colors.white),
                  onPressed: _openReadMode,
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_browser, color: Colors.white),
                  onPressed: _openFullNews,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReadModePage extends StatelessWidget {
  final News newsItem;

  const ReadModePage({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsItem.title != null)
              Text(
                newsItem.title!,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 16.0),
            if (newsItem.summary != null)
              Text(
                newsItem.summary!,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            const SizedBox(height: 16.0),
            if (newsItem.summary != null)
              Text(
                newsItem.summary!,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
