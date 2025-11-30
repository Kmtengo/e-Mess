import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/meal.dart';
import '../checkout.dart';

class QRScannerModal extends StatefulWidget {
  const QRScannerModal({super.key});

  @override
  State<QRScannerModal> createState() => _QRScannerModalState();
}

class _QRScannerModalState extends State<QRScannerModal> {
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final String? qrData = barcodes.first.rawValue;
      if (qrData == null) {
        _showError('Invalid QR code');
        return;
      }

      // TODO: Replace with actual API call to fetch order details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      final orderData = _parseQRData(qrData);
      
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(
            selectedMeals: orderData.meals,
            totalAmount: orderData.total,
            orderId: orderData.orderId,
            userName: orderData.userName,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _showError('Error processing QR code: \${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
    setState(() {
      _isProcessing = false;
    });
  }

  // TODO: Replace with actual QR code data parsing
  OrderData _parseQRData(String qrData) {
    // Simulate parsing QR code data
    return OrderData(
      orderId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      userName: 'John Doe',
      meals: [
        Meal(
          id: '1',
          name: 'Pilau',
          imageUrl: 'images/pilau.png',
          price: 150,
          category: 'lunch',
          quantity: 2,
        ),
        Meal(
          id: '2',
          name: 'Beef',
          imageUrl: 'images/beef.png',
          price: 200,
          category: 'lunch',
          quantity: 1,
        ),
      ],
      total: 500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text(
                  'Scan QR Code',
                  style: TextStyle(
                    fontFamily: 'BungeeSpice',
                    color: Colors.deepOrange,
                    fontSize: 24.0,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.deepOrange),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  onDetect: _onDetect,
                  overlay: QRScannerOverlay(
                    overlayColor: Colors.black.withOpacity(0.7),
                  ),
                ),
                if (_isProcessing)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Position the QR code within the frame to scan',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class QRScannerOverlay extends StatelessWidget {
  final Color overlayColor;

  const QRScannerOverlay({
    super.key,
    required this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;

    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            overlayColor,
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  height: scanArea,
                  width: scanArea,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: scanArea,
            height: scanArea,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.tealAccent,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderData {
  final String orderId;
  final String userName;
  final List<Meal> meals;
  final double total;

  OrderData({
    required this.orderId,
    required this.userName,
    required this.meals,
    required this.total,
  });
}
