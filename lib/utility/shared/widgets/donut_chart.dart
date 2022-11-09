import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DonutChartWidget extends StatefulWidget {
  const DonutChartWidget(
      {Key? key, required this.chartData, this.isVisible, this.startAngle})
      : super(key: key);

  final List<GDPData>? chartData;
  final bool? isVisible;
  final int? startAngle;

  @override
  State<DonutChartWidget> createState() => _DonutChartWidgetState();
}

class _DonutChartWidgetState extends State<DonutChartWidget> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late bool isVisible;
  late int startAngle;

  @override
  void initState() {
    super.initState();
    _chartData = widget.chartData ?? getChartData();
    isVisible = widget.isVisible ?? false;
    _tooltipBehavior = TooltipBehavior(enable: true);
    startAngle = widget.startAngle ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          angle: 0,
          height: '100',
          radius: '0',
          widget: Text(
            '88%',
            style:
                Get.textTheme.headline4!.copyWith(fontWeight: FontWeight.w500),
          ),
        )
      ],
      legend: Legend(
        isVisible: isVisible,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        DoughnutSeries<GDPData, String>(
            legendIconType: LegendIconType.rectangle,
            dataSource: _chartData,
            xValueMapper: (GDPData data, _) => data.continent,
            yValueMapper: (GDPData data, _) => data.gdp,
            pointColorMapper: (GDPData data, _) => data.color,
            enableTooltip: true,

            //max startangle is 350
            startAngle: startAngle),
      ],
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Text Chat', 400, const Color(0xffF28500)),
      GDPData('Video Chat', 113, const Color(0xff35ABF4)),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp, this.color);

  final String continent;
  final int gdp;
  final Color color;
}
