# Location Tracking Module – PickMyTask Flutter Intern Assessment

This Flutter application implements a real-time **location tracking module** using **MVVM architecture** and **Provider** for scalable, maintainable state management. It retrieves the user's live coordinates, reverse-geocodes them into readable address details, tracks movement continuously, and stores the location history in memory — without using any database.

---

## Features

### Core Features
- Handles **coarse and fine** location permissions  
- Displays **latitude, longitude, city, state, and pincode**  
- Shows **last updated timestamp**  
- Auto-updates location as the user moves  
- Maintains **location history** (in-memory)  
- Reverse-geocoding using **Google Geocoding API**  
- Clean and responsive UI (Material 3)

### Bonus Features
- Optional **Google Map view** with:
  - Live marker
  - Current location visualization

---

## 🛠 Tech Stack

- **Flutter (Dart)**
- **MVVM + Provider (`ChangeNotifier`)**
- `geolocator` — live location updates  
- `permission_handler` — permission control  
- `google_maps_flutter` — map view  
- `http` — API requests  
- `flutter_dotenv` — secure environment variables  

---

## How My Experience Helped

My hands-on experience with **Flutter, REST API integration, real-time updates, and clean architecture** helped me complete this module efficiently. It enabled me to:

- Implement a clean **MVVM flow**  
- Handle async location streams and update UI smoothly  
- Use Google APIs for mapping and geocoding  
- Build clean, reusable UI widgets  
- Deliver a simple and user-friendly interface  

---

##  How to Run the Application

### **1️ Add your API key to `.env`**

Create a file named `.env` in the root directory and add a variable `GOOGLE_MAPS_API_KEY=[your api key]`

### **2 Add your API key to `/android/app/src/main/AndroidMainfest.xml`**

