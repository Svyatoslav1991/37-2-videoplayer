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
        source: "src:/video/video/JohnWick4.mp4"
        width: parent.width
        height:  parent.height - controlPanel.height
        autoPlay: true
        fillMode:  VideoOutput.PreserveAspectFit

        onDurationChanged: {
            slider.maximumValue = duration
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
            Button { text: "⏸️ Pause"; onClicked: video.pause() }
            Button { text: "⏹ Stop"; onClicked: video.stop() }
            Button { text: "⏪️ Rewind"; onClicked: video.seek(video.position - 5000) }
            Button { text: "⏩️ Forward"; onClicked: video.seek(video.position + 5000) }
        }

        Slider {
            id: slider
            width: parent.width * 0.95
            height:controlPanel.height * 0.3
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            value: video.position

            onMoved: video.seek(value)
        }
    }

}
