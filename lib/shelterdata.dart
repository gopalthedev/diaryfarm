import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryfarm/models/dataModel.dart';

ShelterData shelterData =  ShelterData(dailyDataList: [],gas: 0,humidity: 0,temp: 0,totalFood: 0,totalMilk: 0,waterLevel: 0);
Future<void> getShelterData() async {
  try {
    await FirebaseFirestore.instance.collection('Shelter').doc(
        "bH2EEF3UDQLHKkVN9ebU").get().then((value) {
      shelterData.totalFood = value.get('totalFood').toDouble();
      shelterData.totalMilk = value.get('totalMilk').toDouble();
      shelterData.temp = value.get('temp').toDouble();
      shelterData.waterLevel = value.get('waterLevel').toDouble();
      shelterData.humidity = value.get('humidity').toDouble();
      shelterData.gas = value.get('gas');
      print("the data got from firestore : ${value.data()}");

      List<dynamic> temp = value.get('dailyProduction');
      List<DailyData> list = [];

      print("daily data list $temp");
      
      for (Map<String, dynamic> it in temp) {
        DailyData dataValue = DailyData(
            it['date'].toDouble(), it['food'].toDouble(), it['food1'].toDouble(), it['food2'].toDouble(), it['milk'].toDouble());
        list.add(dataValue);
      }
      shelterData.dailyDataList = list;
      print("the data got from firestore : ${value.data()}");
      print("model data : ${shelterData.totalMilk}");
      print("model data : ${shelterData.totalFood}");
      print("model data : ${shelterData.temp}");
      print("model data : ${shelterData.waterLevel}");
      for(DailyData it in list){
        print(it.date);
        print(it.food);
        print(it.food1);
        print(it.food2);
        print(it.milk);
      }
    });
  }
  catch (e){
    print("Error while getting the data $e");
  }
}