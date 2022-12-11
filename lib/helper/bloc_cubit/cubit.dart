import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/helper/api/dio_helper.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/helper/services/cache_helper.dart';
import 'package:news_app/models/article_models.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:news_app/models/search_model.dart';
import 'package:news_app/models/source_article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/sources_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialNewsState());
  static NewsCubit get(context) => BlocProvider.of(context);

  /// Variable & List
  int currentIndex = 0;
  bool isDark = false;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(EvaIcons.homeOutline),
      activeIcon: Icon(EvaIcons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(EvaIcons.gridOutline),
      activeIcon: Icon(EvaIcons.grid),
      label: 'Sources',
    ),
    const BottomNavigationBarItem(
      icon: Icon(EvaIcons.searchOutline),
      activeIcon: Icon(EvaIcons.search),
      label: 'Search',
    ),
  ];
  List<Widget> screens = [
    HomeScreen(),
    SourcesScreen(),
    SearchScreen(),
  ];

  /// Change Bottom Nav Bar
  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  /// Change Theme App and use Shared Preferences
  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }
  }

  /// Get all News & Headline
  ArticleModel? articleModel;
  void getNews() {
    emit(LoadingNewsState());
    DioHelper.get(
      url: 'top-headlines',
      query: {
        'country': 'us',
        'apiKey': '843463192672449e88cbe00ffc4dc7c9',
      },
    ).then((value) {
      articleModel = ArticleModel.fromJson(value.data);
      //print(headlines);

      emit(SuccessNewsState());
    }).catchError((e) {
      print(e.toString());
      emit(ErorrNewsState());
    });
  }

  /// Get News Sources
  SourceModel? sourceModel;
  void getSource() {
    DioHelper.get(
      url: 'sources',
      query: {
        'country': 'us',
        'language': 'en',
        'apiKey': '843463192672449e88cbe00ffc4dc7c9',
      },
    ).then((value) {
      sourceModel = SourceModel.fromJson(value.data);

      emit(SuccessSourceNewsState());
    }).catchError((e) {
      print(e.toString());
      emit(ErorrSourceNewsState());
    });
  }

  /// Search News
  SearchModel? searchModel;
  void search(String text) {
    emit(LoadingSearchState());
    DioHelper.get(
      url: 'everything',
      query: {
        'q': text,
        'apiKey': '843463192672449e88cbe00ffc4dc7c9',
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SuccessSearchState());
    }).catchError((e) {
      print(e.toString());
      emit(ErorrSearchState());
    });
  }

  /// Get News By Sources
  NewsSourceModel? newsSourceModel;
  void getNewsSources(String sourceId) {
    emit(LoadingSourcesNewsState());
    DioHelper.get(
      url: 'top-headlines',
      query: {
        'sources': sourceId,
        'apiKey': '843463192672449e88cbe00ffc4dc7c9',
      },
    ).then((value) {
      newsSourceModel = NewsSourceModel.fromJson(value.data);

      emit(SucessSourcesNewsState());
    }).catchError((e) {
      print(e.toString());
      emit(ErorrSourcesNewsState());
    });
  }
}
