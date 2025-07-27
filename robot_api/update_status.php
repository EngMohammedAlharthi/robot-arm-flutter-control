<?php
$conn = new mysqli('localhost', 'root', '', 'robot_arm_flutter');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$id = intval($_POST['id']);

$sql = "UPDATE poses SET status = 0 WHERE id = $id";

if ($conn->query($sql)) {
    echo "Status updated";
} else {
    echo "Error updating status: " . $conn->error;
}
?>
