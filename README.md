# Sensor Picker

A Flutter package that provides an easy-to-use widget for selecting and displaying data from various device sensors.

## Features

- Ready-to-use sensor picker UI widget
- Support for common device sensors:
  - Accelerometer
  - Gyroscope
  - Magnetometer
  - Battery level
  - Time
- Template string replacement for sensor values
- Customizable appearance

## Getting Started

### Installation

Add `sensor_picker` to your `pubspec.yaml`:

```yaml
dependencies:
  sensor_picker: ^0.0.1
```

Run:

```bash
flutter pub get
```

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:sensor_picker/sensor_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a controller for a text field
    final TextEditingController controller = TextEditingController();
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Sensor Picker Example')),
        body: Column(
          children: [
            // Display the text field
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sensor data will appear here',
                ),
              ),
            ),
            
            // Add the sensor picker
            SensorPicker(
              controller: controller,
              onSensorClicked: (sensor) {
                // Optional: do something when a sensor is clicked
                print('Selected sensor: ${sensor.name}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Using Template Strings

You can use template strings to insert sensor values into text:

```dart
String text = "Current acceleration: {{accelerometer}}";
String replacedText = await replaceAllTemplateStrings(text);
print(replacedText); // "Current acceleration: [0.01, 9.81, 0.02]"
```

## Available Sensors

| Sensor        | Template String   | Description                                      |
| ------------- | ----------------- | ------------------------------------------------ |
| Accelerometer | {{accelerometer}} | Returns [x, y, z] values for device acceleration |
| Gyroscope     | {{gyroscope}}     | Returns [x, y, z] values for device rotation     |
| Magnetometer  | {{magnetometer}}  | Returns [x, y, z] values for magnetic field      |
| Battery       | {{battery}}       | Returns battery percentage level                 |
| Time          | {{time}}          | Returns current time in ISO 8601 format          |

## Customization

You can provide your own list of sensors:

```dart
SensorPicker(
  controller: myController,
  sensors: [
    // Your custom sensor list
    PickerSensor(
      "customSensor",
      Icons.search,
      () async => "Custom Sensor Value",
    ),
    // Use existing sensors from defaultSensors list
    ...defaultSensors,
  ],
)
```

## API Reference

### Classes

- `SensorPicker` - Main widget for displaying sensor selection UI
- `PickerSensor` - Class representing a sensor with its properties and value retrieval function

### Utility Functions

- `replaceAllTemplateStrings(String)` - Replaces all template strings in text with actual sensor values
- `getSensorByTemplateString(String)` - Returns a sensor object from its template string
- `getIconDataBySensorName(String)` - Returns the icon for a sensor by name

## License

This package is licensed under the MIT License.
