import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 600
    height: 800
    visible: true
    title: qsTr("Image Viewer")

    Material.primary: "steelblue"
    Material.background: "lightgray"

    header: ToolBar{
        id: mainToolBar
        Material.foreground: "white"

        RowLayout{
            anchors.fill: parent

            ToolButton{
                contentItem: Image{
                    source: "qrc:/menu_icon"
                    fillMode: Image.Pad
                }
                onClicked: mainDrawer.open()
            }

            Label {
                text: qsTr("Image Viewer")
                horizontalAlignment: Qt.AlignHCenter
                Layout.fillWidth: true
                font.pointSize: 14
                font.bold: true
            }

            ToolButton{
                contentItem: Image{
                    source: "qrc:/settings_full_icon"
                    fillMode: Image.Pad
                }
                onClicked: mainMenu.open()

                Menu{
                    id:mainMenu
                    y: mainToolBar.height
                    MenuItem{
                        text: qsTr("Quit")
                        onTriggered: Qt.quit()
                    }
                }
            }
        }
    }

    Drawer{
        id: mainDrawer
        width: parent.width * 0.6
        height: parent.height

        ListView{
            id: imageSelector
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5
            focus: true

            model: imageModel

            delegate: Column{
                width: parent.width

                Image{
                    width: parent.width
                    source: model.url
                    fillMode: Image.PreserveAspectFit

                    MouseArea{
                        anchors.fill: parent
                        onClicked: imageSelector.currentIndex = model.index
                    }
                }
                Label{
                    text: model.name
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: (imageSelector.currentIndex == model.index)
                }
            }
        }
    }

    Image{
        id: photo
        anchors.fill: parent
        anchors.margins: 20
        fillMode: Image.PreserveAspectFit
        source: imageModel[(imageSelector.currentIndex)].url
    }
    /*
    ListModel{
        id: imageModel
        ListElement{ name: "Obrázek 1"; url: "qrc:/kote1.jfif"}
        ListElement{ name: "Obrázek 2"; url: "qrc:/kockabila.jpg"}
        ListElement{ name: "Obrázek 3"; url: "qrc:/catloaf.jpg"}
    }
    */
}
