import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(
            fontFamily: 'BungeeSpice',
            color: Colors.deepOrange,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual order count
        itemBuilder: (context, index) {
          return _buildOrderCard(
            orderNumber: '#${2024001 + index}',
            date: '2024-02-${15 - index}',
            items: ['Pilau x2', 'Beef x1', 'Chapati x3'],
            total: 450.00 + (index * 50),
            status: index % 3 == 0 ? 'Completed' : 'Processing',
          );
        },
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String date,
    required List<String> items,
    required double total,
    required String status,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          'Order $orderNumber',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: status == 'Completed' ? Colors.green[100] : Colors.orange[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'Completed' ? Colors.green[700] : Colors.orange[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Text(item),
                )),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Ksh ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.receipt, size: 18),
                      label: const Text('View Receipt'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Implement view receipt
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.replay, size: 18),
                      label: const Text('Reorder'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // TODO: Implement reorder
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
