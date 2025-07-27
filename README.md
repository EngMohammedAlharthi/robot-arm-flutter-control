# Robot Arm Control App (Flutter + PHP + MySQL)

## 📌 Overview
A Flutter application to control a robot arm with sliders, save poses to a MySQL database using PHP, and retrieve/display saved poses in real time.

---

## ✅ Features
- Control 4 motors with sliders.
- Reset button to default positions.
- Save poses to a database via API.
- Display saved poses in a list.
- Backend powered by PHP and MySQL.
- Works on Android Emulator or real devices.

---

## 🛠️ Technologies Used
- **Flutter** (Front-End)
- **PHP** (API)
- **MySQL** (Database)
- **XAMPP** (Local Server)

---

## 📂 Project Structure
```
/lib
   main.dart          # Flutter main file (UI + API calls)
htdocs/robot_api
   get_run_pose.php   # Fetch poses from DB
   save_pose.php      # Save pose to DB
   update_status.php  # Update pose status
```

---

## ⚙️ Setup Instructions

### 1️⃣ **Install Flutter & Android Studio**
- [Flutter Install Guide](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio)

### 2️⃣ **Set up XAMPP**
- Install XAMPP and start **Apache** and **MySQL**.
- Go to: `http://localhost/phpmyadmin`
- Create a database:
  ```sql
  CREATE DATABASE robot_arm_flutter;
  ```
- Create a table:
  ```sql
  CREATE TABLE poses (
      id INT AUTO_INCREMENT PRIMARY KEY,
      motor1 INT NOT NULL,
      motor2 INT NOT NULL,
      motor3 INT NOT NULL,
      motor4 INT NOT NULL,
      status TINYINT DEFAULT 0
  );
  ```

---

### 3️⃣ **Backend (PHP)**
- Inside `htdocs`, create a folder `robot_api`.
- Add the following files:

#### **get_run_pose.php**
```php
<?php
header('Content-Type: application/json');
$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');
if ($conn->connect_error) { die(json_encode(['error' => 'Connection failed'])); }
$result = $conn->query("SELECT * FROM poses ORDER BY id DESC");
$poses = [];
while ($row = $result->fetch_assoc()) { $poses[] = $row; }
echo json_encode($poses);
?>
```

#### **save_pose.php**
```php
<?php
$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');
if ($conn->connect_error) { die("Connection failed"); }
$motor1 = intval($_POST['motor1']);
$motor2 = intval($_POST['motor2']);
$motor3 = intval($_POST['motor3']);
$motor4 = intval($_POST['motor4']);
$sql = "INSERT INTO poses (motor1, motor2, motor3, motor4) VALUES ($motor1,$motor2,$motor3,$motor4)";
if ($conn->query($sql)) { echo "Pose saved"; } else { echo "Error"; }
?>
```

#### **update_status.php**
```php
<?php
$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');
$id = intval($_POST['id']);
$conn->query("UPDATE poses SET status=0 WHERE id=$id");
echo "Status updated";
?>
```

---

### 4️⃣ **Flutter Setup**
- Add `http` in `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```
- Run:
```
flutter pub get
```

---

### 5️⃣ **Flutter Main Code**
Add this in `lib/main.dart`:
```dart
// [PASTE THE FINAL CODE YOU TESTED WITH]
```

---

## ▶️ Run the App
```
flutter run -d emulator-5556
```

---

## ✅ API Base URL
For Android Emulator, use:
```
http://10.0.2.2/robot_api
```

---

## 🖼 Demo
- Sliders for motors.
- Buttons: Reset, Save Pose.
- List of saved poses from MySQL.

---

## 📜 License
MIT License
