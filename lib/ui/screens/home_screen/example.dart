// import 'package:flutter_application/data/model/ingredient.dart';
// import 'package:flutter_application/data/model/recipe.dart';

// class Example {
//   static List<Recipe> ingredients = [
//     spaghettiCarbonara,
//     chickenCurry,
//     caesarSalad,
//     beefTacos
//   ];

//   static Recipe spaghettiCarbonara = Recipe(
//       title: "Spaghetti Carbonara",
//       ingredient: [
//         Ingredient(
//             name: "Spaghetti", quantity: 200, type: "Pasta", isSelected: false),
//         Ingredient(
//             name: "Pancetta", quantity: 100, type: "Meat", isSelected: false),
//         Ingredient(name: "Eggs", quantity: 3, type: "Dairy", isSelected: false),
//         Ingredient(
//             name: "Parmesan Cheese",
//             quantity: 50,
//             type: "Dairy",
//             isSelected: false),
//         Ingredient(
//             name: "Black Pepper",
//             quantity: 1,
//             type: "Spice",
//             isSelected: false),
//       ],
//       description:
//           "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
//       preparation: [
//         "Cook the spaghetti in a large pot of boiling salted water until al dente.",
//         "In a separate pan, cook the pancetta until crispy.",
//         "Beat eggs and cheese together in a bowl.",
//         "Drain the pasta and toss with the pancetta, then quickly mix in the egg and cheese mixture.",
//         "Serve immediately with freshly ground black pepper."
//       ],
//       estimatedTime: const Duration(minutes: 30),
//       category: ["Italian", "Pasta"],
//       imageUrl:
//           "https://images.immediate.co.uk/production/volatile/sites/30/2018/07/RedPepperAnchovySpaghetti-copy-1dec261.jpg",
//       videoUrl: "https://example.com/spaghetti_carbonara_video.mp4",
//       userId: "user1",
//       id: "recipe1",
//       isSaved: false,
//       likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
//       rate: 4.7,
//       comments: [],
//       createdAt: DateTime.now());

// // Recipe 2: Chicken Curry
//   static Recipe chickenCurry = Recipe(
//       title: "Chicken Curry",
//       ingredient: [
//         Ingredient(
//             name: "Chicken", quantity: 500, type: "Meat", isSelected: false),
//         Ingredient(
//             name: "Yogurt", quantity: 200, type: "Dairy", isSelected: false),
//         Ingredient(
//             name: "Onion", quantity: 1, type: "Vegetable", isSelected: false),
//         Ingredient(
//             name: "Garlic", quantity: 2, type: "Spice", isSelected: false),
//         Ingredient(
//             name: "Ginger", quantity: 1, type: "Spice", isSelected: false),
//         Ingredient(
//             name: "Tomato", quantity: 2, type: "Vegetable", isSelected: false),
//       ],
//       description:
//           "A flavorful and spicy chicken curry made with a blend of Indian spices.",
//       preparation: [
//         "Marinate the chicken with yogurt and spices.",
//         "Cook onions, garlic, and ginger in a pan until soft.",
//         "Add the marinated chicken and cook until browned.",
//         "Add tomatoes and simmer until the chicken is cooked through.",
//         "Serve with rice or naan."
//       ],
//       estimatedTime: const Duration(minutes: 45),
//       category: ["Indian", "Spicy"],
//       imageUrl:
//           "https://images.immediate.co.uk/production/volatile/sites/30/2018/07/RedPepperAnchovySpaghetti-copy-1dec261.jpg",
//       videoUrl: "https://example.com/chicken_curry_video.mp4",
//       userId: "user2",
//       id: "recipe2",
//       isSaved: true,
//       likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
//       rate: 4.8,
//       comments: [],
//       createdAt: DateTime.now());

// // Recipe 3: Caesar Salad
//   static Recipe caesarSalad = Recipe(
//       title: "Caesar Salad",
//       ingredient: [
//         Ingredient(
//             name: "Romaine Lettuce",
//             quantity: 150,
//             type: "Vegetable",
//             isSelected: false),
//         Ingredient(
//             name: "Croutons", quantity: 50, type: "Bread", isSelected: false),
//         Ingredient(
//             name: "Parmesan Cheese",
//             quantity: 30,
//             type: "Dairy",
//             isSelected: false),
//         Ingredient(
//             name: "Anchovy Paste",
//             quantity: 1,
//             type: "Spice",
//             isSelected: false),
//         Ingredient(
//             name: "Mayonnaise",
//             quantity: 60,
//             type: "Condiment",
//             isSelected: false),
//       ],
//       description:
//           "A fresh and crisp Caesar salad with homemade croutons and dressing.",
//       preparation: [
//         "Chop the romaine lettuce and place it in a large bowl.",
//         "Prepare the dressing by mixing mayonnaise, lemon juice, garlic, anchovy paste, and Parmesan cheese.",
//         "Toss the lettuce with the dressing and croutons.",
//         "Serve with additional Parmesan cheese and freshly ground black pepper."
//       ],
//       estimatedTime: Duration(minutes: 20),
//       category: ["Salad", "Healthy"],
//       imageUrl:
//           "https://images.immediate.co.uk/production/volatile/sites/30/2018/07/RedPepperAnchovySpaghetti-copy-1dec261.jpg",
//       videoUrl: "https://example.com/caesar_salad_video.mp4",
//       userId: "user3",
//       id: "recipe3",
//       isSaved: false,
//       likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
//       rate: 4.5,
//       comments: [],
//       createdAt: DateTime.now());

// // Recipe 4: Beef Tacos
//   static Recipe beefTacos = Recipe(
//       title: "Beef Tacos",
//       ingredient: [
//         Ingredient(
//             name: "Ground Beef",
//             quantity: 300,
//             type: "Meat",
//             isSelected: false),
//         Ingredient(
//             name: "Taco Shells", quantity: 6, type: "Bread", isSelected: false),
//         Ingredient(
//             name: "Tomatoes",
//             quantity: 2,
//             type: "Vegetable",
//             isSelected: false),
//         Ingredient(
//             name: "Onion", quantity: 1, type: "Vegetable", isSelected: false),
//         Ingredient(
//             name: "Cilantro", quantity: 1, type: "Herb", isSelected: false),
//         Ingredient(name: "Lime", quantity: 1, type: "Fruit", isSelected: false),
//       ],
//       description: "Delicious beef tacos with homemade salsa and guacamole.",
//       preparation: [
//         "Cook the ground beef with taco seasoning until browned.",
//         "Warm the taco shells in the oven.",
//         "Prepare the salsa by mixing tomatoes, onions, cilantro, and lime juice.",
//         "Assemble the tacos by filling the shells with beef, salsa, and guacamole.",
//         "Serve with a side of sour cream and lime wedges."
//       ],
//       estimatedTime: const Duration(minutes: 25),
//       category: ["Mexican", "Tacos"],
//       imageUrl:
//           "https://images.immediate.co.uk/production/volatile/sites/30/2018/07/RedPepperAnchovySpaghetti-copy-1dec261.jpg",
//       videoUrl: "https://example.com/beef_tacos_video.mp4",
//       userId: "user4",
//       id: "recipe4",
//       isSaved: true,
//       likes: ['9SjFRAq9AJSIqIshJmFA1kAHtjr1'],
//       rate: 4.6,
//       comments: [],
//       createdAt: DateTime.now());
// }
