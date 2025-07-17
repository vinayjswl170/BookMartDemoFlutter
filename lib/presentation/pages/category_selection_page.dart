
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gutendex_books_app/presentation/controllers/category_selection_controller.dart';
import 'package:gutendex_books_app/presentation/widgets/category_card.dart';
import 'package:gutendex_books_app/utils/app_colors.dart';

class CategorySelectionPage extends GetView<CategorySelectionController> {
  const CategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gutendex Books'),
      ),
      body: Stack(
        children: [
          // Background SVG image
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/Pattern.svg',
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(Color(0x1A5E56E7), BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gutenberg Project',
                  style: textTheme.displayMedium?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'A social cataloging website that allows you to freely search its database of books, annotations, and reviews.',
                  style: textTheme.bodyLarge?.copyWith(color: AppColors.greyDark),
                ),
                const SizedBox(height: 24.0),
                Expanded(
                  child: isLargeScreen
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 3 / 0.8,
                          ),
                          itemCount: controller.bookCategories.length,
                          itemBuilder: (context, index) {
                            final category = controller.bookCategories[index];
                            final String? svgPath = controller.getSvgAssetForCategory(category);
                            final Widget leadingIconWidget = svgPath != null
                                ? SvgPicture.asset(
                                    svgPath,
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/default_book.svg', // Fallback to default_book.svg
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                  );

                            return CategoryCard(
                              categoryName: category,
                              onTap: () => controller.selectCategory(category),
                              leadingVisual: leadingIconWidget,
                              isGridView: true,
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: controller.bookCategories.length,
                          itemBuilder: (context, index) {
                            final category = controller.bookCategories[index];
                            final String? svgPath = controller.getSvgAssetForCategory(category);
                            final Widget leadingIconWidget = svgPath != null
                                ? SvgPicture.asset(
                                    svgPath,
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                  )
                                : SvgPicture.asset(
                                    'assets/images/default_book.svg', // Fallback to default_book.svg
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                                  );

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CategoryCard(
                                categoryName: category,
                                onTap: () => controller.selectCategory(category),
                                leadingVisual: leadingIconWidget,
                                isGridView: false,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
