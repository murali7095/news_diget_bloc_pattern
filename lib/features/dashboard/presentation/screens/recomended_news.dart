import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_digest/core/flickr_animation_widget.dart';
import 'package:news_digest/features/dashboard/presentation/screens/article_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../model/everything_model.dart';

class RecommendedNewsWidget extends StatefulWidget {
  const RecommendedNewsWidget({super.key, required this.everythingModel});
final EverythingModel everythingModel;
  @override
  State<RecommendedNewsWidget> createState() => _RecommendedNewsWidgetState();
}

class _RecommendedNewsWidgetState extends State<RecommendedNewsWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recommended", style: TextStyle(fontSize: 14.sp,color: Colors.black54,fontWeight: FontWeight.bold),),
         SizedBox(height: 20.h,),
         buildNewsLayout(widget.everythingModel.articles,context),
      ],
    );
  }


}
Column buildNewsLayout(List<Article> articles, BuildContext context,[bool isSavedScreen =false]) {
  return Column(
    children:
    articles.map((e)  {
      return e.urlToImage.isEmpty  || e.author.isEmpty ? const SizedBox(): GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:  (context) => ArticleDetailsScreen(article: e,isSavedArticle: isSavedScreen,),));
        },
        child: Container(
          padding:   EdgeInsets.only(bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 5.w),
                height: 120.h,
                width: 120.h,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: e.urlToImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularAnimationWidget(), // Your custom loader
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Center(child: Text("No image"));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.title,maxLines: 4,style: TextStyle(
                        fontSize: 14.sp,color: Colors.black87,fontWeight: FontWeight.bold
                    ), ),
                    const SizedBox(height: 4,),
                    Wrap(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 5,),
                        Text(e.author.length > 30 ? e.author.substring(0,29):e.author ,style: TextStyle(
                            fontSize: 12.sp,color: Colors.black54
                        ), ),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.timer_outlined),
                        const SizedBox(width: 5,),
                        Text(getFormattedDate(e.publishedAt) ,style: TextStyle(
                            fontSize: 12.sp,color: Colors.black54
                        ), ),
                      ],
                    ),

                  ],),
              )
            ],
          ),
        ),
      );
    }).toList(),
  );
}