# Flutter Developer Task

## Overview

This repository contains a Flutter project.The project is a simple task management app featuring user authentication, managing data and CRUD operations on tasks using Firebase Authentication and firestore .

https://github.com/amit2303/Task-Manager/assets/107394739/43953b15-f2c4-46d2-9397-16370c6d410d

## Features


- **Authentication:**
  - email and password login and registration with form validation.
  - Multiple User Login

- **Task Management:**
  - Allow users to create, read, update, and delete tasks in Firestore.
  - Each task has the following properties:
    - **Create:** *Tap* on Floating action Button
    - **Update:** *SingleTap* on the Task Tile.
    - **Delete:** *LongPress* on the Task Tile.
   

- **Notifications:**
  - notification to alert the user 10 minutes before the task deadline.


## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- A Firebase project with Firestore and Authentication enabled.

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/amit2303/Task-Manager
2. Navigate to the project directory::
   ```sh
   cd Task-Manager
   
3. Install dependencies:
   ```sh
   flutter pub get
4. Firebase setup:
   ```sh
   flutterfire configure
5. Run the app:
   ```sh
   flutter run
