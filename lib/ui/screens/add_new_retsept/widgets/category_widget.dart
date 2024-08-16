import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/recipe_add_controller.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<String> recipeCategories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Asian',
    'European',
    'Desserts',
    'Snacks',
    'Vegan',
    'Salads',
  ];

  List<String> selectedCategories = [];

  void _onContinuePressed() {
    final recipeAddController = context.read<RecipeAddController>();
    if (selectedCategories.isNotEmpty) {
      recipeAddController.addCotegoriys(selectedCategories);
      recipeAddController.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: recipeCategories.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    selectedCategories.contains(recipeCategories[index]);
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.grey : Colors.blue,
                    shadowColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        selectedCategories.remove(recipeCategories[index]);
                      } else {
                        selectedCategories.add(recipeCategories[index]);
                      }
                    });
                  },
                  child: Text(
                    recipeCategories[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: _onContinuePressed,
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xffFF9B05),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
