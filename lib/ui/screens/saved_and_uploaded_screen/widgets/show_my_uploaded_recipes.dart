import 'package:ExamFile/ui/screens/saved_and_uploaded_screen/widgets/show_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/my_recipes_bloc/my_recipes_bloc.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_event.dart';
import '../../../../logic/my_recipes_bloc/my_recipes_state.dart';

class ShowMyUploadedRecipes extends StatefulWidget {
  const ShowMyUploadedRecipes({super.key});

  @override
  State<ShowMyUploadedRecipes> createState() => _ShowMyUploadedRecipesState();
}

class _ShowMyUploadedRecipesState extends State<ShowMyUploadedRecipes> {


  @override
  void initState() {
    super.initState();
    context.read<MyRecipesBloc>().add(GetAllMyUploadedMyRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyRecipesBloc, MyRecipesState>(
      builder: (context, state) {
        if(state is LoadingMyRecipesState){
          return const Center(child: CircularProgressIndicator(color: Colors.red,),);
        }

        if(state is ErrorMyRecipesState){
          return Center(child: Text("${state.message}"),);
        }

        if(state is LoadedMyRecipesState){
          return state.myRecipes.length == 0 ? const Center(child: Text("Hozirda siz yaratga retseptlar mavjud emas"),) : ShowRecipes(recipes: state.myRecipes,isUploaded: true,);
        }

        return Container();
      },
    );
  }
}
