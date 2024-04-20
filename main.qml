import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.12
import QtQuick.Layouts 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("37.2 videoplayer")

    Video{
        id: video
        source: "qrc:/video/video/Deadpool3.mp4"
        width: parent.width
        height:  parent.height - controlPanel.height
        autoPlay: true
        fillMode:  VideoOutput.PreserveAspectFit

        onPositionChanged: {
            if (!slider.pressed) {
                slider.value = position
            }
        }


        onErrorChanged: {
            console.error("Video error: ", errorString)
        }
    }

    Rectangle {
        id: controlPanel
        width: parent.width
        height: parent.height * 0.2
        color: "#333333"
        anchors.bottom: parent.bottom

        RowLayout {
            width: parent.width
            height: controlPanel.height * 0.5
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            Button { text: "▶️"; onClicked: video.play() }
            Button { text: "⏸️"; onClicked: video.pause() }
            Button { text: "⏹"; onClicked: video.stop() }
            Button { text: "⏪️"; onClicked: video.seek(video.position - 5000) }
            Button { text: "⏩️"; onClicked: video.seek(video.position + 5000) }
        }

        Slider {
            id: slider
            width: parent.width * 0.95
            height:controlPanel.height * 0.3
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: video.duration
            value: video.position
            stepSize: 1000

            onMoved: video.seek(value)
        }
    }

}
