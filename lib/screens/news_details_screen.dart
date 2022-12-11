// ignore_for_file: unnecessary_new, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetails extends StatefulWidget {
  final Articles article;
  NewsDetails({Key? key, required this.article}) : super(key: key);
  @override
  _DetailNewsState createState() => _DetailNewsState(article);
}

class _DetailNewsState extends State<NewsDetails> {
  final Articles article;
  _DetailNewsState(this.article);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF7D7870),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          navigateTo(context, WebViewSecreen(article.url!));
        },
        child: Container(
          height: 48.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: const [
                Color(0xFF1D628B),
                Color(0xFF4589B0),
              ],
              stops: const [0, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              Text(
                "Read More ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: defaultColor,
        title: Text(
          article.title!,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Image(
            image: article.urlToImage == null
                ? AssetImage("assets/img/placeholder.jpg")
                : NetworkImage('${article.urlToImage}') as ImageProvider,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  article.publishedAt!.substring(0, 10),
                  style: TextStyle(
                    color: defaultColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(),
                Text(
                  article.title!,
                  style: NewsCubit.get(context).isDark
                      ? titleStyle.copyWith(color: Colors.white)
                      : titleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  timeUntil(DateTime.parse(article.publishedAt!)),
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  article.content!,
                  style: contentStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String timeUntil(DateTime date) {
    return timeago.format(date, allowFromNow: true);
  }
}
