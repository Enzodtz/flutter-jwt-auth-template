// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WeighingProductDto {
  int id;
  int lineNumber;
  String batchNo;
  int mixNo;
  bool isExtra;
  int sequenceNumber;
  String productNumber;
  String weight;
  bool isDone;

  WeighingProductDto({
    required this.id,
    required this.lineNumber,
    required this.batchNo,
    required this.mixNo,
    required this.isExtra,
    required this.sequenceNumber,
    required this.productNumber,
    required this.weight,
    required this.isDone,
  });

  Future<List<DataRow>> getRows() async {
    return [
      DataRow(cells: [
        DataCell(
            Text(sequenceNumber.toString(), style: TextStyle(fontSize: 10))),
        DataCell(Text(productNumber, style: TextStyle(fontSize: 10))),
        DataCell(Text(weight, style: TextStyle(fontSize: 10))),
      ])
    ];
  }
}
