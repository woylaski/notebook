import QtQuick 1.1

Rectangle {
   id: home
   width: 800
   height: 480

   color: "#cccccc"

   signal close()
   signal fileSelected(string folder, string fileName)
   signal folderSelected(string folder)

   property string currentFolder

   function openFolder(url) {
       //// This is available in all editors.folderSelected(url);
       console.log("opening folder " + url);
       currentFolder = url;
       var doc = new XMLHttpRequest();
       doc.onreadystatechange = function() {

           if (doc.readyState == XMLHttpRequest.DONE) {
               parseResult(doc.responseText);
           }
       }

       doc.open("GET", url);
       doc.send();
   }

    function parseResult(data) {
        var pattern=/href=\"(.*?)\"/gi;
        var result = pattern.exec(data);
        var model = Array();
        while (result) {
            console.log("Found " + result[1]);
            if (result == "/") // parent folder
                continue;
            var firstChar = result[1][0];
            if (firstChar != "?") {
                model.push(result[1])
                //console.log(result[1]);
            }
            result = pattern.exec(data);
        }
        updateListView(model);
    }

   function updateListView(model) {
       folderModel.clear();
       for (var i=0; i<model.length; i++) {
           var name = model[i];
           var isModel = name[name.length-1] == "/";
           folderModel.append({"fileName": name, "isFolder": isModel});
       }
   }

   // Will be populated by javascript
   ListModel {
       id: folderModel
   }

   Rectangle {
       id: list
       anchors.fill: parent
       color: "transparent"

       ListView {
            anchors {fill: parent; margins: 10}
            clip: true
           Component {
               id: fileDelegate

               Rectangle {
                   height: childrenRect.height + 10
                   width: parent.widt

//                   Image {
//                       id: folderIcon
//                       source: isFolder ? baseFolder + "images/folder.png" : "images/text.png"
//                   }

                   Text {
                       text: fileName;
                       color: "black"
                       font.pixelSize: 18
                       anchors {left: parent.left/*left: folderIcon.right*/; margins: 10}
                       MouseArea {
                           anchors.fill: parent
                           onReleased: {
                               if (isFolder) {
                                   openFolder(currentFolder + "fileName");
//                                   if (fileName[0] == "/")
//                                       openFolder(domain + fileName)
//                                   else
//                                        openFolder(currentFolder + fileName);
                               }
                               else
                                   fileSelected(currentFolder, fileName);

                           }
                       }

                   }
               }
           }

           model: folderModel
           delegate: fileDelegate
       }
   }

}
