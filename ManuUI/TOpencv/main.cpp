#include <QCoreApplication>
#include <iostream>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace  cv;
using namespace std;

int main(int argc, char *argv[])
{
    QString file_full, file_name, file_path;
    QFileInfo fi;

    file_full = QFileDialog::getOpenFileName(this);

    fi = QFileInfo(file_full);
    file_name = fi.fileName();
    file_path = fi.absolutePath();

    Mat img = imread("/home/manu/girl.jpg", CV_LOAD_IMAGE_UNCHANGED); //read the image data in the file "MyPic.JPG" and store it in 'img'

         if (img.empty()) //check whether the image is loaded or not
         {
              cout << "Error : Image cannot be loaded..!!" << endl;
              //system("pause"); //wait for a key press
              return -1;
         }

         namedWindow("MyWindow", CV_WINDOW_AUTOSIZE); //create a window with the name "MyWindow"
         imshow("MyWindow", img); //display the image which is stored in the 'img' in the "MyWindow" window

         waitKey(0); //wait infinite time for a keypress

         destroyWindow("MyWindow"); //destroy the window with the name, "MyWindow"
    
    QCoreApplication a(argc, argv);

    return a.exec();
}

