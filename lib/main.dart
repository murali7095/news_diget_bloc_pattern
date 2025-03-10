import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_digest/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:news_digest/features/dashboard/presentation/screens/dashboard.dart';

import 'core/hive/article.dart';
import 'core/hive/everything_source.dart';
void main() async{

  Hive.registerAdapter(ArticleModelDataAdapter());
  Hive.registerAdapter(EverythingSourceModelDataAdapter());
  await Hive.initFlutter();
  DashboardBloc().add(InitializeHiveDatabaseEvent());
 // await ArticleService().initHiveBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
         builder: (context, child) {
         return  MultiBlocProvider(
           providers: [
             BlocProvider<DashboardBloc>(
               create: (_) => DashboardBloc(),
             ),
           ],
           child: MaterialApp(
             debugShowCheckedModeBanner: false,
             title: 'News Digest',
             theme: ThemeData(
               // This is the theme of your application.
               //
               // TRY THIS: Try running your application with "flutter run". You'll see
               // the application has a purple toolbar. Then, without quitting the app,
               // try changing the seedColor in the colorScheme below to Colors.green
               // and then invoke "hot reload" (save your changes or press the "hot
               // reload" button in a Flutter-supported IDE, or press "r" if you used
               // the command line to start the app).
               //
               // Notice that the counter didn't reset back to zero; the application
               // state is not lost during the reload. To reset the state, use hot
               // restart instead.
               //
               // This works for code too, not just values: Most code changes can be
               // tested with just a hot reload.
               colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
               useMaterial3: true,
             ),
             home: const Dashboard(),
           ),
         );
    }
    );
  }
}

