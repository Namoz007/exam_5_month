import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/recipe_add_controller.dart';
import '../../../../data/model/ingredient.dart';

class RecipeStepsWidget extends StatefulWidget {
  @override
  _RecipeStepsWidgetState createState() => _RecipeStepsWidgetState();
}

class _RecipeStepsWidgetState extends State<RecipeStepsWidget> {
  List<IngredientField> ingredientFields = [];
  List<TextEditingController> instructionControllers = [];

  @override
  void initState() {
    super.initState();
    // Add initial fields
    addIngredientField();
    addInstructionField();
  }

  void addIngredientField() {
    setState(() {
      ingredientFields.add(IngredientField(
        onDelete: () => removeIngredientField(ingredientFields.length),
      ));
    });
  }

  void removeIngredientField(int index) {
    setState(() {
      ingredientFields.removeAt(index);
    });
  }

  void addInstructionField() {
    setState(() {
      instructionControllers.add(TextEditingController());
    });
  }

  void onContinuePressed() {
    final recipeAddController = context.read<RecipeAddController>();

    List<Ingredient> ingredients =
        ingredientFields.map((field) => field.getIngredientData()).toList();
    List<String> instructions =
        instructionControllers.map((controller) => controller.text).toList();
    if (instructions.isNotEmpty && ingredients.isNotEmpty) {
      recipeAddController.addIngredientAndInstruction(
          ingredients, instructions);
      recipeAddController.pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(children: ingredientFields),
            TextButton(
              onPressed: addIngredientField,
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add new ingredients'),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "How-to",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle edit action here
                  },
                  child: const Text("Edit"),
                ),
              ],
            ),
            Column(
              children: instructionControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.drag_handle),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'Enter instructions',
                            border: OutlineInputBorder(),
                          ),
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            TextButton(
              onPressed: addInstructionField,
              child: const Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5),
                  Text('Add new instructions'),
                ],
              ),
            ),
            GestureDetector(
              onTap: onContinuePressed,
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
      ),
    );
  }
}

class IngredientField extends StatelessWidget {
  final VoidCallback onDelete;
  final TextEditingController ingredientController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  IngredientField({required this.onDelete});

  Ingredient getIngredientData() {
    return Ingredient(
        name: ingredientController.text,
        quantity: int.parse(quantityController.text),
        type: "",
        isSelected: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: ingredientController,
              decoration: const InputDecoration(
                labelText: 'Enter an ingredient',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
