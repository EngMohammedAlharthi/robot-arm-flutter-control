<?php
$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$motor1 = intval($_POST['motor1']);
$motor2 = intval($_POST['motor2']);
$motor3 = intval($_POST['motor3']);
$motor4 = intval($_POST['motor4']);

$sql = "INSERT INTO poses (motor1, motor2, motor3, motor4) VALUES ($motor1, $motor2, $motor3, $motor4)";

if ($conn->query($sql)) {
    echo "Pose saved";
} else {
    echo "Error: " . $conn->error;
}
?>
