import 'package:flutter/material.dart';
import 'package:metrics_app/utils/widget_functions.dart';
import 'package:metrics_app/Screens/FiltersPage/Filter.dart';
import '../utils/constants.dart';

class DownedAPIs extends StatelessWidget {
  int numberOfDownedAPIs = 0;
  final GestureTapCallback onPressed;

  DownedAPIs({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FilterDropDown()));
      },
      fillColor: SUCCESS,
      splashColor: COLOR_WHITE,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              numberOfDownedAPIs.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          addHorizontalSpace(20),
          const Text(
            'DOWN',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
