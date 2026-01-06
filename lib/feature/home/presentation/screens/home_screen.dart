import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_prayer_category_list.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_top_container.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/prayer_traker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [HomTopContainer()],
              ),

              Transform.translate(
                offset: Offset(0, -50),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        verticalSpace(24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: HomePrayerCategoryLIst(),
                        ),
                        verticalSpace(24),
                        PrayerTraker(),

                        // verticalSpace(24),
                        // DailyDoaa(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}










// SingleChildScrollView(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               verticalSpace(18),
//               HomeDateAndLocation(),
//               verticalSpace(16),
//               HomePrayerTimeListView(),
//               verticalSpace(16),
//               isLandScape
//                   ? SingleChildScrollView(
//                       child: Row(
//                         children: List.generate(
//                           5,
//                           (index) => ConstrainedBox(
//                             constraints: BoxConstraints(maxWidth: 150.w),
//                             child: HomePrayerBanner(),
//                           ),
//                         ),
//                       ),
//                     )
//                   : HomePrayerBanner(),
//               verticalSpace(18),
//               AllPrayersHeadline(),
//               verticalSpace(24),

//               PrayerGridView(),
//             ],
//           ),
//         ),
//       ),

// SingleChildScrollView(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 verticalSpace(18),
//                 HomeDateAndLocation(),
//                 verticalSpace(16),
//                 HomePrayerTimeListView(),
//                 verticalSpace(16),
//                 HomePrayerBanner(),
//                 verticalSpace(18),
//                 AllPrayersHeadline(),
//                 verticalSpace(24),

//                 PrayerGridView(),
//               ],
//             ),
//           ),
//         ),



