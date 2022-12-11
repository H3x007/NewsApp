import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/source_details_screen.dart';

class BuildNewsSources extends StatelessWidget {
  BuildNewsSources({super.key, required this.sources});
  Sources? sources;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              NewsCubit.get(context).getNewsSources(sources!.id!);
              navigateTo(context, SourceDetails(sources: sources!));
            },
            child: Container(
              //width: MediaQuery.of(context).size.width,
              width: 100,
              decoration: BoxDecoration(
                  color: NewsCubit.get(context).isDark
                      ? Colors.grey[500]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 175, 175, 175),
                      blurRadius: 5,
                      offset: Offset(1.0, 1.0),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: sources!.id!,
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logos/${sources!.id}.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      bottom: 15.0,
                      top: 15.0,
                    ),
                    child: Text(
                      '${sources!.name}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: NewsCubit.get(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
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
