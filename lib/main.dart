import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helper/api/dio_helper.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/helper/services/cache_helper.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/layout/home_layout.dart';
import 'package:news_app/styles/colors.dart';
import 'package:news_app/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  print(isDark);

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getNews()
        ..getSource()
        ..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return MaterialApp(
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomeLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
