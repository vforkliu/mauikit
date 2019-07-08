import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.6 as Kirigami

ItemDelegate
{
    id: control
    property bool isCurrentListItem : ListView.isCurrentItem
    property color labelColor : isCurrentListItem ? Kirigami.Theme.highlightColor :  Kirigami.Theme.textColor
    anchors.verticalCenter: parent.verticalCenter
    
    background: Rectangle
    {
		color: isCurrentListItem ? Qt.lighter( Kirigami.Theme.backgroundColor, 1.1) : "transparent"
        
        Kirigami.Separator
        {
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                right: parent.right               
            }
            
            color: colorScheme.borderColor
        }
    }
    
    
    Label
    {
        text: model.label
        width: parent.width
        height: parent.height
        rightPadding: space.medium
        leftPadding: rightPadding        
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment:  Qt.AlignVCenter
        elide: Qt.ElideRight
        font.pointSize: fontSizes.default
        color: labelColor
    }
    
    
}
