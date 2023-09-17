class Screen
{
  ArrayList widgetList;
  
  Screen()
  {
    widgetList = new ArrayList();
  }
  
  void draw()
  {
    //Background color
    if(darkMode == true)
      background(50);
    else
      background(255);
      
    //Draw widgets
    for(int i = 0; i<widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw(aWidget.mouseOnButton(mouseX,mouseY));
    }
  }
  
  int getEvent(int mx, int my)
  {
    for(int i = 0; i<widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      if(aWidget.mouseOnButton(mx,my))
        return aWidget.getEvent(mx,my);
    }
    return EVENT_NULL;
  }
  
  void addWidget(Widget w)
  {
    widgetList.add(w);
  }
  
  ArrayList getWidgetList()
  {
    return widgetList;
  }
  
}
