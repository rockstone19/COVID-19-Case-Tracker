//Class setup and constructor made by Creagh + set up.
class Grapher 
{
  int x, y, width, height, barWidth;
  String title; 
  int event, maxValue, labelAmount;
  String[] labels;
  int[] values;
  color graphColor, labelColor;
  PFont graphFont;

  Grapher()
  {
    x=0; 
    y=0; 
    width = 0; 
    height= 0;
    event=0;
    labelColor= color(0);
  }

  Grapher(int x, int y, int width, int height, int[] values, 
    color graphColor, PFont graphFont, String title)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    maxValue = max(values);
    this.graphColor=graphColor; 
    this.graphFont=graphFont;
    this.values = values;
    this.title = title;
  }

  void draw()
  {
    //Draw lines for approx readings
    fill(130);
    noStroke();
    rect(x,height, 1.15*width, 2);
    rect(x,1.25*height, 1.15*width, 2);
    rect(x,1.5*height, 1.15*width, 2);
    rect(x,1.75*height, 1.15*width, 2);
    
    rect(x-5,(.5*y), 5, 1.45*height);
    rect((x+(1.15*width)),(.5*y), 5, 1.45*height);
    rect(x,(.5*y), 1.15*width, 5);
    rect(x-4,(1.58*y), 1.165*width, 5);
    
    //Define width of bars and the amount of space between them
    int barWidth = (int)(.90*width)/values.length;
    int barSpacing = (width-barWidth)/values.length;
    
    //Draw the bars of the graph
    fill(0, 49, 83);
    if(darkMode)
      stroke(255, 255, 255);
    
    for (int i=0; i<values.length; i++)
      rect(i*barSpacing+x, 2*height-(values[i]*height)/maxValue, barWidth, (values[i]*height)/maxValue);
    
    //Start drawing text
    textFont(widgetFont);
    if (darkMode) 
      fill(255);
    else
      fill(0, 49, 83);
    
    text(title, x+width/4, height-50);
    textFont(dataFont);
    
    text(maxValue, x + width, height);
    text(3*maxValue/4, x + width, 1.25*height);
    text(maxValue/2, x + width, 1.5*height);
    text(maxValue/4, x + width, 1.75*height);
    text("0", x + width, 2*height);
  }
}
