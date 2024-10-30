
import QtQuick 2.15

import QtQuick.Window 2.15

import CalculatorLogic 1.0

Window {

    id: mainWindow

    visible: true

    width: 360
    height: 616
    color: "#024873"

    title: qsTr("Калькулятор")

    Item {

        id: keyboardInputArea
        width: mainWindow.width
        height: mainWindow.height
        focus: true


        Keys.onReleased:
        {

            if (timer_5sec.running) { // Если таймер на ввод кода активен
                if (event.key === Qt.Key_1 || event.key === Qt.Key_2 || event.key === Qt.Key_3) {
                    btn_result.secret_code += event.text // Добавляем к коду вводимые цифры

                    // Проверяем, что комбинация "123" введена правильно
                    if (btn_result.secret_code === "123") {
                        timer_5sec.stop() // Останавливаем таймер после ввода
                        openNewWindow() // Открываем новое окно
                    }
                }
            }
            if ( event.key === Qt.Key_Enter )
                resultText.text = logic.doMath( );
            else if ( event.key === Qt.Key_Plus )
                resultText.text = logic.setOperationType( "+" )
            else if ( event.key === Qt.Key_Minus )
                resultText.text = logic.setOperationType( "-" )
            else if ( event.text === "/" )
                resultText.text = logic.setOperationType( "/" )
            else if ( event.text === "*" )
                resultText.text = logic.setOperationType( "*" )
            else if ( event.text === "." )
                resultText.text = logic.onDot( );
            else if ( event.text === "," )
                resultText.text = logic.onDot( );
            else
                resultText.text = logic.onKeyboardInput( event.text );


            event.accepted = true;

        }

    }


    CalculatorLogic {
        id: logic
    }


    Style
    {
        id: guiStyle
    }


    Rectangle {

        id: resultBox

        width: 360
        height: 156
        radius: 30

        color: "#04BFAD"
        Rectangle{

            id: temp

            width: 360
            height: 78

            color: "#04BFAD"
        }
        Rectangle{

            id: inputarea

            anchors.bottom: resultarea.top
            anchors.horizontalCenter: temp.horizontalCenter
            anchors.bottomMargin: 5
            width: 280
            height: 30

            color: "#04BFAD"

            Text{
                id:inputText

                anchors.fill: inputarea
                horizontalAlignment: Text.AlignRight
                color: "white"

                font.pixelSize: 20
                font.family: "Open Sans"
                font.weight: 600
                fontSizeMode: Text.Fit

            }
        }
        //clip: true

        Rectangle{
            id: resultarea

            width: 281
            height: 60
            anchors.top: temp.bottom
            anchors.horizontalCenter: temp.horizontalCenter

            color: "#04BFAD"
        }

        Text {

            id: resultText

            anchors.fill: resultarea
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter

            text: qsTr( "0" )
            color: "white"
            font.pixelSize:50
            font.family: "Open Sans"
            font.weight: 600
            fontSizeMode: Text.Fit
        }
    }




    Item {

        id: buttons
        FontLoader{
            id: open_sans
            source: OpenSans_Condensed-SemiBold.ttf
        }
        anchors.top: resultBox.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Button {
            x: guiStyle.margin
            y: guiStyle.margin
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: _Btn
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"
            }
            Image {
                anchors.centerIn: parent
                source: "bkt.png"
                width: 30
                height: 30
            }
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                logic.resetMemory( );
            }
        }
        // +/-
        Button {
            x: guiStyle.margin + ( 1 * ( width + guiStyle.margin ) )
            y: guiStyle.margin
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: pl_sub_Btn
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"
            }
            Image {
                anchors.centerIn: parent
                source: "plus_minus.png"
                width: 30
                height: 30
            }
            color: "#0889A6"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "@" );
            }
        }
        // %
        Button {
            x: guiStyle.margin + ( 2 * ( width + guiStyle.margin ) )
            y: guiStyle.margin
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: perc_Btn

            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"
            }
            Image {
                anchors.centerIn: parent
                source: "percent.png"
                width: 30
                height: 30
            }
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "%" );
                //resultText.text = logic.doMath( );
            }
        }
        // / (÷)
        Button {
            x: guiStyle.margin + ( 3 * ( width + guiStyle.margin ) )
            y: guiStyle.margin
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_div
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"
            }
            Image {
                anchors.centerIn: parent
                source: "division.png"
                width: 30
                height: 30
            }

            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "/" );
            }
        }

        // 7
        Button {
            x: guiStyle.margin + ( 0 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 1 * ( height + guiStyle.margin ) )
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_7
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_7

                text:"7"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "7" );
            }
        }
        // 8
        Button {
            x: guiStyle.margin + ( 1 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 1 * ( height + guiStyle.margin ) )
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_8
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_8

                text:"8"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "8" );
            }
        }
        // 9
        Button {
            x: guiStyle.margin + ( 2 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 1 * ( height + guiStyle.margin ) )
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_9
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_9

                text:"9"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "9" );
            }
        }
        // *
        Button {
            x: guiStyle.margin + ( 3 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 1 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_mult
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"

            }

            Image {
                anchors.centerIn: parent
                source: "multiplication.png"
                width: 30
                height: 30
            }
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "*" );
            }
        }
        // 4
        Button {
            x: guiStyle.margin + ( 0 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 2 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_4
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_4
                text:"4"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "4" );
            }
        }
        // 5
        Button {
            x: guiStyle.margin + ( 1 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 2 * ( height + guiStyle.margin ) )
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_5
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_5
                text:"5"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "5" );
            }
        }
        // 6
        Button {
            x: guiStyle.margin + ( 2 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 2 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_6
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_6
                text:"6"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "6" );
            }
        }
        // -
        Button {
            x: guiStyle.margin + ( 3 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 2 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_sub
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"

            }

            Image {
                anchors.centerIn: parent
                source: "minus.png"
                width: 30
                height: 30
            }
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "-" );
            }
        }

        // 1
        Button {
            x: guiStyle.margin + (0 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + (3 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_1
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }


            Text{
                anchors.centerIn: btn_1
                text: "1"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "1" );
            }
        }
        // 2
        Button {
            x: guiStyle.margin + ( 1 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 3 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_2
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_2
                text: "2"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "2" );
            }
        }
        // 3
        Button {
            x: guiStyle.margin + ( 2 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 3 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_3
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_3
                text:"3"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {

                inputText.text = logic.onNumberInput( "3" );
            }
        }
        // +
        Button {
            x: guiStyle.margin + ( 3 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 3 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_sum
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"

            }

            Image {
                anchors.centerIn: parent
                source: "plus.png"
                width: 30
                height: 30
            }
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.setOperationType( "+" );
            }
        }
        // C
        Button {
            x: guiStyle.margin + ( 0 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 4 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: clear_Btn
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F25E5E" : "pink"

            }

            Text{
                anchors.centerIn: parent
                text:"C"
                font.pixelSize: 25
                color: "#FFFFFF"
            }


            anchors.leftMargin: guiStyle.margin
            onClicked: {
                logic.resetLogic();
                resultText.text = "0";
                inputText.text = "";
            }
        }
        // --0--
        Button {
            x: guiStyle.margin + ( 1 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 4 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_0
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_0
                text:"0"
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onNumberInput( "0" );
            }
        }
        // =
        Button {
            x: guiStyle.margin + ( 3 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 4 * ( height + guiStyle.margin ) )
            anchors.leftMargin: guiStyle.margin
            property bool secretMenuUnlocked:  false
            property string secret_code: ""
            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_result
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#F7E425" : "#0889A6"
                MouseArea{
                    anchors.fill:parent
                    onPressed: {
                        parent.color = "#F7E425"
                        timer_4sec.start()
                        console.log("Timer_4sec started")
                    }
                    onClicked: {
                        resultText.text = logic.doMath( );
                    }
                    onReleased: {
                        parent.color = "#0889A6"
                        if(timer_4sec.running){
                            timer_4sec.stop()
                            console.log("Кнопка отпущена.")
                        }

                    }
                }
            }
            Image {
                anchors.centerIn: parent
                source: "equal.png"
                width: 30
                height: 30
            }
            Timer{
                id: timer_4sec
                interval: 4000
                repeat: false
                running: false
                onTriggered: {
                    console.log("Кнопка удерживалась более 4 секунд.")
                    timer_5sec.start()

                }
            }
            Timer {
                id: timer_5sec
                interval: 5000
                repeat: false
                running: false
                onTriggered: {
                btn_result.secret_code=""
            }

        }




        }

        // .
        Button {
            x: guiStyle.margin + ( 2 * ( width + guiStyle.margin ) )
            y: guiStyle.margin + ( 4 * ( height + guiStyle.margin ) )

            width: guiStyle.btnWidth
            height: guiStyle.btnHeight
            textHeight: 32
            id: btn_dot
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: parent.pressed ? "#04BFAD" : "#B0D1D8"
            }
            Text{
                anchors.centerIn: btn_dot
                text:"."
                font.pixelSize: 24
                font.family: open_sans
                font.weight: 600
                color:"#024873"
            }
            color: "#B0D1D8"
            anchors.leftMargin: guiStyle.margin
            onClicked: {
                inputText.text = logic.onDot( );
            }
        }

    }
    function openNewWindow() {
        var newWindow = Qt.createQmlObject('import QtQuick 2.15;
            Window {
                id: secret_window
                width: 500;
                height: 500;
                title: "Секретное окно";
                color: "lightblue";
                Rectangle {
                    id:rec
                    anchors.centerIn: parent;
                    width: 100;
                    height: 80;

                    Button {
                        anchors.fill:rec
                        text: "Назад";
                        anchors.centerIn: parent;
                        onClicked: {
                            secret_window.close();
                        }
                }
            }
            }', Qt.application);
        newWindow.show();
    }

}
