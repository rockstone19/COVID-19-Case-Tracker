//Initialization of classes, fonts, variables etc. //<>//
import java.util.*;
PFont dataFont, widgetFont;
String lines[];
ArrayList<DailyCase> cases, casesLowHigh, casesByState, casesToShow;
int currentCase, totalPages, currentScreen;
Widget nextButton, lastButton, endButton, firstButton, 
  darkModeButton, goToGraph, goToData, loadStateGraph, goToChart, loadMonthChart, sortChronologically, sortByCases;
TextWidget focus, searchGraph, searchChart;
ArrayList<Screen> allScreens;
Screen allData, graphs, charts;
color teal = color(78, 164, 230);

Grapher graphOne, defaultGraph, currentGraph;
int[] graphTest = {10, 20, 40};
boolean pieChartDisplayed;
int[] newAreaMonthlyCases = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] percent = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int defaultCase[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

void setup()
{  
  //Decleration of variables: Peter Gutstein 
  size(1000, 700);
  dataFont = loadFont("AppleSymbols-18.vlw");
  widgetFont = loadFont("AppleSymbols-36.vlw");
  lines = loadStrings("cases-1M.csv");
  cases = new ArrayList<DailyCase>();
  casesLowHigh = new ArrayList<DailyCase>();

  allData = new Screen();                  //screen for allData (default)
  graphs = new Screen();                   //graphs screen
  charts = new Screen();                   //pie chart screen

  allScreens = new ArrayList<Screen>();    //add all screens to arrayList
  allScreens.add(allData);
  allScreens.add(graphs);
  allScreens.add(charts);

  currentCase = startCase;
  currentScreen = ALL_DATA;


  //WIDGET DECLARATIONS : Peter Gutstein
  nextButton = new Widget(835, 505+BUTTON_HEIGHT, BUTTON_WIDTH-60, BUTTON_HEIGHT, 
    "NEXT", color(teal), widgetFont, EVENT_BUTTON1);
  lastButton = new Widget(740, 505+BUTTON_HEIGHT, BUTTON_WIDTH-60, BUTTON_HEIGHT, 
    "BACK", color(teal), widgetFont, EVENT_BUTTON2);
  endButton = new Widget(740, 100+BUTTON_HEIGHT, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "LAST PAGE", color(teal), widgetFont, EVENT_BUTTON3);
  firstButton = new Widget(740, 45+BUTTON_HEIGHT, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "FIRST PAGE", color(teal), widgetFont, EVENT_BUTTON4);

  //Creagh Duggan
  sortChronologically = new Widget(725, 185+BUTTON_HEIGHT, BUTTON_WIDTH+55, BUTTON_HEIGHT, 
    "SORT BY DATE", color(teal), widgetFont, EVENT_BUTTON13);
  sortByCases = new Widget(720, 240+BUTTON_HEIGHT, BUTTON_WIDTH+65, BUTTON_HEIGHT, 
    "SORT BY CASES", color(teal), widgetFont, EVENT_BUTTON14);

  //Peter Gutstein
  searchGraph = new TextWidget(730, 10, 225, BUTTON_HEIGHT, 
    "ENTER AN AREA", color(72, 168, 85), widgetFont, EVENT_BUTTON8, 16);
  loadStateGraph = new Widget(540, 10, 190, BUTTON_HEIGHT, 
    "SEARCH", color(72, 168, 85), widgetFont, EVENT_BUTTON9);
  searchChart = new TextWidget(730, 10, 225, BUTTON_HEIGHT, 
    "ENTER AN AREA", color(72, 168, 85), widgetFont, EVENT_BUTTON11, 16);
  loadMonthChart = new Widget(540, 10, 190, BUTTON_HEIGHT, 
    "SEARCH", color(72, 168, 85), widgetFont, EVENT_BUTTON12);

  //Universal Widgets: Peter Gutstein
  darkModeButton = new Widget(10, 640, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "DARK MODE", color(128), widgetFont, EVENT_BUTTON5);
  goToData = new Widget(10, 55, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "VIEW DATA", color(78, 164, 230), widgetFont, EVENT_BUTTON6);
  goToGraph = new Widget(10, 110, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "GRAPHS", color(78, 164, 230), widgetFont, EVENT_BUTTON7);
  goToChart = new Widget(10, 165, BUTTON_WIDTH+20, BUTTON_HEIGHT, 
    "PIE CHART", color(78, 164, 230), widgetFont, EVENT_BUTTON10);


  //Add widgets to screens
  allData.addWidget(nextButton);
  allData.addWidget(lastButton);
  allData.addWidget(endButton);
  allData.addWidget(firstButton);
  //Creagh Duggan
  allData.addWidget(sortChronologically);
  allData.addWidget(sortByCases);

  graphs.addWidget(searchGraph);
  graphs.addWidget(loadStateGraph);

  charts.addWidget(searchChart);
  charts.addWidget(loadMonthChart);


  //Convert data to arraylist of cases 
  for (int index = 1; index < lines.length; index++)
  {
    DailyCase tempCase = new DailyCase(lines[index]);
    cases.add(tempCase);
    casesLowHigh.add(tempCase);
  }

  quickSort(casesLowHigh, 0, casesLowHigh.size()-1);

  //Graph stuff
  int values[] = {10, 20, 20, 10, 40, 50, 100, 100, 100, 100};
  graphOne = new Grapher(400, 400, 400, 200, values, color(255, 0, 0), dataFont, "TEST");

  int defaultCase[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int currentMonth = 0;

  //Get the peak number of cases for each month: Peter Gutstein
  for (int i = 0; i < cases.size()-1; i++)
  {
    if (cases.get(i).date.month == currentMonth+1)
    {
      if (defaultCase[currentMonth] < cases.get(i).cases)
        defaultCase[currentMonth] = cases.get(i).cases;
    } else if (cases.get(i).date.month == currentMonth-11)
    {
      if (defaultCase[currentMonth] < cases.get(i).cases)
        defaultCase[currentMonth] = cases.get(i).cases;
    } else if (cases.get(i).date.month == currentMonth + 2 || currentMonth - cases.get(i).date.month == 10)
    {
      currentMonth++;
      i = i-1;
    }
  }
  //Creagh Duggan
  casesToShow = cases;

  defaultGraph = new Grapher(250, 400, 600, 300, defaultCase, color(255, 0, 0), dataFont, "Peak Monthly Cases Nationwide");

  totalPages = cases.size()/CASES_PER_PAGE + 1;

  currentGraph = defaultGraph;
}

void draw()
{
  //Draw the screen
  allScreens.get(currentScreen).draw();

  //Text color
  if (darkMode) 
  {
    fill(255);
    stroke(255);
  } else
  {
    fill(0);
    stroke(0);
  }

  rect(195, 0, 5, 700);

  text("MENU", 60, 40);
  textFont(dataFont);

  //If the screen is all data
  if (currentScreen == ALL_DATA)
  {
    for (int x = 0; x < CASES_PER_PAGE; x++)
    {
      if (x+currentCase < casesToShow.size())
      {
        String temp = casesToShow.get(x + currentCase).toString();
        text(temp, 210, (x+1)*20);
      }
    }

    textFont(widgetFont);
    text("PAGE " + ((currentCase/CASES_PER_PAGE)+1) + "/" + totalPages, 700, 50);
  }
  //If viewing the graphs
  else if (currentScreen == GRAPHS)
  {
    currentGraph.draw();
  }
  //If viewing pie chart // Kevin did the pie chart stuff //
  else if (currentScreen == CHARTS)
  {
    colorMode(HSB);
    if (pieChartDisplayed == true) {
      pieChart(400, newAreaMonthlyCases, percent);
    }
    else{
      pieChart(400, defaultCase, percent);
    }
    colorMode(RGB);
  }

  darkModeButton.draw(darkModeButton.mouseOnButton(mouseX, mouseY));
  goToData.draw(goToData.mouseOnButton(mouseX, mouseY));
  goToGraph.draw(goToGraph.mouseOnButton(mouseX, mouseY));
  goToChart.draw(goToChart.mouseOnButton(mouseX, mouseY));
}

//Peter Gutstein
void mousePressed()
{
  int event = 0;
  //Checks for which button was pressed, returning which event
  if (nextButton.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
    event = EVENT_BUTTON1;
  else if (lastButton.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
    event = EVENT_BUTTON2;
  else if (endButton.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
    event = EVENT_BUTTON3;
  else if (firstButton.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
    event = EVENT_BUTTON4;
  else if (darkModeButton.mouseOnButton(mouseX, mouseY))
    event = EVENT_BUTTON5;
  else if (goToData.mouseOnButton(mouseX, mouseY))
    event = EVENT_BUTTON6;
  else if (goToGraph.mouseOnButton(mouseX, mouseY))
    event = EVENT_BUTTON7;
  else if (searchGraph.mouseOnButton(mouseX, mouseY) && currentScreen == GRAPHS)
    event = EVENT_BUTTON8;
  else if (loadStateGraph.mouseOnButton(mouseX, mouseY) && currentScreen == GRAPHS)
    event = EVENT_BUTTON9;
  else if (goToChart.mouseOnButton(mouseX, mouseY))
    event = EVENT_BUTTON10;
  else if (searchChart.mouseOnButton(mouseX, mouseY) && currentScreen == CHARTS)
    event = EVENT_BUTTON11;
  else if (loadMonthChart.mouseOnButton(mouseX, mouseY) && currentScreen == CHARTS)
    event = EVENT_BUTTON12;
  //Creagh Duggan
  else if (sortChronologically.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
    event = EVENT_BUTTON13;
  else if (sortByCases.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
   event = EVENT_BUTTON14;
   /*
   else if (sortByState.mouseOnButton(mouseX, mouseY) && currentScreen == ALL_DATA)
   event = EVENT_BUTTON15;
   */

  switch(event) 
  {
  case EVENT_BUTTON1:
    focus = null;
    if (currentCase + CASES_PER_PAGE < cases.size())
      currentCase += CASES_PER_PAGE;
    break;
  case EVENT_BUTTON2:
    focus = null;
    if (currentCase - CASES_PER_PAGE >= 0)
      currentCase -= CASES_PER_PAGE;
    break;
  case EVENT_BUTTON3:
    focus = null;
    currentCase = ((totalPages-1) * CASES_PER_PAGE);
    break;
  case EVENT_BUTTON4:
    focus = null;
    currentCase = 0;
    break;
  case EVENT_BUTTON5:
    focus = null;
    if (darkMode)
      darkMode = false;
    else
      darkMode = true;
    break;
  case EVENT_BUTTON6:
    focus = null;
    currentScreen = ALL_DATA;
    currentCase = startCase;
    break;
  case EVENT_BUTTON7:
    focus = null;
    currentScreen = GRAPHS;
    break;
  case EVENT_BUTTON8:
    focus = (TextWidget)searchGraph;   
    break;
    //Peter Gutstein for search function
  case EVENT_BUTTON9:
    String areaToFind = searchGraph.label;
    String areaToFindLower = areaToFind.toLowerCase();
    //Changes made by Creagh to fix bug:
    areaToFindLower = areaToFindLower.replaceAll("[^a-zA-Z0-9 ]", "");  

    //debugging purposes.
    println(areaToFind);

    //Default case
    if (areaToFindLower.equalsIgnoreCase("Nationwide") || areaToFindLower.equalsIgnoreCase(""))
      currentGraph = defaultGraph;

    //Find the state in the search box and generate a graph for it 
    else
    {
      boolean isValidSearch = false;
      ArrayList<DailyCase> newAreaCases = new ArrayList<DailyCase>();
      int newAreaMonthlyCases[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
      int newAreaCurrentMonth = 0;

      //Generate new arrayList containing only cases from that state
      for (int i = 0; i < cases.size()-1; i++)
      {
        if (cases.get(i).state.equalsIgnoreCase(areaToFindLower))
          newAreaCases.add(cases.get(i));
      }

      //Get the peak number of cases for each month in an state
      for (int i = 0; i < newAreaCases.size()-1; i++)
      {
        if (newAreaCases.get(i).date.month == newAreaCurrentMonth+1)
        {
          if (newAreaMonthlyCases[newAreaCurrentMonth] < newAreaCases.get(i).cases)
            newAreaMonthlyCases[newAreaCurrentMonth] = newAreaCases.get(i).cases;
        } else if (newAreaCases.get(i).date.month == newAreaCurrentMonth-11)
        {
          if (newAreaMonthlyCases[newAreaCurrentMonth] < newAreaCases.get(i).cases)
            newAreaMonthlyCases[newAreaCurrentMonth] = newAreaCases.get(i).cases;
        } else
        {
          newAreaCurrentMonth++;
          i = i-1;
        }
      }

      //Check to see if anything came up in search
      for (int index = 0; index < 15; index++)
      {
        if (newAreaMonthlyCases[index] != 0)
          isValidSearch = true;
      }

      //If something came up from the search
      if (isValidSearch)
      {
        for (int index = 0; index < 15; index++)
        {
          if (newAreaMonthlyCases[index] == 0)
            newAreaMonthlyCases[index] = 1; 
        }

        String titleString = "Peak Monthly Cases in " + areaToFind;
        currentGraph = new Grapher(250, 400, 600, 300, newAreaMonthlyCases, 
          color(255, 0, 0), dataFont, titleString);
      } else
        println("Not valid");
    }
    focus = null;
    break;
  case EVENT_BUTTON10:
    focus = null;
    currentScreen = CHARTS;
    break;
  case EVENT_BUTTON11:
    focus = (TextWidget)searchChart;
    break;
  case EVENT_BUTTON12:
    String areaToFind2 = searchChart.label;
    String areaToFindLower2 = areaToFind2.toLowerCase();
    //Changes made by Creagh to fix bug:
    areaToFindLower2 = areaToFindLower2.replaceAll("[^a-zA-Z0-9 ]", "");  

    //debugging purposes.
    println(areaToFind2);

    //Default case
    if (areaToFindLower2.equalsIgnoreCase("Nationwide") || areaToFindLower2.equalsIgnoreCase(""))
      currentGraph = defaultGraph;

    //Find the state in the search box and generate a graph for it 
    else
    {
      boolean isValidSearch = false;
      ArrayList<DailyCase> newAreaCases = new ArrayList<DailyCase>();
      for (int i = 0; i < newAreaMonthlyCases.length; i++) 
      {
        newAreaMonthlyCases[i] = 0;  //reset
      }
      int newAreaCurrentMonth = 0;

      //Generate new arrayList containing only cases from that state
      for (int i = 0; i < cases.size()-1; i++)
      {
        if (cases.get(i).state.equalsIgnoreCase(areaToFindLower2))
          newAreaCases.add(cases.get(i));
      }

      //Get the peak number of cases for each month in an state
      for (int i = 0; i < newAreaCases.size()-1; i++)
      {
        if (newAreaCases.get(i).date.month == newAreaCurrentMonth+1)
        {
          if (newAreaMonthlyCases[newAreaCurrentMonth] < newAreaCases.get(i).cases)
            newAreaMonthlyCases[newAreaCurrentMonth] = newAreaCases.get(i).cases;
        } else if (newAreaCases.get(i).date.month == newAreaCurrentMonth-11)
        {
            if(newAreaMonthlyCases[newAreaCurrentMonth] < newAreaCases.get(i).cases)
              newAreaMonthlyCases[newAreaCurrentMonth] = newAreaCases.get(i).cases;
        }
        else
        {
          newAreaCurrentMonth++;
          i = i-1;
        }
      }

      //Check to see if anything came up in search
      for (int index = 0; index < 15; index++)
      {
        if (newAreaMonthlyCases[index] != 0)
          isValidSearch = true;
      }

      //If something came up from the search
      if (isValidSearch)
      {
        for (int index = 0; index < 15; index++)
        {
          if (newAreaMonthlyCases[index] == 0)
            newAreaMonthlyCases[index] = 1; 
        }
        pieChartDisplayed = true;
      } else
        println("Not valid");
    }
    focus = null;
    break;
    //Creagh Duggan
  case EVENT_BUTTON13:
    casesToShow = cases;
    break;
  case EVENT_BUTTON14:
    casesToShow = casesLowHigh;
    break;
  case EVENT_BUTTON15:
    casesToShow = casesByState;
    break;
  default:
    focus = null;
  }
}

void keyPressed()
{
  if (focus != null)
    focus.append(key);
}

//Wen Geng Lin
void mouseWheel(MouseEvent event)
{
  double direction = event.getCount();
  if (direction>0)
  {
    focus = null;
    if (currentCase + CASES_PER_PAGE < cases.size())
      currentCase += CASES_PER_PAGE;
  }
  if (direction<0)
  {
    focus = null;
    if (currentCase - CASES_PER_PAGE >= 0)
      currentCase -= CASES_PER_PAGE;
  }
}
