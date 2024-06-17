# Flutter Developer Task

## Overview

This repository contains a Flutter project.The project is a simple task management app featuring user authentication, managing data and CRUD operations on tasks using Firebase Authentication and firestore .

## Features


- **Authentication:**
  - email and password login and registration with form validation.
  - Multiple User Login

- **Task Management:**
  - Allow users to create, read, update, and delete tasks in Firestore.
  - Each task has the following properties:
    - **Title:** A short description of the task.
    - **Description:** A detailed explanation of the task.
    - **Deadline:** The date and time when the task is due.
    - **Expected Task Duration:** Estimated time to complete the task.
    - **Completion Status:** A button to mark the task as complete.

### Additional Features

- **Notifications:**
  - Set an alarm/notification to alert the user 10 minutes before the task deadline.
- **Form Handling:**
  - Properly handle form inputs, including validation and error handling.
- **UI/UX:**
  - Ensure a responsive and user-friendly interface.

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
4. Run the app:
   ```sh
   flutter run
