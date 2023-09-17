class Widget 
{
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  
  Widget()
  {
    x=0; 
    y=0; 
    width = 0; 
    height= 0;
    label=""; 
    event=0;
    labelColor= color(0);
  }
  
  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event;
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
  }

  void draw(Boolean hovering)
  {
    if(hovering)
      stroke(255);
    else
      stroke(0);
    fill(widgetColor);
    rect(x,y,width,height, 10);
    fill(labelColor);
    textFont(widgetFont);
    text(label, x+15, y+height-15);
  }

  int getEvent(int mX, int mY)
  {
    if(mX>x && mX < x+width && mY >y && mY <y+height)
    {
      return event;
    }
  return EVENT_NULL;
  }
  
  boolean mouseOnButton(int mX, int mY)
  {
    if(mX>x && mX < x+width && mY >y && mY <y+height)
      return true;
    else
      return false;
  }
}
