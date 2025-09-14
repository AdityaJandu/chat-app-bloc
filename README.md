
# 💬 Chat App (Flutter + BLoC + Firebase)

A simple real-time chat application built with **Flutter**, **Firebase**, and **BLoC state management**.  
It supports authentication, chat room creation, and real-time messaging.

---

## 🚀 Features

✅ **User Authentication** – Login/Signup with Firebase Auth  
✅ **Chat Rooms** – Create & join chat rooms with other users  
✅ **Real-time Messaging** – Send and receive messages instantly using Firestore streams  
✅ **BLoC Architecture** – Clean separation of business logic and UI  
✅ **Scalable Codebase** – Follows Data → Domain → Presentation layer structure  

---

## 🏗️ Tech Stack

- **Flutter** – Cross-platform UI  
- **BLoC** – State management  
- **Firebase Auth** – User authentication  
- **Cloud Firestore** – Real-time database for messages & chat rooms  

---

## 📂 Project Structure

```bash
lib/
│
├── features/
│   ├── auth/
│   │   ├── data/               # Firebase Auth + Firestore user repo
│   │   ├── domain/             # Auth entities + repos
│   │   └── presentation/       # AuthBloc + AuthScreen
│   │
│   ├── chat/
│   │   ├── domain/             # Message entity + repo abstraction
│   │   ├── data/               # FirestoreMessageRepo implementation
│   │   └── presentation/       # ChatBloc + ChatScreen
│   │
│   └── chat_list/
│       ├── domain/             # ChatRoom entity + repo
│       ├── data/               # FirestoreChatRoomRepo
│       └── presentation/       # ChatRoomBloc + HomeScreen
│
└── main.dart                   # Entry point (MultiBlocProvider setup)
````

---

## 🔑 Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Enable **Authentication** (Email/Password).
3. Enable **Cloud Firestore** and set rules to allow read/write for authenticated users.
4. Configure `firebase_options.dart` using [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/):

   ```bash
   flutterfire configure
   ```

---

## 🧠 BLoC Overview

This project uses **BLoC** to separate UI from business logic.
Example for Chat Messages:

* **Events**:

  * `LoadMessageRequested(chatId)`
  * `SendMessageRequested(chatId, message)`
  * `DeleteMessageRequested(chatId, messageId)`

* **States**:

  * `ChatLoading`
  * `ChatLoaded(List<Message>)`
  * `ChatError(errorMessage)`

* **Repository**:

  * Fetches messages from Firestore.
  * Provides a real-time stream (`readRealTimeMessage`) so UI updates instantly.

---

## 🏃 How to Run Locally

1. **Clone this repo**

   ```bash
   git clone https://github.com/AdityaJandu/chat_app_bloc.git
   cd chat_app_bloc
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

## 📌 Roadmap

* [ ] User search when creating chat rooms
* [ ] Show last message preview in chat list
* [ ] Add image & file sharing
* [ ] Push notifications with Firebase Cloud Messaging
* [ ] Typing indicators

---

## 🤝 Contributing

Pull requests are welcome!
For major changes, open an issue first to discuss what you’d like to improve.


