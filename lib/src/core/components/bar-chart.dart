import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class BarChart extends StatelessWidget {
  
  // BarChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return DChartBar(
      data: [
        {
          'id': 'Bar',
          'data': [
            {'domain': '2020', 'measure': 3},
            {'domain': '2021', 'measure': 4},
            {'domain': '2022', 'measure': 6},
            {'domain': '2023', 'measure': 1},
          ],
        },
      ],
      domainLabelPaddingToAxisLine: 16,
      axisLineTick: 2,
      axisLinePointTick: 2,
      axisLinePointWidth: 8,
      axisLineColor: Envinronment.colorPrimary,
      measureLabelPaddingToAxisLine: 16,
      barColor: (barData, index, id){
        if(index == 1){
          return Envinronment.colorSecond;
        }
        if(index == 2){
          return Envinronment.colorThird;
        }
        return Envinronment.colorDanger;
      },
      barValue: (barData, index) => '${barData['measure']}',
      showBarValue: true,
      barValuePosition: BarValuePosition.outside,
    );
  }
}
