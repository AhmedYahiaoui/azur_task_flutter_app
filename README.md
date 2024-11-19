# Azur Tech Task App

An advanced task management app with a user-friendly calendar view, notification scheduling, and state-of-the-art state management using Provider.

---

## **Features**

- **Task Management**: Create, update, and manage tasks effortlessly.
- **Calendar Views**: Toggle between monthly and daily views.
- **Notification System**: Receive reminders for tasks via scheduled notifications.
- **State Management**: Efficient management of app state using Provider.
- **Server Integration**: Synchronizes tasks with a backend server.

---

## **Project Structure**

The app is built with a modular architecture for better scalability and maintenance.

lib/ ├── controllers/ │ ├── providers/ # State management using Provider │ ├── services/ # Services for API and system-level integrations ├── models/ # Data models for the app ├── views/ # UI components (screens and widgets) │ ├── calendar/ # Calendar-specific views and widgets │ ├── home_view.dart # Main entry point for the app's interface │ ├── profile_view.dart # Profile and task list └── main.dart # App entry point

---

## **Setup Instructions**

### **Prerequisites**

Ensure the following are installed on your system:

1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **IDE**: Android Studio, VS Code, or any Flutter-compatible IDE.
3. **Development Tools**:
   - **iOS**: Xcode for iOS builds.
   - **Android**: Android Studio or ADB for Android builds.

### **Project Installation**

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd azur_tech_task_app

   ```

2. Install dependencies:

   flutter pub get

3. Run the app::

   1. iOS:

   ```bash
       flutter run -d ios (on simulator, flutter device, get the ID and then flutter run -d ID)
   ```

   2. Android:

   ```bash
       flutter run -d android (on simulator, flutter device, get the ID and then flutter run -d ID)
   ```

### **Key Providers**

1. TaskProvider:
   Manages task state, including fetching, creating, updating, and deleting tasks.

   Key Methods: - fetchTasksFromServer(): Fetches tasks from the server. - addTask(Task task): Adds a new task to the state. - deleteTask(String id): Deletes a task from the state.

2. ViewProvider
   Manages the state for toggling views between the Monthly and Daily calendar views.

   Key Methods:

   - updateView(bool isMonthlyView): Toggles between Monthly and Daily views.
   - isMonthlyView: Getter for the current view state.

3. AuthProvider
   Handles user authentication states.

   Key Methods:

   - signin(String email, String password): Logs in the user.
   - signup(String name,String email, String password): Logs in the user.
   - logout(): Logs out the user.

4. Services
   TaskService
   Responsible for interacting with the backend for task-related operations.

   Key Methods:

   - fetchTasksFromServer(): Fetches a list of tasks from the server.
   - sendTasksToServer(List<Task> tasks): Syncs tasks with the server.

5. NotificationService
   Manages notifications for tasks.

   Key Methods:

   - scheduleNotification(DateTime time, String title, String body): Schedules a notification.
   - cancelNotification(int id): Cancels a scheduled notification.

6. AuthService
   Handles authentication and user sessions.

   Key Methods:

   - login(String email, String password): Authenticates the user with the server.
   - logout(): Clears user session data.

7. Key Screens
   HomeView

   The main entry point of the app. It integrates:

   - Calendar views (MonthlyView and DailyView).
   - Task lists and filters.

8. ProfileView
   Displays user details and a categorized task list:

   - All Tasks
   - Today’s Tasks
   - Favorite Tasks
   - Tasks with Notifications

9. CalendarView
   A toggleable calendar interface that allows users to switch between:

   - MonthlyView: Displays tasks for the selected month.
   - DailyView: Focuses on tasks for a specific day.

10. AddTaskBottomSheet
    A modal bottom sheet to add new tasks with options for:
    - Setting reminders.
    - Marking tasks as favorites.

### ** Running Tests **

Running Tests

Unit tests validate the functionality of services and logic.

- Run unit tests:
  ```bash
      flutter test test/unit_test/...
  ```

Widget Tests

Widget tests ensure UI components function correctly.

- Run unit tests:
  ```bash
      flutter test test/widget_test/...
  ```
