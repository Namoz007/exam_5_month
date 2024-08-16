import 'package:ExamFile/ui/screens/saved_and_uploaded_screen/widgets/show_my_saved_recipes.dart';
import 'package:ExamFile/ui/screens/saved_and_uploaded_screen/widgets/show_my_uploaded_recipes.dart';
import 'package:flutter/material.dart';

class MyRecipesScreen extends StatefulWidget {
  const MyRecipesScreen({super.key});

  @override
  State<MyRecipesScreen> createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Recipes"),
        bottom: TabBar(
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.amber,
          controller: _tabController,
          dividerColor: Colors.white,
          tabs: const [
            Tab(
              text: "Uploaded",
            ),
            Tab(
              text: "Saved Recipes",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
              child: ShowMyUploadedRecipes()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: ShowMySavedRecipes(),),
        ],
      ),
    );
  }
}
