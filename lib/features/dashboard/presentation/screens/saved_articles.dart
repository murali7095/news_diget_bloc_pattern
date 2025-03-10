import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_digest/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:news_digest/features/dashboard/presentation/screens/recomended_news.dart';

import '../../../../core/flickr_animation_widget.dart';
import '../../model/everything_model.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  void initState() {
    super.initState();
    //context.read<DashboardBloc>().add(InitializeHiveDatabaseEvent());
    context.read<DashboardBloc>().add(FetchAllSavedArticles());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        List<Article> allSavedArticles = context.read<DashboardBloc>().allSavedArticles;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              "Saved",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25 , color: Colors.black87),
            ),
          ),
          body:allSavedArticles.isNotEmpty ?SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                child: buildNewsLayout( allSavedArticles, context,true)),
          ):const FlickrAnimationWidget(),
        );
      },
    );
  }
}
