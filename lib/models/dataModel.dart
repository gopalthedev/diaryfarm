
class ShelterData{
  ShelterData({required this.totalFood, required this.totalMilk, required this.dailyDataList, required this.temp, required this.waterLevel, required this.gas, required this.humidity});
  double totalFood;
  double totalMilk;
  double temp;
  double waterLevel;
  double humidity;
  double gas;
  List<DailyData> dailyDataList;

}

class DailyData{
  DailyData(this.date, this.food, this.food1, this.food2, this.milk);
  double date;
  double food;
  double food1;
  double food2;
  double milk;
}