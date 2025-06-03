import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/cons_url.dart';
import 'package:gereja/app/modules/base/views/base_view.dart';
import 'package:get/get.dart';

import '../../../data/models/community_model.dart';

class DetailCommunityView extends StatefulWidget {
  const DetailCommunityView({super.key});

  @override
  State<DetailCommunityView> createState() => _DetailCommunityViewState();
}

class _DetailCommunityViewState extends State<DetailCommunityView> {
  int currentPage = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Community community = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(community.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan gambar pertama besar
            if (community.images.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: community.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final imageUrl = '$imgUrl/${community.images[index]}';
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Indicator dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(community.images.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentPage == index ? 12 : 8,
                        height: currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color:
                              currentPage == index ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),

            const SizedBox(height: 16),

            Text(
              community.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Leader: ${community.leaderName}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(
              'Contact: ${community.contactPhone}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            Text(
              'Deskripsi: ${community.description}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
