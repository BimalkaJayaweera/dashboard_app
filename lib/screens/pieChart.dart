
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../getAPIData.dart';
import '../model/Model.dart';

class PieChart extends StatelessWidget {
  Map<String, Color> colorMap = {
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'green': Colors.green
    // Add more color mappings as needed
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Pie Chart'),
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

                      return Scaffold(
                          body: Center(
                              child: Container(
                                  child: SfCircularChart(
                                      series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<Model, String>(
                                            dataSource: modelData,
                                            pointColorMapper:(Model data,  _) => colorMap[data.color],
                                            xValueMapper: (Model data, _) => data.independentVariable,
                                            yValueMapper: (Model data, _) => data.dependentVariable
                                        )
                                      ]
                                  )
                              )
                          )
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