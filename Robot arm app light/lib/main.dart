import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RobotArmControl(),
    );
  }
}

class RobotArmControl extends StatefulWidget {
  @override
  _RobotArmControlState createState() => _RobotArmControlState();
}

class _RobotArmControlState extends State<RobotArmControl> {
  double motor1 = 90, motor2 = 90, motor3 = 90, motor4 = 90;
  List poses = [];

  String baseUrl = "http://10.0.2.2/robot_api";

  @override
  void initState() {
    super.initState();
    fetchPoses();
  }

  Future<void> fetchPoses() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/get_run_pose.php"));
      if (response.statusCode == 200) {
        setState(() {
          poses = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching poses: $e");
    }
  }

  Future<void> savePose() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/save_pose.php"),
        body: {
          'motor1': motor1.toInt().toString(),
          'motor2': motor2.toInt().toString(),
          'motor3': motor3.toInt().toString(),
          'motor4': motor4.toInt().toString(),
        },
      );
      print("Response: ${response.body}");
      fetchPoses(); // تحديث القائمة بعد الحفظ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pose saved successfully")),
      );
    } catch (e) {
      print("Error saving pose: $e");
    }
  }

  void reset() {
    setState(() {
      motor1 = 90;
      motor2 = 90;
      motor3 = 90;
      motor4 = 90;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Robot Arm Control Panel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            sliderWidget("Motor 1", motor1, (val) => setState(() => motor1 = val)),
            sliderWidget("Motor 2", motor2, (val) => setState(() => motor2 = val)),
            sliderWidget("Motor 3", motor3, (val) => setState(() => motor3 = val)),
            sliderWidget("Motor 4", motor4, (val) => setState(() => motor4 = val)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: reset, child: Text("Reset")),
                ElevatedButton(onPressed: savePose, child: Text("Save Pose")),
                ElevatedButton(onPressed: () {}, child: Text("Run")),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: poses.isEmpty
                  ? Center(child: Text("No poses saved"))
                  : ListView.builder(
                      itemCount: poses.length,
                      itemBuilder: (context, index) {
                        var pose = poses[index];
                        return Card(
                          child: ListTile(
                            title: Text("Pose ${pose['id']}"),
                            subtitle: Text(
                                "Motors: ${pose['motor1']}, ${pose['motor2']}, ${pose['motor3']}, ${pose['motor4']}"),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderWidget(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toInt()}"),
        Slider(
          value: value,
          min: 0,
          max: 180,
          divisions: 180,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
