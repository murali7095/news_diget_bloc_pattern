import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_digest/core/flickr_animation_widget.dart';
import 'package:news_digest/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:news_digest/features/dashboard/presentation/screens/recomended_news.dart';

class DiscoverScreenMain extends StatefulWidget {
  const DiscoverScreenMain({super.key});

  @override
  State<DiscoverScreenMain> createState() => _DiscoverScreenMainState();
}

class _DiscoverScreenMainState extends State<DiscoverScreenMain> {
  @override
  void initState() {
    super.initState();
    // Ensure events are dispatched to fetch news and initialize database
    debugPrint("Initializing events...");
    context.read<DashboardBloc>().add(InitializeHiveDatabaseEvent());
    context.read<DashboardBloc>().add(GetEverythingNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          debugPrint("Current State: $state");

          // Handle failure state
          if (state is FetchEverythingFailure) {
            return const Center(child: Text("NEWS not found"));
          }

          // If state is still loading, show the loading animation
          if (  state is DashboardLoading) {
            return const Center(
              child: FlickrAnimationWidget(),
            );
          }

          // Once we have success, we can show the content
          if (state is FetchEverythingSuccess) {
            final everythingModel = state.everythingModel;

            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: EdgeInsets.only(left: 16.w, top: 60.h, bottom: 30.h, right: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Discover",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp, color: Colors.black87),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "News from all around the world",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.black87),
                      ),
                      buildSearchWidget(
                        hintText: "Browse News",
                        onChanged: (data) {
                          context.read<DashboardBloc>().searchNews = data;
                        },
                        onTapSearch: () {
                          debugPrint("The search term: ${context.read<DashboardBloc>().searchNews}");
                          context.read<DashboardBloc>().add(SearchTextEvent(searchText: context.read<DashboardBloc>().searchNews));
                        },
                      ),
                      RecommendedNewsWidget(everythingModel: everythingModel),
                    ],
                  ),
                ),
              ),
            );
          }

          // Return an empty widget in case none of the states match
          return const SizedBox();
        },
      ),
    );
  }
}

Widget buildSearchWidget({
  required String hintText,
  void Function()? onTapSearch,
  void Function()? onTapFiled,
  required void Function(String) onChanged,
  void Function()? onTapClear,
  void Function(String)? onSubmitted,
  bool canSearch = false,
  bool canClearSearch = false,
  TextEditingController? searchController,
  String initialValue = '',
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(60),
    ),
    child: TextFormField(
      onTap: onTapFiled,
      controller: searchController,
      autocorrect: false,
      autofocus: false,
      textAlign: TextAlign.left,
      onChanged: (v) {
        // Save the cursor position
        final cursorPos = searchController?.selection.baseOffset ?? 0;

        // Update the text
        onChanged(v);

        // Restore the cursor position
        searchController?.selection = TextSelection.fromPosition(
          TextPosition(offset: cursorPos),
        );
      },
      decoration: InputDecoration(
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: onTapSearch,
                child: const Icon(Icons.search, color: Colors.blue)),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black54, fontSize: 14.sp, fontWeight: FontWeight.w400),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32), // Border radius
          borderSide: const BorderSide(
            color: Color(0xFFCBD5E1), // Border color
            width: 1, // Border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32), // Border radius
          borderSide: const BorderSide(
            color: Color(0xFFCBD5E1), // Border color
            width: 1, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32), // Border radius
          borderSide: const BorderSide(
            color: Color(0xFFCBD5E1), // Border color
            width: 1, // Border width
          ),
        ),
        filled: true,
        fillColor: Colors.white, // Background color
      ),
      cursorColor: Colors.grey,
      onFieldSubmitted: onSubmitted,
    ),
  );
}
