// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PickerSensor {
  final Future<String> Function() getSensorValue;
  final String name;
  final IconData icon;

  PickerSensor(
    this.name,
    this.icon,
    this.getSensorValue,
  );

  String get templateString => "{{$name}}";

  @override
  bool operator ==(covariant PickerSensor other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;

  @override
  String toString() => 'PickerSensor(name: $name, icon: $icon)';
}

List<PickerSensor> defaultSensors = [
  PickerSensor(
    "accelerometer",
    Icons.speed_outlined,
    () async {
      try {
        AccelerometerEvent event = await accelerometerEventStream().first;
        return '[${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}]';
      } catch (e) {
        return "-NA-";
      }
    },
  ),
  PickerSensor(
    "gyroscope",
    Icons.rotate_left_outlined,
    () async {
      try {
        GyroscopeEvent event = await gyroscopeEventStream().first;
        return '[${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}]';
      } catch (e) {
        return "-NA-";
      }
    },
  ),
  PickerSensor(
    "magnetometer",
    Icons.explore_outlined,
    () async {
      MagnetometerEvent event = await magnetometerEventStream().first;
      return '[${event.x.toStringAsFixed(2)}, ${event.y.toStringAsFixed(2)}, ${event.z.toStringAsFixed(2)}]';
    },
  ),
  PickerSensor(
    "battery",
    Icons.battery_charging_full_outlined,
    () async {
      try {
        if (Platform.isIOS) {
          return "${(await BatteryInfoPlugin().iosBatteryInfo)!.batteryLevel!.toStringAsFixed(2)}%";
        } else if (Platform.isAndroid) {
          return "${(await BatteryInfoPlugin().androidBatteryInfo)!.batteryLevel!.toStringAsFixed(2)}%";
        }
        return "-NA-";
      } catch (e) {
        return "-NA-";
      }
    },
  ),
  PickerSensor(
    "time",
    Icons.access_time_outlined,
    () async {
      try {
        return DateTime.now().toIso8601String();
      } catch (e) {
        return "-NA-";
      }
    },
  ),
];

PickerSensor getSensorByTemplateString(String templateString) {
  return defaultSensors.firstWhere(
    (element) => element.templateString == templateString,
    orElse: () => defaultSensors[0],
  );
}

Future<String> replaceAllTemplateStrings(String text) async {
  if (text.contains("{{") == false) return text;
  RegExp regExp = RegExp(r"{{(.*?)}}");
  Iterable<RegExpMatch> matches = regExp.allMatches(text);
  for (RegExpMatch match in matches) {
    String templateString = match.group(0)!;
    PickerSensor sensor = getSensorByTemplateString(templateString);
    String sensorValue = await sensor.getSensorValue();
    text = text.replaceAll(templateString, sensorValue);
  }
  return text;
}

IconData getIconDataBySensorName(String name) {
  return defaultSensors
      .firstWhere(
        (element) => element.name == name,
        orElse: () => defaultSensors[0],
      )
      .icon;
}
