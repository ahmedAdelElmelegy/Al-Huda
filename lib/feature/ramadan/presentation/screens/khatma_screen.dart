import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KhatmaScreen extends StatefulWidget {
  const KhatmaScreen({super.key});

  @override
  State<KhatmaScreen> createState() => _KhatmaScreenState();
}

class _KhatmaScreenState extends State<KhatmaScreen> {
  // Mock data for Global Khatma
  final List<Map<String, dynamic>> _circles = [
    {
      "name": "خاتمة رمضان الكبرى",
      "participants": 1250,
      "progress": 0.85,
      "remainingDays": 5,
    },
    {
      "name": "حلقة حفظ سورة البقرة",
      "participants": 450,
      "progress": 0.40,
      "remainingDays": 12,
    },
    {
      "name": "خاتمة الشباب الأسبوعية",
      "participants": 800,
      "progress": 0.25,
      "remainingDays": 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الخاتمة الجماعية",
          style: TextSTyle.f18SSTArabicMediumPrimary.copyWith(
            color: ColorManager.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primary,
                          ColorManager.primary.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "شارك في الأجر",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        verticalSpace(8),
                        const Text(
                          "ساهم في إتمام الختمات الجماعية حول العالم",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpace(16),
                        Row(
                          children: [
                            const Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 20,
                            ),
                            horizontalSpace(8),
                            const Text(
                              "أكثر من 50,000 مشترك حالياً",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الحلقات النشطة",
                        style: TextSTyle.f16SSTArabicMediumBlack,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("إنشاء حلقة"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final circle = _circles[index];
              return _buildCircleCard(circle);
            }, childCount: _circles.length),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleCard(Map<String, dynamic> circle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(circle['name'], style: TextSTyle.f16SSTArabicMediumBlack),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "متبقي ${circle['remainingDays']} أيام",
                  style: const TextStyle(color: Colors.orange, fontSize: 10),
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 14, color: Colors.grey),
              horizontalSpace(4),
              Text(
                "${circle['participants']} مشترك",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          verticalSpace(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: circle['progress'],
              backgroundColor: Colors.grey.shade200,
              color: ColorManager.primary,
              minHeight: 8,
            ),
          ),
          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(circle['progress'] * 100).toInt()}% اكتمل",
                style: const TextStyle(fontSize: 11),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  minimumSize: Size(80.w, 30.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: const Text(
                  "مشاركة",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
