<?php
header('Content-Type: application/json');

$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');

if ($conn->connect_error) {
    die(json_encode(['error' => 'Connection failed: ' . $conn->connect_error]));
}

$result = $conn->query("SELECT * FROM poses ORDER BY id DESC");

if(!$result){
    die(json_encode(['error' => 'SQL Error: ' . $conn->error]));
}

$poses = [];
while ($row = $result->fetch_assoc()) {
    $poses[] = $row;
}

echo json_encode($poses);
?>
