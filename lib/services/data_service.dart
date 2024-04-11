import 'package:recepie_app/models/recipe.dart';
import 'package:recepie_app/services/http_service.dart';

class DataService {
  static final DataService singleton = DataService.internal();

  final HTTPService httpService = HTTPService();

  factory DataService() {
    return singleton;
  }

  DataService.internal();

  Future<List<Recipe>?> getRecipes(String fliter) async {
    String path = 'recipes/';
    if (fliter.isNotEmpty) {
      path += "meal-type/$fliter";
    }

    if (fliter.isEmpty) {
      path;
    }
    var response = await httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      return recipes;
    }
    return null;
  }
}
