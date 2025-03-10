import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_digest/core/flickr_animation_widget.dart';
import 'package:news_digest/features/dashboard/model/everything_model.dart';
import 'package:news_digest/features/dashboard/model/head_lines_model.dart';
import 'package:news_digest/features/dashboard/presentation/screens/article_details.dart';
class HeadLinesSliderWidget extends StatefulWidget {
  const HeadLinesSliderWidget({super.key, required this.headLinesModel});

  final HeadLinesModel headLinesModel;

  @override
  State<HeadLinesSliderWidget> createState() => _HeadLinesSliderWidgetState();
}

class _HeadLinesSliderWidgetState extends State<HeadLinesSliderWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildCarouselSlider(widget.headLinesModel.articles),
      ],
    );
  }


  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, top: 6.h),
      child: Row(
        children: [
          Text(
            "Headlines",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            "View all",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider(List<Article> articles) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true, // Enables auto-scroll
        autoPlayInterval: const Duration(seconds: 5), // Time interval between slides (3 seconds here)
        autoPlayAnimationDuration: const Duration(seconds: 1), // Duration of the animation between slides
        height: 170.0.h,
        enlargeCenterPage: true, // Optional: Makes the active slide bigger
        scrollPhysics: const BouncingScrollPhysics(), // Optional: Allows for a bouncing effect when scrolling
      ),
      items: articles.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _buildCarouselItem(i);
          },
        );
      }).toList(),
    );
  }


  Widget _buildCarouselItem(Article article) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:  (context) => ArticleDetailsScreen(article: article),));
      },
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          _buildImageContainer(article),
          _buildTitleOverlay(article),
        ],
      ),
    );
  }

  Widget _buildImageContainer(Article article) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:  (context) => ArticleDetailsScreen(article: article),));
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: GestureDetector(
            onTap: () {
              // Add navigation or action when tapped
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage,
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
              )
              ,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleOverlay(Article article) {
    return Positioned.directional(
      bottom: 20,
      start: 2,
      end: 2,
      textDirection: TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          article.title,
          maxLines: 2,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
