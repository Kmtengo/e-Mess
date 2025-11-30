# e-Mess POS Application

The **e-Mess POS Application** is a robust Android-based self-service Point of Sale system designed to streamline the meal ordering process. Built with **Flutter**, it provides an intuitive interface for users to browse menus, customize orders, and securely complete transactions using biometric authentication.

## 📱 Features

- **Dynamic Menu System**:
  - Categorized meal selection (Breakfast, Lunch, Tea, Supper).
  - Real-time availability tracking.
  - Visual meal cards with price and description.

- **Smart Ordering**:
  - Cart management with quantity adjustments.
  - Instant total price calculation.
  - Order confirmation summary.

- **Secure Authentication**:
  - Integrated biometric verification (Fingerprint) for order authorization.
  - Fallback simulation for testing environments.

- **Digital Checkout**:
  - Generates unique order IDs.
  - Displays digital receipts with timestamps.
  - Option to print receipts (integration ready).

- **Additional Tools**:
  - **QR Code Scanner**: For quick item lookup or user identification.
  - **Statistics & History**: Track user spending and order history (in development).

## 🛠️ Technical Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Navigation**: Flutter Named Routes
- **Key Packages**:
  - `http`: API communication.
  - `local_auth`: Biometric authentication.
  - `qr_code_scanner` & `mobile_scanner`: QR code processing.
  - `shared_preferences`: Local data persistence.
  - `printing`: Receipt printing capabilities.

## 📂 Project Structure

```
lib/
├── models/          # Data models (Meal, etc.)
├── providers/       # State management logic (MealProvider)
├── screens/         # UI Screens (Home, Confirmation, Auth, Checkout)
├── widgets/         # Reusable UI components (AppDrawer, MealCard)
├── main.dart        # Application entry point
└── routes.dart      # Route definitions
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.1.2 <4.0.0)
- Android Studio / VS Code with Flutter extensions
- Android Device or Emulator

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/e-mess.git
   cd e-mess
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development and a full API reference.

## Design Language

For detailed information about the app's design system, including color palette, typography, components, and UI patterns, please refer to the [Design Language Specification](DESIGN_LANGUAGE.md).
