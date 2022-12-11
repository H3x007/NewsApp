// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/models/article_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/source_details_screen.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';
import 'package:news_app/widgets/build_grid_news.dart';
import 'package:news_app/widgets/build_top_channel.dart';

class AllHomeWidget extends StatelessWidget {
  AllHomeWidget({super.key, required this.articles, required this.sources});

  List<Articles>? articles;
  List<Sources>? sources;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: articles!
                .map((e) => Container(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image(
                              image: e.urlToImage == null
                                  ? AssetImage("assets/img/placeholder.jpg")
                                  : NetworkImage('${e.urlToImage}')
                                      as ImageProvider,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [
                                    0.1,
                                    0.9
                                  ],
                                  colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.white.withOpacity(0.0)
                                  ]),
                            ),
                          ),
                          Positioned(
                              bottom: 30.0,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                width: 250.0,
                                child: Column(
                                  children: [
                                    Text(
                                      '${e.title}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              bottom: 10.0,
                              left: 10.0,
                              child: Text(
                                '${e.source!.name}',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 9.0),
                              )),
                          Positioned(
                              bottom: 10.0,
                              right: 10.0,
                              child: Text(
                                //'${e.publishedAt}',
                                timeUntil(DateTime.parse('${e.publishedAt}')),
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 9.0),
                              )),
                        ],
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              enlargeCenterPage: false,
              height: 200.0,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 16,
          ),

          /// Build Top Channel List Item
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('Top Channels', style: subHeadingStyle),
          ),
          Container(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildTopChannel(
                sources: NewsCubit.get(context).sourceModel!.sources[index],
              ),
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              itemCount: 10,
            ),
          ),

          /// Build Grid View News
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Hot News',
              style: subHeadingStyle,
            ),
          ),
          Container(
            height: articles!.length / 2 * 210.0,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: articles!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05 / 1.7,
              ),
              itemBuilder: (context, index) => BuildGridNews(
                articles: NewsCubit.get(context).articleModel!.articles![index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
