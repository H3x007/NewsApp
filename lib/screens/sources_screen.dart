// ignore_for_file: prefer_const_constructors, unused_import, implementation_imports, unnecessary_import

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/source_details_screen.dart';
import 'package:news_app/screens/web_view_screen.dart';
import 'package:news_app/widgets/build_news_sources.dart';
import 'package:timeago/timeago.dart';
import 'package:intl/intl.dart';

class SourcesScreen extends StatelessWidget {
  const SourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sourceModel!.sources;
        return ConditionalBuilder(
          condition: true,
          builder: (context) => AnimationLimiter(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.86),
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredGrid(
                duration: Duration(milliseconds: 2500),
                position: index,
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: BuildNewsSources(
                      sources: list[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'No More Sources',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
