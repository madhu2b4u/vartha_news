import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/api_provider.dart';
import '../controller/news_controller.dart';
import '../data/model/news.dart';

String formatCategory(String category) {
  return category
      .split('-')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

class NewsPage extends StatelessWidget {

  NewsPage({super.key});

  final NewsController newsController = Get.put(NewsController(apiProvider: ApiProvider()));

/*  void _shareNews() {

  }

  void _openReadMode() {
    Get.to(() => ReadModePage(newsItem: widget.newsItem), transition: Transition.rightToLeft);
  }

  void _openFullNews() async {

  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: Column(
        children: [
          // Categories List
          Obx(() {
            if (newsController.status.value.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (newsController.status.value.isError) {
              return Center(child: Text('Error: ${newsController.status.value.errorMessage}'));
            } else if (newsController.status.value.isSuccess) {
              return SizedBox(
                height: 60.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newsController.categories.length,
                  itemBuilder: (context, index) {
                    final category = newsController.categories[index];
                    return GestureDetector(
                     // onTap: () => newsController.fetchPosts(category.name),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            formatCategory(category.name),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      ,
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
          // News List
          Expanded(
            child: Obx(() {
              if (newsController.status.value.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (newsController.status.value.isError) {
                return Center(child: Text('Error: ${newsController.status.value.errorMessage}'));
              } else if (newsController.status.value.isSuccess) {
                return ListView.builder(
                  itemCount: newsController.newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsController.newsList[index];
                    return NewsListItem(newsItem: newsItem);
                  },
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}

class NewsListItem extends StatelessWidget {
  final News newsItem;

  const NewsListItem({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            child: Image.network(
              newsItem.images![0],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'No image available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsItem.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  newsItem.summary ?? 'Loading summary...',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  newsItem.publicationDate ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  newsItem.source ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed:(){
                    print("share");
                    Share.share('${newsItem.title}\n${newsItem.source}\n${newsItem.loc}');
                  } ,
                ),
                IconButton(
                  icon: const Icon(Icons.chrome_reader_mode, color: Colors.white),
                  onPressed: (){

                  },
                ),
                IconButton(
                  icon: const Icon(Icons.open_in_browser, color: Colors.white),
                  onPressed: () async {
                    if (await canLaunch(newsItem.loc!)) {
                    await launch(newsItem.loc!);
                    } else {
                    throw 'Could not launch ${newsItem.loc}';
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
