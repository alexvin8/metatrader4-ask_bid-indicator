//================== Ask-Bid.mq4 ====================================/

//================== Declarations ===================================/

//+------------------------------------------------------------------+
//|                                                      Ask-Bid.mq4 |
//|                                Copyright 2019 github.com/alexvin8|
//+------------------------------------------------------------------+
#property copyright "github.com/alexvin8"
#property link      "https://github.com/alexvin8"
#property version   "1.00"
#property strict
#property indicator_chart_window
//----
extern   string   _=""; //>TL's PARAMETERS:
extern   int      tl_shift       =  4; // -  tl's shift
extern   int      tl_length      =  2; // -  tl's length
extern   color    tl_clr_ask=  clrRoyalBlue; //-  ask tl's color
extern   color    tl_clr_bid     =  clrOrangeRed;  //-  bid tl's color
extern   string   __="=========================";
extern   string   ___="";//>PRICE LABEL PARAMETERS:
extern   bool     show_price=false; // -  show ask/bid
extern   color    price_clr_ask=clrRoyalBlue; // -  ask price color
extern   color    price_clr_bid=clrOrangeRed;  // -  bid price color
extern   int      price_shift=2; // -  ask/bid price shift
extern   string   price_font="Arial"; // -  ask/bid price font
extern   int      price_size=7; // -  ask/bid price font size
extern   string   ____="=========================";
extern   string   _______="";   //>SPREAD PARAMETERS:
extern   bool     show_spread=  true; //-  show spread 
extern   int      spread_shift   =  6;// -  spread shift
extern   string   spread_font="Arial"; // -  spread font
extern   int      spread_size=8;// -  spread font size
extern   color    spread_clr=clrGray;// -  spread color 
extern   string   ________="=========================";
extern   string   _____="";   //>ASK/BID LABEL PARAMETERS:
extern   bool     show_ask_bid=false; // -  show ask/bid label
extern   int      ask_bid_shift=4; // -  ask/bid label shift
extern   string   ______="=========================";
extern   string   _________=""; //>MT4 ASK/BID LINES:
extern   bool     show_MT4_bid=false; // -  show MT4 BID line
//----
string   spreadCount,echo,micro,standared,mega;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Deletion();
   ChartSetInteger(ChartID(),CHART_SHOW_BID_LINE,true);
  }
//+------------------------------------------------------------------+
//| 
//+------------------------------------------------------------------+
int start()
  {
   double
   ask=MarketInfo(Symbol(),MODE_ASK),
   bid=MarketInfo(Symbol(),MODE_BID);
   string
   ask_1=DoubleToString(ask,5),
   bid_1=DoubleToString(bid,5);
//----
   Deletion();
//----
   TrendCreate(0,"ask_price",0,Time[0]+Period()*60*tl_shift,ask,Time[0]+Period()*60*tl_shift+Period()*60*tl_length,ask,tl_clr_ask,0,1,false,false,false,false,true,0);
   TrendCreate(0,"bid_price",0,Time[0]+Period()*60*tl_shift,bid,Time[0]+Period()*60*tl_shift+Period()*60*tl_length,bid,tl_clr_bid,0,1,false,false,false,false,true,0);
//----   
   if(show_price)
     {
      TextCreate(0,"ask_price_txt",0,Time[0]+Period()*60*price_shift,ask,ask_1,price_font,price_size,price_clr_ask,0,ANCHOR_LEFT_LOWER,false,false,true,0);
      TextCreate(0,"bid_price_txt",0,Time[0]+Period()*60*price_shift,bid,bid_1,price_font,price_size,price_clr_bid,0,ANCHOR_LEFT_UPPER,false,false,true,0);
     }
//----
   if(show_ask_bid)
     {
      TextCreate(0,"ask_price_txt2",0,Time[0]+Period()*60*ask_bid_shift,ask,"ASK","Arial",7,clrRoyalBlue,0,ANCHOR_LEFT_LOWER,false,false,true,0);
      TextCreate(0,"bid_price_txt2",0,Time[0]+Period()*60*ask_bid_shift,bid,"BID","Arial",7,clrRed,0,ANCHOR_LEFT_UPPER,false,false,true,0);
     }
//----
   if(show_MT4_bid)
     {
      ChartSetInteger(ChartID(),CHART_SHOW_BID_LINE,true);
     }
   else
     {
      ChartSetInteger(ChartID(),CHART_SHOW_BID_LINE,false);
     }
//----
   if(show_spread)
     {
      double diff=Ask-Bid,margineRequired=(MarketInfo(Symbol(),MODE_MARGINREQUIRED));
      switch(Digits)
        {
         case 0:
            spreadCount=DoubleToStr(diff,0);
            micro=DoubleToStr((diff)*10,2);
            standared=DoubleToStr((diff)*1,2);
            mega=DoubleToStr((diff)/10,2);
            echo= "0";
            break;
         case 1:
            spreadCount=DoubleToStr(diff*10,0);
            micro=DoubleToStr((diff*10)*10,2);
            standared=DoubleToStr((diff*10)*1,2);
            mega=DoubleToStr((diff*10)/10,2);
            echo= "1";
            break;
         case 2:
            spreadCount=DoubleToStr(diff*100,0);
            micro=DoubleToStr((diff*100)*10,2);
            standared=DoubleToStr((diff*100)*1,2);
            mega=DoubleToStr((diff*100)/10,2);
            echo= "2";
            break;
         case 3:
            spreadCount=DoubleToStr(diff*100,1);
            micro=DoubleToStr((diff*100)*10,2);
            standared=DoubleToStr((diff*100)*1,2);
            mega=DoubleToStr((diff*100)/10,2);
            echo= "3";
            break;
         case 4:
            spreadCount=DoubleToStr(diff*10000,0);
            micro=DoubleToStr((diff*10000)*10,2);
            standared=DoubleToStr((diff*10000)*1,2);
            mega=DoubleToStr((diff*10000)/10,2);
            echo= "4";
            break;
         case 5:
            spreadCount=DoubleToStr(diff*10000,1);
            micro=DoubleToStr((diff*10000)*10,2);
            standared=DoubleToStr((diff*10000)*1,2);
            mega=DoubleToStr((diff*10000)/10,2);
            echo= "5";
            break;
         default:
            spreadCount=DoubleToStr(diff*1000000,0);
            micro=DoubleToStr((diff*1000000)*10,2);
            standared=DoubleToStr((diff*1000000)*1,2);
            mega=DoubleToStr((diff*1000000)/10,2);
            echo= "";
            break;
        }
      TextCreate(0,"spread_txt",0,Time[0]+Period()*60*spread_shift,(ask+bid)/2,spreadCount,spread_font,spread_size,spread_clr,0,ANCHOR_LEFT,false,false,true,0);
     }
//----     
   return(0);
  }
//+------------------------------------------------------------------+
//| Создает линию тренда по заданным координатам                     |
//+------------------------------------------------------------------+
bool TrendCreate(const long            chart_ID=0,        // ID графика
                 const string          name="TrendLine",  // имя линии
                 const int             sub_window=0,      // номер подокна
                 datetime              time1=0,           // время первой точки
                 double                price1=0,          // цена первой точки
                 datetime              time2=0,           // время второй точки
                 double                price2=0,          // цена второй точки
                 const color           clr=clrRed,        // цвет линии
                 const ENUM_LINE_STYLE style=STYLE_SOLID, // стиль линии
                 const int             width=1,           // толщина линии
                 const bool            back=false,        // на заднем плане
                 const bool            selection=true,    // выделить для перемещений
                 const bool            ray_left=false,    // продолжение линии влево
                 const bool            ray_right=false,   // продолжение линии вправо
                 const bool            hidden=true,       // скрыт в списке объектов
                 const long            z_order=0)         // приоритет на нажатие мышью
  {
   ResetLastError();//--- сбросим значение ошибки
   if(ObjectFind(name)==-1)//--- создадим трендовую линию по заданным координатам
      ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);             //--- установим цвет линии
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);           //--- установим стиль отображения линии
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);           //--- установим толщину линии
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);             //--- отобразим на переднем (false) или заднем (true) плане
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);  //--- включим (true) или отключим (false) режим перемещения линии мышью
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);    //--- при создании графического объекта функцией ObjectCreate, по умолчанию объект
//--- нельзя выделить и перемещать. Внутри же этого метода параметр selection
//--- по умолчанию равен true, что позволяет выделять и перемещать этот объект
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_LEFT,ray_left);     //--- включим (true) или отключим (false) режим продолжения отображения линии влево
   ObjectSetInteger(chart_ID,name,OBJPROP_RAY_RIGHT,ray_right);   //--- включим (true) или отключим (false) режим продолжения отображения линии вправо
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);         //--- скроем (true) или отобразим (false) имя графического объекта в списке объектов
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);        //--- установим приоритет на получение события нажатия мыши на графике
   return(true);
  }
//+------------------------------------------------------------------+ 
//|  Delete objects                                                  |
//+------------------------------------------------------------------+ 
void Deletion()
  {
   ObjectDelete("ask_price");
   ObjectDelete("bid_price");
   ObjectDelete("ask_price_txt");
   ObjectDelete("bid_price_txt");
   ObjectDelete("ask_price_txt2");
   ObjectDelete("bid_price_txt2");
   ObjectDelete("spread_txt");
  }
//+------------------------------------------------------------------+ 
//| Creating Text object                                             | 
//+------------------------------------------------------------------+ 
bool TextCreate(const long              chart_ID=0,               // chart's ID 
                const string            name="Text",              // object name
                const int               sub_window=0,             // subwindow index
                datetime                time=0,                   // anchor point time
                double                  price=0,                  // anchor point price
                const string            text="Text",              // the text itself
                const string            font="Arial",             // font 
                const int               font_size=10,             // font size 
                const color             clr=clrRed,               // color 
                const double            angle=0.0,                // text slope 
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                const bool              back=false,               // in the background
                const bool              selection=false,          // highlight to move
                const bool              hidden=true,              // hidden in the object list
                const long              z_order=0)                // priority for mouse click
  {
//--- set anchor point coordinates if they are not set 
//ChangeTextEmptyPoint(time,price);
//--- reset the error value 
   ResetLastError();
//--- create Text object 
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {
      Print(__FUNCTION__,
            ": failed to create \"Text\" object! Error code = ",GetLastError());
      return(false);
     }
//--- set the text 
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- set text font 
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- set font size 
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- set the slope angle of the text 
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- set anchor type 
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- set color 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the object by mouse 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- successful execution 
   return(true);
  }
//+------------------------------------------------------------------+
