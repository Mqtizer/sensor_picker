import 'package:flutter/material.dart';

import 'picker_sensor.dart';
import 'utils.dart';

class SensorPicker extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 8,
      spacing: 8,
      children: defaultSensors
          .map(
            (currentSensor) => TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(102, 102),
                ),
                maximumSize: MaterialStateProperty.all(
                  const Size(102, 102),
                ),
                alignment: Alignment.center,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (onSensorClicked != null) {
                  onSensorClicked!(currentSensor);
                }
                if (controller != null) {
                  controller!.insertAtCursor(
                    currentSensor.templateString,
                  );
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
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
