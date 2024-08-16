import 'package:ExamFile/ui/screens/resipe_screens/recipe_details_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/recipe.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_bloc.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_event.dart';

class ShowRecipes extends StatefulWidget {
  final List<Recipe> recipes;
  final bool isUploaded;
  ShowRecipes({super.key, required this.recipes, required this.isUploaded});

  @override
  State<ShowRecipes> createState() => _ShowRecipeState();
}

class _ShowRecipeState extends State<ShowRecipes> {
  bool connectInternet = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        setState(() {
          connectInternet = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 35,
        childAspectRatio: 1 / 1.20,
      ),
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        Recipe recipe = widget.recipes[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailsScreen(recipe: recipe,)));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: connectInternet
                          ? NetworkImage(recipe.imageUrl)
                              as ImageProvider<Object>
                          : AssetImage("assets/images/no_internet.jpg")
                              as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    widget.isUploaded
                        ? const Icon(
                            Icons.stars_rounded,
                            color: Colors.blue,
                          )
                        : const SizedBox(),
                    widget.isUploaded
                        ? const Text(
                            "You",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
