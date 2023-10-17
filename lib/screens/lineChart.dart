
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../getAPIData.dart';
import '../model/Model.dart';

class LineChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
        middle: Text('Line Chart'),
    ),
    child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getModel(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("waiting"));
              }else{
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                else
                {
                  List<Model> modelData = snapshot.data;

                  return SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Initialize line series
                        LineSeries<Model, String>(
                          dataSource: modelData,
                          xValueMapper: (Model data, _) => data.independentVariable,
                          yValueMapper: (Model data, _) => data.dependentVariable,
                        )
                      ]
                  );


                }
              }
            },
          ),

        )
    )
    );
  }
}