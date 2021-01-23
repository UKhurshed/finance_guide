import 'package:finance_guide/home/news/news.dart';
import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';

class DetailsArgument{
  final Article article;

  const DetailsArgument(this.article);
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DetailsArgument args =ModalRoute.of(context).settings.arguments;
    return Scaffold(body: DetailsScreen(article: args.article));
  }
}


class DetailsScreen extends StatelessWidget {
  final Article article;
  // static final routeName = 'Details';

  const DetailsScreen({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        elevation: 0,
        title: Text(article.author ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    article.urlToImage ?? 'https://www.pngitem.com/pimgs/m/254-2549834_404-page-not-found-404-not-found-png.png',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(article.title ?? '', style: TextStyle(
                  color: kAppBar,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text(article.description ?? '', style: TextStyle(color: kAppBar, fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}