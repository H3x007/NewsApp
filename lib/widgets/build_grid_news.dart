import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';
import 'package:news_app/helper/bloc_cubit/states.dart';
import 'package:news_app/models/article_models.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/styles/styles.dart';

class BuildGridNews extends StatelessWidget {
  BuildGridNews({super.key, required this.articles});
  Articles? articles;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              navigateTo(
                context,
                NewsDetails(article: articles!),
              );
            },
            child: Container(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image(
                        image: articles!.urlToImage == null
                            ? AssetImage("assets/img/placeholder.jpg")
                            : NetworkImage('${articles!.urlToImage}')
                                as ImageProvider,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                      child: Text(
                        '${articles!.title}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: NewsCubit.get(context).isDark
                            ? titleStyle.copyWith(color: Colors.white)
                            : titleStyle,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 180,
                          height: 2.0,
                          color: Colors.black12,
                        ),
                        Container(
                          width: 30,
                          height: 3.5,
                          color: Color(0xFFA14C10),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${articles!.source!.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF4387B5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              //'${articles.publishedAt}',
                              timeUntil(
                                  DateTime.parse('${articles!.publishedAt}')),
                              style: TextStyle(
                                color: Color(0xFF4387B5),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
