import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/diet_item.dart';
import 'package:gym_application/utils/languages_translator.dart';

class CustomDietItemTable extends StatelessWidget {
  final List<DietItem> items;

  const CustomDietItemTable({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final columns = [
      Keys.Id.name.tr,
      Keys.Ingredient.name.tr,
      Keys.Quantity.name.tr,
    ];
    var rows = getRows();
    var colms = getColumns(columns);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: DataTable(
        columns: colms,
        rows: rows,
      ),
    );
  }

  List<DataRow> getRows() => items.map((item) {
        final List<String> cells = [];
        cells.add(item.id.toString());
        cells.add(item.ingredient);
        cells.add(item.quantity);
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataColumn> getColumns(List<String> value) => value
      .map(
        (e) => DataColumn(
          label: Text(
            e,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      )
      .toList();

  List<DataCell> getCells(List<String> cells) => cells.map(
        (e) {
          return DataCell(
            Text(
              e,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          );
        },
      ).toList();
}
