//Created by Peter Gutstein
class DailyCase
{
  String area, state, country;
  int geoID, cases;
  Date date;
  
  DailyCase(String allData)
  {
    String[] list = split(allData, ',');
    
    date = new Date(list[0]);
    area = list[1];
    state = list[2];
    country = list[5];
    
    geoID = int(list[3]);
    cases = int(list[4]);
  }
  
  String toString()
  {
    return date + ": " + area + ", " + state + ", " + country + " Cases: " + cases;
  }
  
}
