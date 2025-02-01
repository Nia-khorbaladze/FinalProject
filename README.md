# Cypher

## 🚀 Overview
Cypher is an Demo iOS application that allows users to manage their cryptocurrency portfolio. Users can register, log in, buy, swap, and track their favorite coins with real-time price updates.

## 📌 Features
- **Authentication & Registration**: Firebase-based login.
- **Portfolio Management**: Track purchased coins.
- **Buy & Swap Coins**: Simulated transactions.
- **Favorites**: Add/manage favorite coins.
- **Search**: Browse cryptocurrencies.
- **Real-Time Data Updates**: Fetches latest prices from the CoinGecko API.
- **Local Caching**: Caches data in Core Data.

## 🛠 Tech Stack
- **SwiftUI & UIKit**: Hybrid UI.
- **Firebase**: Authentication & Firestore.
- **CoinGecko API**: Fetching live crypto data.
- **Core Data**: Caching.
- **Combine**: Real-time UI updates.

## 📂 Architecture
The project follows **Clean Architecture/MVVM**, divided into:
- **Domain Layer**: Business logic.
- **Data Layer**: API calls, repositories.
- **Core Layer**: Dependency injection, navigation.
- **Presentation Layer**: UI & reusable components.
- **Utilities**: Extensions & helper functions.

## 🔧 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/Nia-khorbaladze/FinalProject.git
2. Open in Xcode.
3. Install dependencies using Swift Package Manager (SPM).
4. Run the app.

## 🚀Future Improvements
- Real blockchain transactions.
- Dark mode.
- Improved animations.

## 📜 License
MIT License - See LICENSE for details.
