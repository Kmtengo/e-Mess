import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(
            fontFamily: 'BungeeSpice',
            color: Colors.deepOrange,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 24),
            _buildSpendingChart(),
            const SizedBox(height: 24),
            _buildPopularItems(),
            const SizedBox(height: 24),
            _buildMealTimings(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard(
          'Total Spent',
          'Ksh. 15,000',
          Icons.money,
          Colors.green,
        ),
        _buildStatCard(
          'Orders',
          '45',
          Icons.shopping_cart,
          Colors.blue,
        ),
        _buildStatCard(
          'Favorite Meal',
          'Pilau',
          Icons.favorite,
          Colors.red,
        ),
        _buildStatCard(
          'Average Per Day',
          'Ksh. 500',
          Icons.trending_up,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Spending',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                        const FlSpot(4, 5),
                        const FlSpot(5, 3),
                      ],
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.teal.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularItems() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Most Popular Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            _buildPopularItem('Pilau', '65 orders', 'images/pilau.png'),
            _buildPopularItem('Chapati', '45 orders', 'images/chapati.png'),
            _buildPopularItem('Beef', '40 orders', 'images/beef.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularItem(String name, String orders, String imagePath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text(orders),
      trailing: const Icon(Icons.trending_up, color: Colors.green),
    );
  }

  Widget _buildMealTimings() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Peak Hours',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            _buildMealTiming('Breakfast', '7:00 AM - 9:00 AM'),
            _buildMealTiming('Lunch', '12:00 PM - 2:00 PM'),
            _buildMealTiming('Tea', '4:00 PM - 5:00 PM'),
            _buildMealTiming('Dinner', '7:00 PM - 9:00 PM'),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTiming(String meal, String timing) {
    return ListTile(
      leading: const Icon(Icons.access_time, color: Colors.teal),
      title: Text(meal),
      subtitle: Text(timing),
    );
  }
}
