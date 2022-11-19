import 'dart:math';

import 'package:controlinventario/src/core/util/constantes.dart';
import 'package:controlinventario/src/domain/rotacion.dart';
import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

import '../../domain/precision.dart';

class BarChartRotacion extends StatelessWidget {
  late Rotacion rotacion;

  BarChartRotacion({@required rotacion}) {
    this.rotacion = rotacion;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return DChartBar(
      data: rotacion.articulos
          .map((e) => {
                'id': 'Bar1',
                'data': [
                  {
                    'domain': e.nombreArticulo.length > 16
                        ? e.nombreArticulo.substring(0, 16)
                        : e.nombreArticulo,
                    'measure': double.tryParse(e.rotacion)
                  }
                ]
              })
          .toList(),
      // data: [
      //   {
      //     'id': 'Bar1',
      //     'data': rotacion.articulos
      //         .map((e) => {
      //               'domain': e.nombreArticulo.length > 16
      //                   ? e.nombreArticulo.substring(0, 16)
      //                   : e.nombreArticulo,
      //               'measure': e.unidadStock
      //             })
      //         .toList(),
      //   },
      //   {
      //     'id': 'Bar2',
      //     'data': rotacion.articulos
      //         .map((e) => {
      //               'domain': e.nombreArticulo.length > 16
      //                   ? e.nombreArticulo.substring(0, 16)
      //                   : e.nombreArticulo,
      //               'measure': e.unidadSalida
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
        int randomNumber = random.nextInt(20);
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
