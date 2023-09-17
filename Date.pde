//Created by Peter Gutstein for ease of use elsewhere
class Date
{
  int month, day, year;
  String dateString;
  
  Date(String dateString)
  {
    this.dateString = dateString;
    
    String[] list = split(dateString, '/');
    
    day = Integer.valueOf(list[0]);
    month = Integer.valueOf(list[1]);
    year = Integer.valueOf(list[2]);
  }
  
  
  String toString()
  {
    return dateString;
  }
  
  
}
