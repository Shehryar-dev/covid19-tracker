import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchFilter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        // foregroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: searchFilter,
                  onChanged: (value){
                    setState(() {
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon:const Icon(Icons.search),
                    contentPadding:const  EdgeInsets.symmetric(horizontal: 20.0),
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.blue,width: 1.2),
                        borderRadius: BorderRadius.circular(50.0)
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: statesServices.CountryListApi(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshots){
                         if(!snapshots.hasData){
                           return ListView.builder(
                               itemCount: 10,
                               itemBuilder: (context, index){
                                 return Shimmer.fromColors(
                                   baseColor: Colors.grey.shade700,
                                   highlightColor: Colors.grey.shade100,
                                   child:Column(
                                       children: [
                                         ListTile(
                                           title: Container(height: 10,width: 89,color: Colors.white,),
                                           subtitle:Container(height: 10,width: 89,color: Colors.white,) ,
                                           leading: Container(height: 50,width: 50,color: Colors.white,),
                                         )
                                       ],
                                     ),
                                 );
                               }
                           );
                         }else{
                           return ListView.builder(
                             itemCount: snapshots.data!.length,
                               itemBuilder: (context, index){
                                 String name = snapshots.data![index]['country'].toString();
                                 String image =snapshots.data![index]['countryInfo']['flag'].toString();
                                  if(searchFilter.text.isEmpty){
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> detailScreen(
                                              name: name,
                                              image: image,
                                              totalCases: snapshots.data![index]['cases'],
                                              totalRecovered: snapshots.data![index]['recovered'],
                                              totalDeaths: snapshots.data![index]['deaths'],
                                              todayRecovered: snapshots.data![index]['todayRecovered'],
                                              test: snapshots.data![index]['tests'],
                                              critical: snapshots.data![index]['critical'],
                                              active: snapshots.data![index]['active'],
                                              todayCases: snapshots.data![index]['todayCases'],
                                              todayDeaths: snapshots.data![index]['todayDeaths'],
                                            )));
                                          },
                                          title: Text(snapshots.data![index]['country'].toString(),style:const TextStyle(fontFamily: "SF-Pro"),),
                                          subtitle: Text("Cases: " + snapshots.data![index]['cases'].toString(),style:const TextStyle(fontFamily: "SF-Reg"),),
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshots.data![index]['countryInfo']['flag'].toString())
                                          ),
                                        )
                                      ],
                                    );
                                  }else if(name.toLowerCase().contains(searchFilter.text.toLowerCase())){
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> detailScreen(
                                              name: name,
                                              image: image,
                                              totalCases: snapshots.data![index]['cases'],
                                              totalRecovered: snapshots.data![index]['recovered'],
                                              totalDeaths: snapshots.data![index]['deaths'],
                                              todayRecovered: snapshots.data![index]['todayRecovered'],
                                              test: snapshots.data![index]['tests'],
                                              critical: snapshots.data![index]['critical'],
                                              active: snapshots.data![index]['active'],
                                              todayCases: snapshots.data![index]['todayCases'],
                                              todayDeaths: snapshots.data![index]['todayDeaths'],
                                            )));
                                          },
                                          title: Text(snapshots.data![index]['country'].toString(),style:const TextStyle(fontFamily: "SF-Pro"),),
                                          subtitle:Text("Cases: " + snapshots.data![index]['cases'].toString(),style:const TextStyle(fontFamily: "SF-Reg"),),
                                          leading: Image(
                                              height: 50,
                                              width: 50,
                                              image: NetworkImage(snapshots.data![index]['countryInfo']['flag'].toString())
                                          ),
                                        )
                                      ],
                                    );
                                  }else{
                                    return Container();
                                  }
                               }
                           );
                         }
                      }
                  )
              )
            ],
          )
      ),
    );
  }
}
