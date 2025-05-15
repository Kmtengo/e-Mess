import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  final List<Meal> _meals = [];
  bool _isLoading = false;
  String _error = '';

  List<Meal> get meals => _meals;
  bool get isLoading => _isLoading;
  String get error => _error;

  List<Meal> getMealsByCategory(String category) {
    return _meals.where((meal) => meal.category.toLowerCase() == category.toLowerCase()).toList();
  }

  List<Meal> getSelectedMeals() {
    return _meals.where((meal) => meal.isSelected).toList();
  }

  double getTotal() {
    return _meals.where((meal) => meal.isSelected).fold(0, (total, meal) => total + meal.totalPrice);
  }

  Future<void> fetchMeals() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      // TODO: Replace with your actual API endpoint
      final response = await http.get(Uri.parse('http://your-api/meals'));
      
      if (response.statusCode == 200) {
        final List<dynamic> mealsJson = json.decode(response.body);
        _meals.clear();
        _meals.addAll(mealsJson.map((json) => Meal.fromJson(json)));
      } else {
        _error = 'Failed to fetch meals';
        
        // For offline testing, add some sample meals
        _meals.addAll([
          Meal(
            id: '1',
            name: 'Tea',
            imageUrl: 'images/tea.png',
            price: 15,
            category: 'breakfast',
          ),
          // Add more sample meals here
        ]);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleMealSelection(String mealId) {
    final index = _meals.indexWhere((m) => m.id == mealId);
    if (index != -1) {
      _meals[index] = _meals[index].copyWith(
        isSelected: !_meals[index].isSelected,
        quantity: _meals[index].isSelected ? 0 : 1,
      );
      notifyListeners();
    }
  }

  void updateMealQuantity(String mealId, int quantity) {
    final index = _meals.indexWhere((m) => m.id == mealId);
    if (index != -1) {
      _meals[index] = _meals[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void resetSelections() {
    for (var i = 0; i < _meals.length; i++) {
      _meals[i] = _meals[i].copyWith(isSelected: false, quantity: 0);
    }
    notifyListeners();
  }
}
