import 'package:flutter/material.dart';

class detailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test, todayDeaths, todayCases;
  detailScreen({super.key, required this.name,required this.image,required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.totalRecovered,
    required this.todayCases,
    required this.todayDeaths,
    required this.test,
  });

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.name,style:const TextStyle(fontFamily: "SF-Pro"),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReuseableRow(title: "Cases", value: widget.totalCases.toString()),
                        ReuseableRow(title: "Deaths", value: widget.totalDeaths.toString()),
                        ReuseableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                        ReuseableRow(title: "Critical", value: widget.critical.toString()),
                        ReuseableRow(title: "Active", value: widget.active.toString()),
                        ReuseableRow(title: "Test", value: widget.test.toString()),
                        ReuseableRow(title: "Today Cases", value: widget.todayCases.toString()),
                        ReuseableRow(title: "Today Deaths", value: widget.totalDeaths.toString()),
                        ReuseableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                        ReuseableRow(title: "Today Deaths", value: widget.totalDeaths.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image,scale: 1),
                  radius: 60,
                )
              ],
            ),
        
          ],
        ),
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
