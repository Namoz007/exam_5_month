import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/recipe.dart';

class RecipeStepCard extends StatefulWidget {
  final Recipe? recipe;
  final double size;

  const RecipeStepCard({
    super.key,
    required this.size,
    required this.recipe,
  });

  @override
  _RecipeStepCardState createState() => _RecipeStepCardState();
}

class _RecipeStepCardState extends State<RecipeStepCard> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final preparationSteps = widget.recipe?.preparation ?? [];

    print("Preparation Steps: ${preparationSteps.length}");

    final itemHeight = 40.0;
    final initialItemCount = 2;
    final visibleItemCount = _showAll
        ? preparationSteps.length
        : (preparationSteps.length > initialItemCount
            ? initialItemCount
            : preparationSteps.length);
    final containerHeight = 30.0 + visibleItemCount * itemHeight;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size * 0.93,
                height: containerHeight,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      visibleItemCount,
                      (index) {
                        final step = preparationSteps[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 5,
                              ),
                              child: Text(
                                "${index + 1}. ${step}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (index < visibleItemCount - 1)
                              const Divider(
                                indent: 10,
                                endIndent: 10,
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (preparationSteps.length > initialItemCount)
          Positioned(
            bottom: 0,
            right: (size / 2) - 65 / 2,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showAll = !_showAll;
                });
              },
              child: Row(
                children: [
                  Text(
                    _showAll ? "Show Less" : "See More",
                    style: GoogleFonts.montserrat(
                      color: Colors.orange,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
