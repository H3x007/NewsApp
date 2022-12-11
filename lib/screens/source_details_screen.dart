// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/styles.dart';
import 'package:news_app/widgets/all_home_widgets.dart';

class SourceDetails extends StatelessWidget {
  final Sources sources;
  SourceDetails({super.key, required this.sources});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: defaultColor,
            title: Text(sources.name!),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.changeThemeMode();
                },
                icon: cubit.isDark
                    ? Icon(EvaIcons.moonOutline)
                    : Icon(Icons.wb_sunny),
              ),
            ],
          ),
          body: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  width: double.infinity,
                  color: NewsCubit.get(context).isDark
                      ? Colors.black45
                      : Color(0xFFC9C7AF),
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 20, top: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: sources.id == null
                                    ? AssetImage(
                                        "assets/logos/logo_placeholder.png")
                                    : AssetImage(
                                        "assets/logos/${sources.id}.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        sources.description!,
                        textAlign: TextAlign.center,
                        style: NewsCubit.get(context).isDark
                            ? titleStyle.copyWith(color: Colors.white)
                            : titleStyle.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //if (state is! SuccessSourceNewsState)
              Expanded(
                child: ConditionalBuilder(
                  condition: state is SucessSourcesNewsState,
                  builder: (context) => AnimationLimiter(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: NewsCubit.get(context)
                          .newsSourceModel!
                          .articles!
                          .length,
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        duration: Duration(milliseconds: 2000),
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                              child: ConditionalBuilder(
                            condition: NewsCubit.get(context)
                                    .newsSourceModel!
                                    .articles !=
                                null,
                            builder: (context) => buildListItem(
                              NewsCubit.get(context)
                                  .newsSourceModel!
                                  .articles![index],
                              context,
                            ),
                            fallback: (context) => Center(
                              child: Text('No News Now ...'),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                  fallback: (context) => LinearProgressIndicator(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        //topRight: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: articles!.urlToImage,
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
              ),
            ),
          ),
        ),
      );
}
