class TextWidget extends Widget
{
  int maxlen;

  TextWidget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event, int maxlen)
  {
    super(x, y, width, height, label, widgetColor, widgetFont, event);
    this.maxlen = maxlen;
  }

  void append(char s)
  {
    if (s==BACKSPACE)
    {
      if (!label.equals(""))
        label=label.substring(0, label.length()-1);
    }
    else if (label.length() <maxlen && s != SHIFT)
    {
      label=label+str(s);
    }
  }
}
