import 'package:flutter/material.dart';

import 'picker_sensor.dart';
import 'utils.dart';

class SensorPicker extends StatefulWidget {
  final List<PickerSensor>? sensors;
  final ValueChanged<PickerSensor>? onSensorClicked;
  final TextEditingController? controller;
  const SensorPicker({
    Key? key,
    this.onSensorClicked,
    this.sensors = const [],
    this.controller,
  }) : super(key: key);

  @override
  State<SensorPicker> createState() => _SensorPickerState();
}

class _SensorPickerState extends State<SensorPicker> {
  List<PickerSensor> sensorList = [];

  @override
  void initState() {
    super.initState();
    if (widget.sensors!.isEmpty) {
      sensorList.addAll(defaultSensors);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double itemWidth = 105;
    int numberOfColumns = ((context.screenWidth - 64) / itemWidth).floor();

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numberOfColumns,
        childAspectRatio: 1.33,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: sensorList.length,
      itemBuilder: (BuildContext context, int index) {
        PickerSensor currentSensor = sensorList[index];
        return TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onPressed: () {
            if (widget.onSensorClicked != null) {
              widget.onSensorClicked!(currentSensor);
            }
            if (widget.controller != null) {
              widget.controller!.insertAtCursor(currentSensor.templateString);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                        size: 24.0,
                      ),
                  child: Icon(
                    currentSensor.icon,
                  ),
                ),
                // child: currentSensor.icon,
              ),
              const SizedBox(height: 8),
              Text(
                currentSensor.name,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
