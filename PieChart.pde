    // THE PIE CHART //
   // KEVIN MORLEY  //
  // 12-04-2021    //
 // 19-04-2021    //
void pieChart(float diameter, int[] data, float[] percent) 
{
  float lastAngle = 0;
  float sum1 = 0;
  float sum2 = 0;
  for (int i = 0; i < data.length; i++) 
  {
    sum1 += data[i];  //get the total amount of cases (for the state in question)
  }
  for (int i = 0; i < data.length; i++) 
  {
    percent[i] = (data[i]/sum1);
    percent[i] = (percent[i] * 360);
    percent[i] = round(percent[i]);
  }
  for (int i = 0; i < data.length; i++) 
  {
    sum2 += percent[i];
  }
  if(sum2 != 360){
    percent[14] = percent[14] - (sum2-360); // 'percent' Array must add up to 360 AT ALL COSTS. YOU'VE BEEN WARNED.
  }
  
  
  fill(0);
  ellipse(width/2, height/2, diameter, diameter);
  for (int i = 0; i < data.length; i++) 
  {
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray, 255, 255);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(percent[i]));
    lastAngle += radians(percent[i]);
    
    fill(gray, 255, 255);
    rect(width/2+250, (height/2-220)+(i*35), 35, 35);
  }
  textFont(dataFont);
  if (darkMode) 
  {
    fill(255);
  } 
  else 
  {
    fill(0);
  }
  text("January: " + data[0] + ", " + round(percent[0]*100/sum2) + "%", width/2+290, (150+35*0));
  text("February: " + data[1] + ", " + round(percent[1]*100/sum2) + "%", width/2+290, (150+35*1));
  text("March: " + data[2] + ", " + round(percent[2]*100/sum2) + "%", width/2+290, (150+35*2));
  text("April: " + data[3] + ", " + round(percent[3]*100/sum2) + "%", width/2+290, (150+35*3));
  text("May: " + data[4] + ", " + round(percent[4]*100/sum2) + "%", width/2+290, (150+35*4));
  text("June: " + data[5] + ", " + round(percent[5]*100/sum2) + "%", width/2+290, (150+35*5));
  text("July: " + data[6] + ", " + round(percent[6]*100/sum2) + "%", width/2+290, (150+35*6));
  text("August: " + data[7] + ", " + round(percent[7]*100/sum2) + "%", width/2+290, (150+35*7));
  text("September: " + data[8] + ", " + round(percent[8]*100/sum2) + "%", width/2+290, (150+35*8));
  text("October: " + data[9] + ", " + round(percent[9]*100/sum2) + "%", width/2+290, (150+35*9));
  text("November: " + data[10] + ", " + round(percent[10]*100/sum2) + "%", width/2+290, (150+35*10));
  text("December: " + data[11] + ", " + round(percent[11]*100/sum2) + "%", width/2+290, (150+35*11));
  text("January: " + data[12] + ", " + round(percent[12]*100/sum2) + "%", width/2+290, (150+35*12));
  text("February: " + data[13] + ", " + round(percent[13]*100/sum2) + "%", width/2+290, (150+35*13));
  text("March: " + data[14] + ", " + round(percent[14]*100/sum2) + "%", width/2+290, (150+35*14));
  
  textFont(widgetFont);
  
  text("Total No. of Cases Per Month", (width/3)-10, height/6);
}
