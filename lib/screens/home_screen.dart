// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helper/api/dio_helper.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/widgets/all_home_widgets.dart';

class HomeScreen extends StatelessWidget {
  late List<Articles> articles;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return ConditionalBuilder(
          condition: NewsCubit.get(context).articleModel != null &&
              NewsCubit.get(context).sourceModel != null,
          builder: (context) => AllHomeWidget(
            articles: cubit.articleModel!.articles,
            sources: cubit.sourceModel!.sources,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
