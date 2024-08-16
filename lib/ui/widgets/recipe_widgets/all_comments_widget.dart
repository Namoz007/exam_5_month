import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/model/comment.dart';
import '../../../data/model/recipe.dart';
import '../../../data/utils/app_constants.dart';

class AllCommentsWidget extends StatelessWidget {
  final Recipe? recipe;
  final List<Comment> reviews;

  const AllCommentsWidget({
    super.key,
    required this.reviews,
    required this.recipe,
  });

  // Sana formatlash funksiyasi
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Comments'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];

          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(recipe!.imageUrl),
                  ),
                  title: Row(
                    children: [
                      Text(
                        review.user.name,
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 13,
                            color: index < review.rate
                                ? Colors.amber
                                : Colors.grey,
                          );
                        }),
                      ),
                      Text("(${review.rate})"),
                    ],
                  ),
                  subtitle: Text(
                    formatDate(recipe!.createdAt),
                    style: GoogleFonts.montserrat(fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8.0),
                  child: Text(
                    review.title,
                  ),
                ),
                const Gap(10),
                const Divider(indent: 15, endIndent: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
