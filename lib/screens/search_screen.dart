import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/widgets/all_home_widgets.dart';
import 'package:news_app/widgets/my_form_field.dart';
import 'package:news_app/widgets/search_widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                MyFormField(
                  type: TextInputType.text,
                  label: 'Search',
                  suffix: Icons.search,
                  onSubmit: (text) {
                    NewsCubit.get(context).search(text);
                  },
                ),
                if (state is LoadingSearchState) LinearProgressIndicator(),
                if (state is SuccessSearchState)
                  Expanded(
                    child: buildSearchItem(cubit.searchModel!.articles),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
