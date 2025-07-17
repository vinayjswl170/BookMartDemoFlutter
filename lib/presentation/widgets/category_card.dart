import 'package:flutter/material.dart';
import 'package:gutendex_books_app/utils/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;
  final Widget? leadingVisual; // Now accepts a Widget (SVG or Icon)
  final bool isGridView;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.onTap,
    this.leadingVisual, // Updated parameter
    this.isGridView = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: AppColors.backgroundLight,
      elevation: 5,
      shadowColor: const Color.fromRGBO(211, 209, 238, 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.0),
        child: SizedBox(
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (leadingVisual != null) ...[
                      leadingVisual!, // Use the passed widget directly
                      const SizedBox(width: 12),
                    ],
                    Text(
                      categoryName.toUpperCase(),
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
