import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/my_recipes_bloc/my_recipes_bloc.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_event.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_state.dart';
import 'show_recipe.dart';

class ShowMySavedRecipes extends StatefulWidget {
  const ShowMySavedRecipes({super.key});

  @override
  State<ShowMySavedRecipes> createState() => _ShowMySavedRecipesState();
}

class _ShowMySavedRecipesState extends State<ShowMySavedRecipes> {
  @override
  void initState() {
    super.initState();
    context.read<MyRecipesBloc>().add(GetAllMySavedMyRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyRecipesBloc,MyRecipesState>(
      builder: (context, state) {

        if(state is LoadingMyRecipesState){
          return const Center(child: CircularProgressIndicator(color:Colors.red,),);
        }

        if(state is ErrorMyRecipesState){
          return Center(child: Text("${state.message}"),);
        }

        if(state is LoadedMyRecipesState){
          return ShowRecipes(recipes: state.myRecipes,isUploaded: false,);
        }

        return Container();
      },
    );
  }
}
