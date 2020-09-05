/*
 *   Copyright 2018 Camilo Higuita <milo.h@aol.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.14
import QtQml 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.3
import org.kde.mauikit 1.2 as Maui
import org.kde.kirigami 2.8 as Kirigami

import QtGraphicalEffects 1.0

Maui.Popup
{
    id: control
    
    default property alias scrollable : _pageContent.data
    property alias stack : _stack.data

    property string message : ""
    property alias title: _page.title
    property alias template : _template

    property list<Action> actions

    property bool defaultButtons: true
    property bool persistent : true
    
    property alias acceptButton : _acceptButton
    property alias rejectButton : _rejectButton
    
    property alias textEntry : _textEntry
    property alias entryField: _textEntry.visible
    
    property alias page : _page
    property alias footBar : _page.footBar
    property alias headBar: _page.headBar
    property alias closeButton: _closeButton

    signal accepted()
    signal rejected()
    
    closePolicy: control.persistent ? Popup.NoAutoClose | Popup.CloseOnEscape : Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    maxWidth: Maui.Style.unit * 300
    maxHeight: implicitHeight
    implicitHeight: _layout.implicitHeight
    widthHint: 0.9
    heightHint: 0.9

    ColumnLayout
    {
        id: _layout
        anchors.fill: parent
        spacing: 0
        
        Maui.Page
        {
            id: _page
            Layout.fillWidth: true
            Layout.fillHeight: true
            headerPositioning: ListView.InlineHeader
            padding: 0
            flickable: _scrollable.flickable
            implicitHeight: _pageContent.implicitHeight + _stack.implicitHeight + footer.height + control.spacing + header.height
            headBar.visible: control.persistent
            //            headerBackground.visible: headBar.visibleCount > 1

            //            Binding on floatingHeader {
            //            value: headBar.visibleCount === 1
            //            restoreMode: Binding.RestoreBinding
            //            }

            headBar.farLeftContent: MouseArea
            {
                id: _closeButton
                visible: control.persistent
                hoverEnabled: !Kirigami.Settings.isMobile
                Layout.fillHeight: true
                implicitHeight: Maui.Style.iconSizes.medium
                implicitWidth: Maui.Style.iconSizes.medium
                
                Maui.X
                {
                    height: Maui.Style.iconSizes.tiny
                    width: height
                    anchors.centerIn: parent
                    color: _closeButton.containsMouse || _closeButton.containsPress ? Kirigami.Theme.negativeTextColor : Qt.tint(Kirigami.Theme.textColor, Qt.rgba(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b, 0.7))
                }
                
                onClicked: close()
            }

            ColumnLayout
            {
                id: _stack
                anchors.fill: parent
                spacing: control.spacing
            }

            Kirigami.ScrollablePage
            {
                id: _scrollable
                width: parent.width
                height: Math.min(parent.height, contentHeight)
                anchors.centerIn: parent
                contentHeight: _pageContent.implicitHeight

                Kirigami.Theme.backgroundColor: "transparent"

                padding: 0
                leftPadding: padding
                rightPadding: padding
                topPadding: padding
                bottomPadding: padding

                ColumnLayout
                {
                    id: _pageContent
                    width: parent.width
                    spacing: control.spacing

                    Maui.ListItemTemplate
                    {
                        id: _template
                        visible: control.message.length
                        Layout.fillWidth: true
                        implicitHeight: label1.implicitHeight + label2.implicitHeight + Maui.Style.space.big

                        //                        label1.text: title
                        //                        label1.font.weight: Font.Thin
                        //                        label1.font.bold: true
                        //                        label1.font.pointSize:Maui.Style.fontSizes.huge
                        //                        label1.elide: Qt.ElideRight
                        //                        label1.wrapMode: Text.Wrap

                        label2.text: message
                        label2.textFormat : TextEdit.AutoText
                        label2.font.pointSize:Maui.Style.fontSizes.default
                        label2.wrapMode: TextEdit.WordWrap

                        iconSizeHint: Maui.Style.iconSizes.large
                        spacing: Maui.Style.space.big
                    }

                    Maui.TextField
                    {
                        id: _textEntry
                        visible: false
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignCenter
                        focus: visible
                        onAccepted: control.accepted()
                    }
                }
            }
        }
        
        Kirigami.Separator
        {
            Layout.fillWidth: true
            visible: _defaultButtonsLayout.visible
            color: Qt.lighter(Kirigami.Theme.backgroundColor, 2)
            opacity: 0.8
        }

        Kirigami.Separator
        {
            Layout.fillWidth: true
            visible: _defaultButtonsLayout.visible
            color: Qt.darker(Kirigami.Theme.backgroundColor, 2.7)
            opacity: 0.8
        }
        
        RowLayout
        {
            id: _defaultButtonsLayout
            spacing: 0
            Layout.fillWidth: true
            Layout.preferredHeight:  Maui.Style.toolBarHeightAlt - Maui.Style.space.medium
            Layout.maximumHeight: Maui.Style.toolBarHeightAlt - Maui.Style.space.medium
            visible: control.defaultButtons || control.actions.length
            
            Button
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                implicitWidth: width
                id: _rejectButton
                visible: control.defaultButtons
                text: qsTr("Cancel")
                background: Rectangle
                {
                    color: _rejectButton.hovered || _rejectButton.down || _rejectButton.pressed ? "#da4453" : Kirigami.Theme.backgroundColor
                }
                
                contentItem: Label
                {
                    text: _rejectButton.text
                    color:  _rejectButton.hovered || _rejectButton.down || _rejectButton.pressed ?  "#fafafa" : Kirigami.Theme.textColor
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                
                onClicked: rejected()
            }
            
            Kirigami.Separator
            {
                Layout.fillHeight: true
                visible: control.defaultButtons && _defaultButtonsLayout.visibleChildren.length > 1
            }
            
            Button
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                implicitWidth: width
                text: qsTr("Accept")
                id: _acceptButton
                visible: control.defaultButtons
                background: Rectangle
                {
                    color: _acceptButton.hovered || _acceptButton.down || _acceptButton.pressed ? "#26c6da" : Kirigami.Theme.backgroundColor
                }
                
                contentItem: Label
                {
                    text: _acceptButton.text
                    color:  _acceptButton.hovered || _acceptButton.down || _acceptButton.pressed ?  "#fafafa" : Kirigami.Theme.textColor
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                }
                
                onClicked: accepted()
            }

            Repeater
            {
                model: control.actions

                Button
                {
                    id: _actionButton
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    implicitWidth: width

                    action: modelData

                    background: Rectangle
                    {
                        color: _actionButton.hovered || _actionButton.down || _actionButton.pressed ? "#26c6da" : Kirigami.Theme.backgroundColor
                    }

                    contentItem: Label
                    {
                        text: _actionButton.text
                        color:  _actionButton.hovered || _actionButton.down || _actionButton.pressed ?  "#fafafa" : Kirigami.Theme.textColor
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                    }

                    //                    onClicked: action.triggered()

                    Kirigami.Separator
                    {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        visible: control.actions.length > index
                    }
                }
            }
        }
    }
}
