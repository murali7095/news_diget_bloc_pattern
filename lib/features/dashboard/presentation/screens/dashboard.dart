import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_digest/core/flickr_animation_widget.dart';
import 'package:news_digest/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:news_digest/features/dashboard/model/catageory_model.dart';
import 'package:news_digest/features/dashboard/model/head_lines_model.dart';
import 'package:news_digest/features/dashboard/presentation/screens/discover_screen_main.dart';
import 'package:news_digest/features/dashboard/presentation/screens/headlines_slider_widget.dart';
import 'package:news_digest/features/dashboard/presentation/screens/recomended_news.dart';
import 'package:news_digest/features/dashboard/presentation/screens/saved_articles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  // Declare the models here, but do NOT initialize them yet
  late HeadLinesModel _headLinesModel;
  late CatageoryModel _catageroryModel;

  @override
  void initState() {
    super.initState();
    // Initialize the models in initState()
    _headLinesModel =
        HeadLinesModel(status: '0', totalResults: 0, articles: []);
    _catageroryModel =
        CatageoryModel(status: 'status', totalResults: 0, articles: []);

    // Fetch data when the screen is initialized
    context.read<DashboardBloc>().add(GetTopHeadlinesEvent());
    context
        .read<DashboardBloc>()
        .add(CategorySelectedEvent(selectedCategory: "All"));
    context.read<DashboardBloc>().add(GetCatageoryEvent());
  }

  // List of screens for bottom navigation
  List<Widget> _screens = [];

  @override
  Widget build(BuildContext context) {
    _screens = [
      Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text(
            "𝑵𝑬𝑾𝑺 𝑫𝒊𝒈𝒆𝒔𝒕",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black87),
          ),
          actions: const [
            Icon(Icons.notifications_outlined, color: Colors.blue),
            SizedBox(width: 14),
          ],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: FlickrAnimationWidget());
            }
            if (state is FetchTopHeadlinesSuccess) {
              _headLinesModel = state.headLinesModel;
            }

            // Check if Everything data has been fetched successfully
            if (state is FetchCatageorySuccess) {
              _catageroryModel = state.catageoryModel;
            }

            // Handle failures
            if (state is FetchCatageoryFailure) {
              return Center(
                  child: Text("Error fetching everything: ${state.error}"));
            }

            if (state is FetchHeadlinesFailure) {
              return Center(
                  child: Text("Error fetching headlines: ${state.error}"));
            }

            // Render UI with the fetched data
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: 6.h, left: 16.w, bottom: 20.h, right: 16.w),
                child: Column(
                  children: [
                    HeadLinesSliderWidget(headLinesModel: _headLinesModel),
                    SizedBox(height: 12.h),
                    Wrap(
                      children: DashboardBloc().categories.map((e) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            context.read<DashboardBloc>().add(
                                CategorySelectedEvent(selectedCategory: e));
                            context
                                .read<DashboardBloc>()
                                .add(GetCatageoryEvent());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 6.h),
                            margin: EdgeInsets.only(right: 6.w, bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: context
                                          .read<DashboardBloc>()
                                          .currentCategory ==
                                      e
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: context
                                            .read<DashboardBloc>()
                                            .currentCategory ==
                                        e
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.h),
                    _catageroryModel.articles.isNotEmpty
                        ? buildNewsLayout(_catageroryModel.articles, context)
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      const DiscoverScreenMain(),
      const SavedArticles(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar:
          productionBottomNavigationBar(_selectedIndex, _onItemTapped),
    );
  }

  // Function to handle bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

BottomNavigationBar productionBottomNavigationBar(
    int selectedIndex, Function(int) onItemTapped) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    onTap: onItemTapped,
    type: BottomNavigationBarType.fixed,
    // Ensures all icons are displayed without shifting
    backgroundColor: Colors.white,
    // White background for the bottom bar
    selectedItemColor: Colors.blueAccent,
    // Active item color
    unselectedItemColor: Colors.grey,
    // Inactive item color
    showUnselectedLabels: false,
    // Hide labels for unselected items for cleaner UI
    showSelectedLabels: true,
    // Show labels for selected items
    elevation: 10,
    // Add elevation for a shadow effect (floating bar)
    selectedFontSize: 14,
    // Customize the font size of the selected label
    unselectedFontSize: 12,
    // Customize the font size of the unselected label
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: 30, // Larger icons for better visibility
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.search,
          size: 30, // Larger icons for better visibility
        ),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.save,
          size: 30, // Larger icons for better visibility
        ),
        label: 'Saved',
      ),
    ],
  );
}
