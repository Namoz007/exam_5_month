import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../controllers/recipe_add_controller.dart';

class RecipeName extends StatefulWidget {
  const RecipeName({super.key});

  @override
  State<RecipeName> createState() => _RecipeNameState();
}

class _RecipeNameState extends State<RecipeName> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed to free up resources
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    final recipeAddController = context.read<RecipeAddController>();
    String name = _nameController.text;
    String description = _descriptionController.text;

    if (name.isNotEmpty &&
        description.isNotEmpty &&
        _cookingTimeController.text.isNotEmpty) {
      int cookingTime = int.parse(_cookingTimeController.text);

      recipeAddController.addNameandDicription(name, description, cookingTime);
      recipeAddController.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recipe Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(10),
            const Text(
              "Cooking time (min)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _cookingTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(10),
            const Text(
              "Description (Optional)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter the detail of your recipe",
              ),
              minLines: 4,
              maxLines: 5,
            ),
            GestureDetector(
              onTap: _onContinuePressed,
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
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
      ),
    );
  }
}
