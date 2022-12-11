import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/source_details_screen.dart';
import 'package:news_app/screens/web_view_screen.dart';

class BuildTopChannel extends StatelessWidget {
  BuildTopChannel({super.key, required this.sources});
  Sources? sources;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              //navigateTo(context, WebViewSecreen(sources!.url!));
              NewsCubit.get(context).getNewsSources(sources!.id!);
              navigateTo(context, SourceDetails(sources: sources!));
            },
            child: Container(
              width: 50,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/logos/${sources!.id}.png'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${sources!.name}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.4,
                        color: NewsCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    '${sources!.category}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.4,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
