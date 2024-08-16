import 'package:ExamFile/data/utils/app_constants.dart';
import 'package:ExamFile/logic/bloc/auth/auth_bloc.dart';
import 'package:ExamFile/logic/my_recipes_bloc/my_recipes_bloc.dart';
import 'package:ExamFile/logic/my_recipes_bloc/my_recipes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/recipe.dart';
import '../../../widgets/toggleLike_widget.dart';

// ignore: must_be_immutable
class BuildRecipeCardWidget extends StatefulWidget {
  Recipe recipe;
  BuildRecipeCardWidget({super.key, required this.recipe});

  @override
  State<BuildRecipeCardWidget> createState() => _BuildRecipeCardWidgetState();
}

class _BuildRecipeCardWidgetState extends State<BuildRecipeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 250,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(widget.recipe.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // GestureDetector(
                //   onTap: () => Share.share('hello from Hogwarts'),
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white,
                //     child: Image.asset(
                //       'assets/images/share_icon.png',
                //       height: 22,
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/images/comment_icon.png',
                        height: 22,
                        color: const Color(0xFFFF9B05),
                      ),
                    ),
                    TogglelikeWidget(recipe: widget.recipe),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.title,
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/time_icon.png',
                          height: 20,
                          color: const Color(0xFFFF9B05),
                        ),
                        Text(
                          ' ${widget.recipe.estimatedTime.inMinutes} min',
                          style: const TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: (){
                        context.read<MyRecipesBloc>().add(SavedRecipeToMyMyRecipesEvent(widget.recipe.id, true ));
                        if(AppConstants.userModel?.saved == null){
                          AppConstants.userModel?.saved.add("salom");
                          print("salo0m");
                        }else{
                          AppConstants.userModel!.saved.add(widget.recipe.id);
                        }
                        print("bu ${widget.recipe.id} savedlar ${AppConstants.userModel?.saved} ");
                        },
                      child: AppConstants.userModel != null && AppConstants.userModel!.saved != null && !AppConstants.userModel!.saved.contains(widget.recipe.id) ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_border),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 20,
                      color: Color(0xFFFF9B05),
                    ),
                    Text(
                      ' ${widget.recipe.rate}',
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
