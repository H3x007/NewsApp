import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: const Text('News App'),
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Color(0xFFF5F5F5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: BottomNavigationBar(
                iconSize: 20,
                selectedFontSize: 14,
                unselectedFontSize: 10,
                items: cubit.bottomItem,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changeBottom(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
