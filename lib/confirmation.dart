import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'authentication.dart';

class ConfirmationPage extends StatefulWidget {
  final List<Meal> selectedMeals;

  const ConfirmationPage({Key? key, required this.selectedMeals})
      : super(key: key);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  double get totalAmount =>
      widget.selectedMeals.fold(0, (total, meal) => total + meal.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Your Order'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedMeals.length,
                itemBuilder: (context, index) {
                  final meal = widget.selectedMeals[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          meal.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        meal.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Price: Ksh ${meal.price}\nTotal: Ksh ${meal.totalPrice.toStringAsFixed(2)}',
                      ),
                      trailing: Container(
                        width: 120,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                              onPressed: meal.quantity > 1
                                  ? () => updateQuantity(meal, -1)
                                  : null,
                            ),
                            Text(
                              '${meal.quantity}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              color: Colors.green,
                              onPressed: () => updateQuantity(meal, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
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
                  Text(
                    'Total Amount: Ksh ${totalAmount.toStringAsFixed(2)}',                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: widget.selectedMeals.any((meal) => meal.quantity > 0)
                        ? () => navigateToAuthentication()
                        : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'Proceed to Authentication',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
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

  void updateQuantity(Meal meal, int change) {
    setState(() {
      final newQuantity = meal.quantity + change;
      if (newQuantity >= 1 && newQuantity <= 10) {
        meal.quantity = newQuantity;
      }
    });
  }

  void navigateToAuthentication() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationPage(
          selectedMeals: widget.selectedMeals,
          totalAmount: totalAmount,
        ),
      ),
    );
  }
}
