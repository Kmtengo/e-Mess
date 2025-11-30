import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'checkout.dart';

class AuthenticationPage extends StatefulWidget {
  final List<Meal> selectedMeals;
  final double totalAmount;

  const AuthenticationPage({
    Key? key,
    required this.selectedMeals,
    required this.totalAmount,
  }) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _isAuthenticating = false;
  bool _hasError = false;

  Future<void> _authenticateUser() async {
    setState(() {
      _isAuthenticating = true;
      _hasError = false;
    });

    try {
      // Simulate fingerprint authentication
      await Future.delayed(Duration(seconds: 2));
      
      // TODO: Add actual fingerprint authentication logic here
      
      // If authentication is successful, navigate to checkout
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(
            selectedMeals: widget.selectedMeals,
            totalAmount: widget.totalAmount,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _hasError = true;
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Required'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint,
                size: 120,
                color: _hasError ? Colors.red : Colors.green,
              ),
              SizedBox(height: 24),
              Text(
                'Place your finger on the scanner',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Total Amount to be Deducted: Ksh ${widget.totalAmount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              if (_isAuthenticating)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              else
                ElevatedButton(
                  onPressed: _authenticateUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Authenticate',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              if (_hasError) ...[
                SizedBox(height: 16),
                Text(
                  'Authentication failed. Please try again.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
