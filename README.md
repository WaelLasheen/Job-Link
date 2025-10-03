# 📱 Job Link App

**Job Link App** is my final project during the ITI training.  
It is a simple **freelancing platform** where:

- **Job owners** can post jobs.
- **Freelancers** can apply to jobs.
- Job owners can **accept or reject** applicants and send **tasks** to the accepted freelancers.

---

## 🚀 Features

- 👤 **Authentication & Database** using Firebase.  
- 📄 **CV Storage** with Supabase.  
- 📡 **Real-time interaction** between job owners and freelancers.  
- 📶 **Offline support**: Tasks are cached and available offline using Hive.  
- 🧩 **Cubit for State Management** to keep the app clean and maintainable.  

---

## 🛠 Tech Stack

- [Flutter](https://flutter.dev/) – Cross-platform development  
- [Cubit](https://bloclibrary.dev/#/cubit) – State management  
- [Firebase](https://firebase.google.com/) – Auth & database  
- [Supabase](https://supabase.com/) – File storage (CVs)  
- [Hive](https://docs.hivedb.dev/) – Offline local database  

---

## 📸 Screenshots

<p align="center">
  <img src="https://i.postimg.cc/vTnN31KT/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/k5MLqgVG/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/056RzjVr/Screenshot.jpg" width="250"/>
</p>

<p align="center">
  <img src="https://i.postimg.cc/PqFVHzsp/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/156kKThh/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/PxRyGtDV/Screenshot.jpg" width="250"/>
</p>

<p align="center">
  <img src="https://i.postimg.cc/gJJsBwxR/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/qMCbTCjt/Screenshot.jpg" width="250"/>
  <img src="https://i.postimg.cc/v8pRfyK5/Screenshot.jpg" width="250"/>
</p>

👉 **See the full album here:** [Screenshots Gallery](https://postimg.cc/gallery/tj6HWJH)

---

## ⚡ Installation & Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/YOUR_USERNAME/job-link-app.git
   cd job-link-app
   
2. Install dependencies:
   ```bash
   flutter pub get

3. Setup **Firebase**:

   * Create a new project in [Firebase Console](https://console.firebase.google.com/).
   * Enable **Authentication** (Email/Password).
   * Enable **Cloud Firestore**.
   * Download your Firebase config file:

     * **Android** → `google-services.json` → put it inside `android/app/`.
     * **iOS** → `GoogleService-Info.plist` → put it inside `ios/Runner/`.
   * Run the FlutterFire CLI to generate `firebase_options.dart`:

     ```bash
     flutterfire configure
     ```
   * Replace the generated `firebase_options.dart` inside `/lib/core/`.

4. Setup **Supabase**:

   * Go to [Supabase](https://supabase.com/) and create a new project.
   * Get your **Project URL** and **Anon/Public API Key** from the dashboard.
   * Create a bucket (e.g., `freelancers_CV`) for storing CV files.
   * Add your Supabase credentials in a safe place (e.g., `config.dart` or environment variables).
     ⚠️ **Do not commit these files**.

5. Run the app:

   ```bash
   flutter run
   ```

---

📌 **Notes**

* I removed my private config files (**Firebase & Supabase**), so you must add your own.
* This project was built for **educational purposes** as part of my ITI training.
* Feel free to explore, learn, and extend the project.

---

🎯 **Future Improvements**

* 🔔 Notifications for job updates.
* 💬 Chat between job owners and freelancers.
* 🎨 Improved UI/UX design.
