QT += quick
QT += quickcontrols2
CONFIG += c++11
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += \
        CalculatorLogic.cpp \
        main.cpp

RESOURCES += qml.qrc

QML_DESIGNER_IMPORT_PATH =


qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    CalculatorLogic.hpp

DISTFILES +=
