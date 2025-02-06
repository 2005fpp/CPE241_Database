<?php
// Database connection settings
$host = "replace this with your IP";
$user = "replace this with your database username e.g. root";
$password = "replace this with your database password";
$dbname = "PS03"; // we use a PS03 database that have includes PK and FK

// Create a new MySQLi connection
$conn = new mysqli($host, $user, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

?>
