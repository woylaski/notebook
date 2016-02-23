/*
用关键字property增加属性
*/
import QtQuick 2.0  
  
Rectangle  
{  
    id:rect1  
  
    //property alias text:txt.text  
    property string str_txt:"hi,jdh"  
  
    width: 100  
    height: 50  
  
    Text  
    {  
        id:txt  
        text:rect1.str_txt  
    }  
}  