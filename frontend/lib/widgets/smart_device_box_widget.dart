import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/app_constant.dart';

class SmartDeviceBoxWidget extends StatelessWidget {
  final String smartDeviceName;
  final String iconPath;
  final bool isPowerOn;
  final Function(bool)? onChanged;

  const SmartDeviceBoxWidget({
    Key? key,
    required this.smartDeviceName,
    required this.iconPath,
    required this.isPowerOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isPowerOn ? Colors.grey[900] : Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
          /*boxShadow: [
            BoxShadow(
              color: isPowerOn ? Colors.white : Colors.grey.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            )
          ],*/
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppConstant.verticalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    iconPath,
                    height: 55,
                    color: isPowerOn ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      smartDeviceName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isPowerOn ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
