// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/models/article_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/search_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';

Widget buildSearchItem(List<Article>? article) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: article!.length / 2 * 210.0,
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: article.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(seconds: 1),
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: buildListItem(article[index], context),
                          ),
                        )),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildListItem(articles, context) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(
            context,
            WebViewSecreen(articles.url!),
          );
        },
        child: Container(
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        //topRight: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: articles.urlToImage,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 120.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '${articles.title}',
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            timeUntil(
                                DateTime.parse('${articles.publishedAt}')),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
