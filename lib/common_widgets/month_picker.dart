import 'package:flutter/material.dart';
import 'package:flutter_month_picker/flutter_month_picker.dart';
import 'package:intl/intl.dart';


class MonthPicker extends StatefulWidget {
  DateTime selectedMonth = DateTime.now();
  ValueNotifier<DateTime> selectedMonthNotifier = ValueNotifier<DateTime>(DateTime.now());

  MonthPicker.internal({super.key});
  static MonthPicker instance = MonthPicker.internal();
  factory MonthPicker() {
    return instance;
  }

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      height: 40,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: OutlinedButton.icon(
            onPressed: () {
              showMonthPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now())
                  .then((date) {
                if (date != null) {
                  setState(() {
                    widget.selectedMonth=date;
                    widget.selectedMonthNotifier.value=date;
                  });
                }
              });
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Center(
                  child: Icon(
                Icons.calendar_today_rounded,
                size: 18,
                color: Color.fromARGB(255, 136, 128, 128),
              )),
            ),
            label: Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Text(
                DateFormat("MMM,yyyy").format(widget.selectedMonthNotifier.value),
                style: const TextStyle(color: Colors.black),
              ),
            )),
            style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xDFE0E0E0),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
        ),
      ),
    );
  }
}
