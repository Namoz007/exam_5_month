import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/model/comment.dart';
import '../../../data/model/recipe.dart';
import '../../../data/utils/app_constants.dart';
import '../../../logic/bloc/home/home_bloc.dart';
import 'all_comments_widget.dart';

class ReviewPageWidget extends StatefulWidget {
  final Recipe? recipe;

  const ReviewPageWidget({
    super.key,
    required this.recipe,
  });

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPageWidget> {
  final TextEditingController _reviewController = TextEditingController();

  final List<Comment> _reviews = [];
  final int _truncatedLength = 300; // Qisqartirilgan uzunlik
  bool showAllReviews = false; // "See More" tugmasi holatini saqlash uchun
  int _selectedRating = 0; // Variable to store selected star rating

  void _addReview() {
    if (widget.recipe == null || AppConstants.userModel == null) {
      return; // Ma'lumot mavjud emas
    }

    context.read<HomeBloc>().add(
      AddReviewEvent(
        widget.recipe!.id,
        Comment(
          rate: _selectedRating,
          title: _reviewController.text,
          user: AppConstants.userModel!,
        ),
      ),
    );

    _reviewController.clear();
    setState(() {
      _selectedRating = 0;
    });
  }

  void _viewAllReviews() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AllCommentsWidget(
          reviews: _reviews,
          recipe: widget.recipe,
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(date);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.recipe != null) {
      context.read<HomeBloc>().add(GetReviewEvent(recipedId: widget.recipe!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator(color: Colors.red));
        }
        if (state is ErrorState) {
          return Center(child: Text(state.message));
        }
        if (state is LoadedReviewState) {
          if (_reviews.isEmpty) {
            _reviews.addAll(state.comments);
          }
        }

        final hasReviews = _reviews.isNotEmpty;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: double.infinity,
                height: 146,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "What do you think about the recipe?",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                            (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRating = index + 1;
                              });
                            },
                            child: Icon(
                              index < _selectedRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: "Write a review",
                          prefixIcon: Icon(Icons.edit, color: Colors.grey[300]),
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[400]!),
                          ),
                        ),
                        onFieldSubmitted: (value) => _addReview(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
                bottom: 10,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews (${_reviews.length})",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (hasReviews)
                    GestureDetector(
                      onTap: _viewAllReviews,
                      child: Text(
                        "See More",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (!hasReviews)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Hali kommentlar mavjud emas",
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  showAllReviews ? _reviews.length : _reviews.length > 2 ? 2 : _reviews.length, (index) {
                    final review = _reviews[index];
                    final bool isTruncated = review.title.length > _truncatedLength;
                    final String displayReview = isTruncated ? review.title.substring(0, _truncatedLength) + '...' : review.title;
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(widget.recipe?.imageUrl ?? ''),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  AppConstants.userModel?.name ?? '${review.user.name}',
                                  style: GoogleFonts.montserrat(fontSize: 13),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 13,
                                      color: index < review.rate ? Colors.amber : Colors.grey,
                                    );
                                  }),
                                ),
                                Text("(${review.rate})"),
                              ],
                            ),
                            subtitle: Text(
                              formatDate(widget.recipe?.createdAt ?? DateTime.now()),
                              style: GoogleFonts.montserrat(fontSize: 10),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 8.0),
                            child: Text(
                              displayReview,
                              maxLines: isTruncated ? 4 : null,
                              overflow: isTruncated ? TextOverflow.ellipsis : TextOverflow.visible,
                            ),
                          ),
                          const Gap(10),
                          _reviews.length > 2 ? const Text("") : const Divider(indent: 15, endIndent: 15),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
