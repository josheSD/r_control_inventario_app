import 'dart:math';

import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

import '../../domain/precision.dart';

class BarChartPrecision extends StatelessWidget {
  late Precision precision;

  BarChartPrecision({@required precision}) {
    this.precision = precision;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return DChartBar(
      data: precision.articulos
          .map((e) => {
                'id': 'Bar1',
                'data': [
                  {
                    'domain': e.nombreArticulo.length > 16
                        ? e.nombreArticulo.substring(0, 16)
                        : e.nombreArticulo,
                    'measure': double.tryParse(e.precision)
                  }
                ]
              })
          .toList(),
      // data: [
      //   {
      //     'id': 'Bar1',
      //     'data': precision.articulos
      //         .map((e) => {
      //               'domain': e.nombreArticulo.length > 16
      //                   ? e.nombreArticulo.substring(0, 16)
      //                   : e.nombreArticulo,
      //               'measure': e.totalActual
      //             })
      //         .toList(),
      //   },
      //   {
      //     'id': 'Bar2',
      //     'data': precision.articulos
      //         .map((e) => {
      //               'domain': e.nombreArticulo.length > 16
      //                   ? e.nombreArticulo.substring(0, 16)
      //                   : e.nombreArticulo,
      //               'measure': e.totalAnterior
      //             })
      //         .toList(),
      //   },
      // ],
      domainLabelPaddingToAxisLine: 16,
      axisLineTick: 2,
      axisLinePointTick: 2,
      axisLinePointWidth: 8,
      axisLineColor: Envinronment.colorPrimary,
      measureLabelPaddingToAxisLine: 16,
      barColor: (barData, index, id) {
        var random = Random();
        int randomNumber = random.nextInt(10);
        if (randomNumber % 2 == 0) {
          return Envinronment.colorSecond;
        }
        if (randomNumber % 2 != 0) {
          return Envinronment.colorThird;
        }
        return Envinronment.colorDanger;
      },
      barValue: (barData, index) => '${barData['measure']}',
      showBarValue: true,
      barValuePosition: BarValuePosition.outside,
      verticalDirection: false,
    );
  }
}
