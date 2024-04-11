// ignore: file_names

import 'package:flutter/material.dart';
import 'package:recepie_app/models/recipe.dart';
import 'package:recepie_app/pages/detailspage.dart';
import 'package:recepie_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mealTypeFilter = "";
  late String selectedFilters;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: GestureDetector(
          onTap: () {
            setState(() {
              mealTypeFilter = "";
            });
          },
          child: Text(
            "Recipe App",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                tooltip: "Login",
                onPressed: () {},
                icon: const Icon(
                  Icons.receipt_long,
                  size: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      DataService().getRecipes(mealTypeFilter);
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mealTypeFilter = "";
                          });
                        },
                        child: Chip(
                          backgroundColor: mealTypeFilter != ""
                              ? Colors.grey[50]
                              : Colors.amber[100],
                          label: const Text(
                            "🥗 All",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mealTypeFilter = "snack";
                          });
                        },
                        child: Chip(
                          backgroundColor: mealTypeFilter != "snack"
                              ? Colors.grey[50]
                              : Colors.amber[100],
                          label: const Text(
                            "🥯 Snacks",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mealTypeFilter = "breakfast";
                          });
                        },
                        child: Chip(
                          backgroundColor: mealTypeFilter != "breakfast"
                              ? Colors.grey[50]
                              : Colors.amber[100],
                          label: const Text(
                            "🧇 Breakfast",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mealTypeFilter = "lunch";
                          });
                        },
                        child: Chip(
                          backgroundColor: mealTypeFilter != "lunch"
                              ? Colors.grey[50]
                              : Colors.amber[100],
                          label: const Text(
                            "🍗 Lunch",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mealTypeFilter = "dinner";
                          });
                        },
                        child: Chip(
                          backgroundColor: mealTypeFilter != "dinner"
                              ? Colors.grey[50]
                              : Colors.amber[100],
                          label: const Text(
                            "🍽 Dinner",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder(
                  future: DataService().getRecipes(mealTypeFilter),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Unable To Load Data",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Recipe recipe = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailsPage(
                                  recipe: recipe,
                                );
                              }),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        recipe.image,
                                        width: 80,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 190,
                                          child: Text(
                                            recipe.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(recipe.cuisine),
                                        Text(
                                            "Difficulty : ${recipe.difficulty}"),
                                      ],
                                    ),
                                  ],
                                ),

                                // Rating
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(5),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                        left: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${recipe.rating}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber[800],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
