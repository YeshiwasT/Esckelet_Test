import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/country_model.dart';

class CountryLocalDataSource {
  static const String _favoritesKey = 'favorite_countries';

  Future<List<String>> getFavoriteCountryNames() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString != null) {
      return List<String>.from(json.decode(jsonString));
    }
    return [];
  }

  Future<void> toggleFavorite(String countryName) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteCountryNames();

    if (favorites.contains(countryName)) {
      favorites.remove(countryName);
    } else {
      favorites.add(countryName);
    }

    await prefs.setString(_favoritesKey, json.encode(favorites));
  }
}
