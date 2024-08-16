import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/recipe.dart';

class IngredientsSectionWidget extends StatefulWidget {
  final Recipe? recipe;

  const IngredientsSectionWidget({
    super.key,
    required this.recipe,
  });

  @override
  _IngredientsSectionWidgetState createState() =>
      _IngredientsSectionWidgetState();
}

class _IngredientsSectionWidgetState extends State<IngredientsSectionWidget> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final ingredients = widget.recipe!.ingredient;

    final itemHeight = 40.0;
    final initialItemCount = 4;
    final visibleItemCount = _showAll
        ? ingredients.length
        : (ingredients.length > initialItemCount
            ? initialItemCount
            : ingredients.length);
    final containerHeight = 30.0 + visibleItemCount * itemHeight;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
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
                  children: [
                    ...List.generate(
                      visibleItemCount,
                      (index) {
                        final ingredient = ingredients[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ingredient.name.toString(),
                                    style: GoogleFonts.montserrat(fontSize: 12),
                                  ),
                                  Text(
                                    "${ingredient.quantity.toString()} cups",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(indent: 10, endIndent: 10),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (ingredients.length > initialItemCount)
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
      ),
    );
  }
}
