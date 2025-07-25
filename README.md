# TaskMate ✅

**TaskMate** is a sleek and efficient task management app built with Flutter. Designed to boost your productivity, it allows you to manage your daily goals through an intuitive interface, light/dark modes, and secure Google Sign-In. It's modular, scalable, and follows best practices to ensure a smooth user experience.

---

## 📱 Features

- 📝 Add, update, and delete tasks effortlessly  
- ✅ View tasks categorized into All, Completed, and Pending  
- 🔐 Secure Google Sign-In with Firebase Authentication  
- 🌗 Light and Dark mode switch support  
- 💾 Local data storage using Hive  
- 🧹 Swipe-to-delete with animation  
- 📱 Clean, responsive UI for all device sizes  

---

## 🚀 Getting Started

### ✅ Prerequisites
- Flutter SDK (v3.5.3 or higher)
- Android Studio / VS Code
- Firebase project with Authentication (Google Sign-In enabled)

### 🔧 Setup

```bash
git clone https://github.com/your-username/taskmate.git
cd taskmate
flutter pub get
flutter run
flutter build apk --release
```
### 📦 APK Download

### 🛠️ Architecture
  - TaskMate uses the MVVM (Model-View-ViewModel) pattern with Provider for state management. This promotes a clean separation of concerns and scalable app structure.

### 📊 Architecture Diagram

### 📹 Demo Video
  - 🎥 Watch on Loom / Google Drive Link : 

### 🧠 Assumptions
 - The app assumes the user has an internet connection for Google Sign-In.

 - Task persistence is handled locally via Hive (offline support included).

 - Initial focus is on Android. iOS support can be added later.

 - No push notifications or reminders included in MVP to keep things lightweight.

### 🎨 UI and Design
 - Material Design 3 principles

 - Responsive layout across screen sizes

 - Color palette designed for accessibility

 - Custom Google Sign-In screen with branded assets (logo.png and image.png)

 - Smooth transitions and feedback animations

### 🧰 Packages Used
 - Package	Purpose
 - provider	State management
 - firebase_auth	Firebase Authentication
 - google_sign_in	Google Sign-In
 - hive, hive_flutter	Local storage
 - flutter_slidable	Swipe-to-delete actions
 - intl	Date/time formatting
 - google_fonts	Custom fonts
 - lottie	Optional animations


### 🔗 Acknowledgment
“This project is a part of a hackathon run by https://www.katomaran.com”

