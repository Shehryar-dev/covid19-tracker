import 'package:covid_app/Models/WorldStatesModel.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin{
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this)..repeat();

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
       body: SafeArea(
           child: Padding(
             padding: const EdgeInsets.all(15.0),
             child: SingleChildScrollView(
               child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   SizedBox(height: MediaQuery.of(context).size.height * .01,),
                   FutureBuilder(
                       future:statesServices.fetchWorldStatesRecord(),
                       builder: (context,AsyncSnapshot<WorldStatesModel> snapshots){
                         if(!snapshots.hasData){
                           return Expanded(
                             flex: 1,
                               child: SpinKitCircle(
                                 color: Colors.blueAccent,
                                 controller: _animationController,
                                 size: 50.0,

                               )
                           );
                         }else{
                           return Column(
                             children: [
                               SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                               PieChart(
                                   chartRadius: MediaQuery.of(context).size.width / 3.2,
                                   chartType: ChartType.ring,
                                   colorList: colorList,
                                   legendOptions:const LegendOptions(
                                       legendPosition: LegendPosition.left
                                   ),
                                   chartValuesOptions: const ChartValuesOptions(
                                     showChartValuesInPercentage: true,
                                     chartValueStyle: TextStyle(fontSize: 12,fontFamily: 'SF-Pro',color: Colors.black)
                                   ),
                                   animationDuration:const Duration(milliseconds: 1200),
                                   dataMap:  {
                                     "Total": double.parse(snapshots.data!.cases!.round().toString()),
                                     "Recovered": double.parse(snapshots.data!.recovered!.round().toString()),
                                     "Deaths": double.parse(snapshots.data!.deaths!.round().toString())
                                   }
                               ),
                               Padding(
                                 padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                                 child: Card(
                                   child: Column(
                                     children: [
                                       ReuseableRow(title: "Total Cases", value: snapshots.data!.cases!.round().toString()),
                                       ReuseableRow(title: "Deaths", value: snapshots.data!.deaths!.round().toString()),
                                       ReuseableRow(title: "Recovered", value: snapshots.data!.recovered!.round().toString()),
                                       ReuseableRow(title: "Active", value: snapshots.data!.active!.round().toString()),
                                       ReuseableRow(title: "Critical", value: snapshots.data!.critical!.round().toString()),
                                       ReuseableRow(title: "Today Cases", value: snapshots.data!.todayCases!.round().toString()),
                                       ReuseableRow(title: "Today Deaths", value: snapshots.data!.todayDeaths!.round().toString()),
                                       ReuseableRow(title: "Today Recovered", value: snapshots.data!.todayRecovered!.round().toString()),
                                     ],
                                   ),
                                 ),
                               ),
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesListScreen()));
                                 },
                                 child: Container(
                                   height:MediaQuery.of(context).size.height * .06,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                       color:const Color(0xff1aa260),
                                       borderRadius: BorderRadius.circular(15)
                                   ),
                                   child:const Text('Tracker Countries',style: TextStyle(fontFamily: 'SF-Heavy',fontSize: 18),),
                                 ),
                               ),
                             ],
                           );
                         }
                       }
                   ),
                 ],
               ),
             ),
           )
       ),
    );
  }
}


class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:10 ,top:10 ,bottom: 5,left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style:const TextStyle(fontWeight: FontWeight.bold,fontFamily: 'SF-Bold'),),
              Text(value,style: const TextStyle(fontFamily: 'SF-Medium'),),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}

