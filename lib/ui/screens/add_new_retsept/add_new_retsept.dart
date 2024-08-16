import 'dart:io';
import 'package:ExamFile/ui/screens/add_new_retsept/widgets/category_widget.dart';
import 'package:ExamFile/ui/screens/add_new_retsept/widgets/recip_ingredients.dart';
import 'package:ExamFile/ui/screens/add_new_retsept/widgets/recip_video.dart';
import 'package:ExamFile/ui/screens/add_new_retsept/widgets/recipe_name.dart';
import 'package:ExamFile/ui/screens/add_new_retsept/widgets/review_widget.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../controllers/recipe_add_controller.dart';
import '../../../data/model/recipe.dart';
import '../../widgets/upload_image_widget .dart';

class AddNewRecipe extends StatefulWidget {
  final Recipe? recipe;

  AddNewRecipe({Key? key, this.recipe}) : super(key: key);

  @override
  State<AddNewRecipe> createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  final PageController _pageController = PageController();
  int activeStep = 0;
  File? _selectedImage;

  // List of steps widgets
  final List<Widget> create = [
    RecipeName(),
    RecipeStepsWidget(),
    VideoUploadWidget(),
    CategoryWidget(),
    ReviewWidget(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      activeStep = index;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print("Image path ->>>> ${image!.path}");
        context.read<RecipeAddController>().updateRecipeImage(image.path);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        // Update the Recipe model with the image path using the RecipeAddController
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<RecipeAddController>().pageController = _pageController;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stepper UI
            EasyStepper(
              activeStep: activeStep,
              activeStepBackgroundColor: activeStep == create.length - 1
                  ? const Color(0xff00C337)
                  : const Color(0xffFF9B05),
              finishedStepBackgroundColor: activeStep == create.length - 1
                  ? const Color(0xff00C337)
                  : const Color(0xffFF9B05),
              finishedStepIconColor: const Color(0xff00C337),
              enableStepTapping: true,
              lineStyle: LineStyle(
                lineThickness: 3,
                finishedLineColor: activeStep == create.length - 1
                    ? const Color(0xff00C337)
                    : const Color(0xffFF9B05),
                defaultLineColor: Colors.grey.shade300,
                lineType: LineType.normal,
              ),
              stepRadius: 15,
              showLoadingAnimation: false,
              steps: List.generate(
                create.length,
                (index) => EasyStep(
                  customStep: Text(
                    "${index + 1}",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onStepReached: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            const Gap(20),

            // Image selection widget
            GestureDetector(
              onTap: _pickImage,
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      height: 200, // Adjust the height based on your design
                      fit: BoxFit.cover,
                    )
                  : UploadImageWidget(),
            ),
            const Gap(10),

            // PageView for step content
            SizedBox(
              height: 400, // Adjust based on your content height
              child: PageView.builder(
                controller: _pageController,
                itemCount: create.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) => create[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
