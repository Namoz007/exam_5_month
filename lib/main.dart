import 'package:ExamFile/data/repositories/recipes_repositories.dart';
import 'package:ExamFile/data/services/recipes/my_recipes_services.dart';
import 'package:ExamFile/logic/my_recipes_bloc/my_recipes_bloc.dart';
import 'package:ExamFile/ui/screens/splash_screens/welcome_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'controllers/recipe_add_controller.dart';
import 'data/model/comment.dart';
import 'data/model/ingredient.dart';
import 'data/model/recipe.dart';
import 'data/repositories/auth_repository.dart';
import 'data/services/user/firebase_user_service.dart';
import 'firebase_options.dart';
import 'logic/bloc/auth/auth_bloc.dart';
import 'logic/bloc/home/home_bloc.dart';
import 'logic/cubits/home_screen_cubits.dart';

late Box hiveBox;
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(RecipeAdapter());
  hiveBox = await Hive.openBox('savedRecipes');
  hiveBox = await Hive.openBox("myUploadedRecipes");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _services = MyRecipesServices();
  @override
  Widget build(BuildContext context) {
    final FirebaseUserService firebaseUserService = FirebaseUserService();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository(authService: FirebaseAuthSerivce()),),
        RepositoryProvider(create: (context) => RecipesRepositories(services: _services)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AuthBloc(
                authRepository: context.read<AuthRepository>(),
                firebaseUserService: firebaseUserService,
              );
            },
          ),
          BlocProvider(create: (context) => MyRecipesBloc(repo: context.read<RecipesRepositories>())),
          BlocProvider(create: (context) {
            return HomeScreenCubits();
          }),
          BlocProvider(create: (context) {
            return HomeBloc();
          }),
          ChangeNotifierProvider<RecipeAddController>(
            create: (_) => RecipeAddController(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
