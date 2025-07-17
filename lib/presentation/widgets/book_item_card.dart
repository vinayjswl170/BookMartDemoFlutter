import 'package:flutter/material.dart';
import 'package:gutendex_books_app/domain/models/book.dart';
import 'package:gutendex_books_app/utils/app_colors.dart';

class BookItemCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookItemCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child:
                  (book.formats.containsKey('image/jpeg') &&
                          book.formats['image/jpeg']!.isNotEmpty)
                      ? Image.network(
                        book.formats['image/jpeg']!,
                        width:
                            90, // Adjusted based on screenshot for 3-column layout
                        height: 140, // Adjusted height for cover
                        fit: BoxFit.fitWidth,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.book,
                              size: 80,
                              color: AppColors.greyMedium,
                            ),
                      )
                      : const Icon(
                        Icons.book,
                        size: 80,
                        color: AppColors.greyMedium,
                      ),
            ),
            const SizedBox(height: 8),
            // Book Title
            Text(
              book.title
                  .toUpperCase(), // Uppercase as per some designs, adjust if not needed
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ), // Book Name style, bolded
              maxLines: 2,
              textAlign: TextAlign.center, // Center align text
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Book Author
            Text(
              book.authors.join(', '),
              style: textTheme.bodySmall, // Book Author style
              maxLines: 1,
              textAlign: TextAlign.center, // Center align text
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
