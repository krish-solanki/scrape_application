# ♻️ ScrapVision AI

ScrapVision AI is a Flutter-based mobile application that helps users identify, manage, and estimate the value of metal scrap using Artificial Intelligence. The app allows users to scan scrap materials, classify them using a TensorFlow Lite model, and store inventory securely with Firebase.

---

## ✨ Features

- 🤖 AI-powered metal scrap detection
- 📷 Scan scrap using the device camera
- 🧠 TensorFlow Lite model integration
- 🏷️ Detect metal type (Iron, Steel, Copper, Aluminium)
- 💰 Estimate scrap value based on weight
- 🔐 Firebase Authentication
- ☁️ Cloud Firestore integration
- 📦 Scrap inventory management
- ❤️ Mark favorite items
- 📱 Responsive Flutter UI
- 🖼️ Image Picker support
- 💾 Local storage using Hive
- 📊 Scan history

---

## 🛠️ Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- TensorFlow Lite
- Google ML Kit
- Hive
- Provider
- Git & GitHub

---

## 📂 Project Structure

```
lib/
├── controller/
├── model/
├── service/
├── utils/
├── view/
│   ├── auth/
│   ├── dashboard/
│   ├── inventory/
│   ├── scan/
│   ├── profile/
│   └── splash/
├── widget/
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git
- Firebase Project

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/krish-solanki/scrape_application.git
```

### 2. Go to the project folder

```bash
cd scrape_application
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

- Create a Firebase project.
- Add Android/iOS applications.
- Download the Firebase configuration files.
- Enable Authentication and Firestore.

### 5. Run the application

```bash
flutter run
```

---

## 📦 Packages Used

- firebase_core
- firebase_auth
- cloud_firestore
- provider
- image_picker
- camera
- google_mlkit_object_detection
- google_mlkit_image_labeling
- tflite_flutter
- hive
- hive_flutter
- flutter_screenutil

---

## 📱 Application Screens

- Splash Screen
- Login
- Register
- Dashboard
- Scan Scrap
- Scrap Details
- Inventory
- Profile

---

## 🤖 AI Model

The application uses a TensorFlow Lite model to classify different types of metal scrap.

### Supported Categories

- Iron
- Steel
- Copper
- Aluminium

The model predicts the scrap type with a confidence score, helping users identify materials quickly.

---

## 🔥 Firebase Features

- User Authentication
- Cloud Firestore Database
- User-specific inventory
- Scan history storage

---

## 📈 Future Improvements

- Real-time scrap market prices
- Barcode/QR code scanning
- Multi-language support
- Export inventory as PDF or Excel
- Cloud image storage
- AI model improvements
- Offline synchronization

---

## 🤝 Contributing

Contributions are welcome.

1. Fork the repository.
2. Create a feature branch.

```bash
git checkout -b feature-name
```

3. Commit your changes.

```bash
git commit -m "Add new feature"
```

4. Push the branch.

```bash
git push origin feature-name
```

5. Open a Pull Request.

---

## 📄 License

This project was developed for educational and portfolio purposes.

---

## 👨‍💻 Author

**Krish Solanki**

Flutter Developer

GitHub: https://github.com/krish-solanki

---

## ⭐ Support

If you found this project helpful, consider giving it a **⭐ Star** on GitHub. It helps others discover the project and supports my work.
