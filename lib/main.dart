import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/meal.dart';
import 'providers/meal_provider.dart';
import 'screens/confirmation_screen.dart';
import 'routes.dart';
import 'widgets/qr_scanner_modal.dart';
import 'widgets/app_drawer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MealProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Mess',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'NunitoSans',
      ),
      home: const HomeScreen(),
      routes: AppRoutes.getRoutes(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final categories = ['breakfast', 'lunch', 'tea', 'supper'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Fetch meals when the app starts
    Future.microtask(() => context.read<MealProvider>().fetchMeals());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {    
    return Scaffold(      
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.account_circle_rounded, color: Colors.deepOrange),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        title: const Text(
          "e-Mess",
          style: TextStyle(
            fontFamily: 'BungeeSpice',
            color: Colors.deepOrange,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.deepOrange),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const QRScannerModal(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: LinearProgressIndicator(
              value: 0.25,
              minHeight: 8.0,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.deepOrange,
            labelStyle: const TextStyle(
              fontFamily: 'TiltNeon',
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Breakfast'),
              Tab(text: '  Lunch  '),
              Tab(text: '4pm Tea'),
              Tab(text: 'Supper'),
            ],
          ),
          Expanded(
            child: Consumer<MealProvider>(
              builder: (context, mealProvider, child) {
                if (mealProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (mealProvider.error.isNotEmpty) {
                  return Center(child: Text(mealProvider.error));
                }

                return TabBarView(
                  controller: _tabController,
                  children: categories.map((category) {
                    return Column(
                      children: [
                        Expanded(
                          child: MealCategoryGrid(category: category),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Confirm order button - outside TabBarView to remain static
          Consumer<MealProvider>(
            builder: (context, mealProvider, _) {
              final selectedMeals = mealProvider.getSelectedMeals();
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  onPressed: selectedMeals.isEmpty ? null : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Confirm Order (${selectedMeals.length})',
                    style: const TextStyle(
                      fontFamily: 'BungeeSpice',
                      color: Colors.deepOrange,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MealCategoryGrid extends StatelessWidget {
  final String category;

  const MealCategoryGrid({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (context, mealProvider, _) {
        final meals = mealProvider.getMealsByCategory(category);
        
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return MealCard(meal: meal);
          },
        );
      },
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.read<MealProvider>().toggleMealSelection(meal.id);
        },
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4.0),
                      ),
                      image: DecorationImage(
                        image: AssetImage(meal.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: const TextStyle(
                            fontFamily: 'DancingScript',
                            fontWeight: FontWeight.w900,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Ksh. ${meal.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (meal.isSelected)
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
