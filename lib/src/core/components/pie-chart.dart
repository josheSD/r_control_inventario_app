import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class PieChart extends StatelessWidget {

  // PieChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    return DChartPie(
      data: [
        {'domain': 'Flutter', 'measure': 28},
        {'domain': 'React Native', 'measure': 27},
        {'domain': 'Ionic', 'measure': 20},
      ],
      fillColor: (pieData, index) {
        switch (pieData['domain']) {
          case 'Flutter':
            return Envinronment.colorSecond;
          case 'React Native':
            return Envinronment.colorThird;
          default:
            return Envinronment.colorDanger;
        }
      },
      pieLabel: (pieData, index) {
        return "${pieData['domain']}:\n${pieData['measure']}%";
      },
      labelPosition: PieLabelPosition.outside,
    );
  }
}
