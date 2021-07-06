import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SmeupCustomPicker extends CommonPickerModel {
  bool showSecondsColumn;
  List<String> minutesList;

  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  SmeupCustomPicker(
      {DateTime currentTime,
      LocaleType locale,
      this.showSecondsColumn = true,
      this.minutesList})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);

    this.middleList = this.minutesList;
    if (this.middleList == null) {
      this.setMiddleIndex(this.currentTime.minute);
    } else {
      this.setMiddleIndex(
          this.middleList.indexOf(this.currentTime.minute.toString()));
    }

    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  String middleStringAtIndex(int index) {
    if (this.middleList == null) {
      if (index >= 0 && index < 60) {
        return this.digits(index, 2);
      } else {
        return null;
      }
    } else {
      if (index >= 0 && index < middleList.length) {
        return middleList[index];
      } else {
        return null;
      }
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "";
  }

  @override
  String rightDivider() {
    return "";
  }

  @override
  List<int> layoutProportions() {
    return showSecondsColumn ? [1, 2, 1] : [1, 1, 0];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.middleList == null
                ? this.currentMiddleIndex()
                : int.parse(this.middleList[this.currentMiddleIndex()]),
            this.currentRightIndex());
  }
}
