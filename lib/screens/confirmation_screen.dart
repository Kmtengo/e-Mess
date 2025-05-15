import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';
import '../authentication.dart';
import '../widgets/app_drawer.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {    return Scaffold(
      drawer: const AppDrawer(),      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.deepOrange),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Confirm Order',
          style: TextStyle(
            fontFamily: 'BungeeSpice',
            color: Colors.deepOrange,
            fontSize: 24.0,
          ),
        ),        backgroundColor: Colors.tealAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: LinearProgressIndicator(
              value: 0.5,
              minHeight: 8.0,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Expanded(
            child: Consumer<MealProvider>(
              builder: (context, mealProvider, _) {
                final selectedMeals = mealProvider.getSelectedMeals();
                
                if (selectedMeals.isEmpty) {
                  return const Center(
                    child: Text('No meals selected'),
                  );
                }

                return ListView.builder(
                  itemCount: selectedMeals.length,
                  itemBuilder: (context, index) {
                    final meal = selectedMeals[index];
                    return MealOrderItem(meal: meal);
                  },
                );
              },
            ),
          ),
          Consumer<MealProvider>(
            builder: (context, mealProvider, _) {
              final total = mealProvider.getTotal();
              
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ksh. ${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size(double.infinity, 50),
                      ),                      onPressed: total > 0 ? () {
                        final mealProvider = context.read<MealProvider>();
                        final selectedMeals = mealProvider.meals.where((m) => m.isSelected).toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthenticationPage(
                              selectedMeals: selectedMeals,
                              totalAmount: total,
                            ),
                          ),
                        );
                      } : null,
                      child: const Text(
                        'Proceed to Authentication',
                        style: TextStyle(
                          fontFamily: 'BungeeSpice',
                          color: Colors.deepOrange,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MealOrderItem extends StatelessWidget {
  final Meal meal;

  const MealOrderItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ksh. ${meal.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: meal.quantity > 1
                        ? () => context.read<MealProvider>().updateMealQuantity(
                              meal.id,
                              meal.quantity - 1,
                            )
                        : null,
                  ),
                  Text(
                    '${meal.quantity}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => context.read<MealProvider>().updateMealQuantity(
                          meal.id,
                          meal.quantity + 1,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
