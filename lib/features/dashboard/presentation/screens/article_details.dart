import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_digest/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/flickr_animation_widget.dart';
import '../../model/everything_model.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final Article article;
  final bool isSavedArticle;
  const ArticleDetailsScreen({super.key, required this.article, this.isSavedArticle = false});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: widget.isSavedArticle
                ? const SizedBox()
                : InkWell(
              onTap: () {
                context.read<DashboardBloc>().saveArticlesToLocalDatabase(
                  article: widget.article,
                );
              },
              child: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              // Image container
              Container(
                width: double.infinity,
                height: 280.h,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(18),
                ),
                child: ClipRRect(
                  child: widget.article.urlToImage.isNotEmpty &&
                      Uri.tryParse(widget.article.urlToImage)?.isAbsolute == true
                      ? CachedNetworkImage(
                    imageUrl: widget.article.urlToImage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child: CircularAnimationWidget(), // Your custom loader
                      );
                    },
                    errorWidget: (context, url, error) {
                      return const Center(child: Text("No image"));
                    },
                  )
                      : const Center(child: Text("No image available")), // Handle empty URL gracefully
                ),
              ),


              // Content container positioned at the bottom of the image
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8), // Padding around text

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    widget.article.author.isEmpty
                        ? const SizedBox()
                        : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 24,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "By ${widget.article.author.split(',').first}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    widget.article.description.isNotEmpty
                        ? Text(
                      widget.article.description,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                        : const SizedBox(),
                    SizedBox(height: 12.h),
                    Text(
                      widget.article.content,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 20,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          getFormattedDate(widget.article.publishedAt),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black45,
                          ),
                        ),
                         widget.article.url.isNotEmpty ? const Spacer():  const SizedBox(),
                        widget.article.url.isNotEmpty ?Container(
                        margin: const EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () async {
                              debugPrint("${widget.article.url}");
                              if (await canLaunchUrl(Uri.parse(
                                  widget.article.url))) {
                                try {
                                  await launchUrl(Uri.parse(
                                      widget.article.url));
                                } catch (e) {

                                }
                              }
                            },
                            child: const Text(
                              "more...",
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 16,
                                color:Colors.blue,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ),
                        ):const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getFormattedDate(String date) {
  try {
    // Parsing the string to a DateTime object
    DateTime dueDate = DateTime.parse(date);

    // Formatting the DateTime object to the desired format
    String formattedDate = DateFormat('dd MMM yyyy').format(dueDate);
    return formattedDate.isNotEmpty ? formattedDate : "";
  } catch (e) {
    // Return empty string if any exception occurs
    return "";
  }
}
