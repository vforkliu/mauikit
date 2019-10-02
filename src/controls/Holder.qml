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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.7 as Kirigami
import org.kde.mauikit 1.0 as Maui

import "private"

Item
{
	id: control
	anchors.fill: parent
	visible: false
	
	property string emoji
	property string message
	property string title
	property string body
	
	property bool isMask : true
	property bool isGif : false
	property int emojiSize : Maui.Style.iconSizes.large
	
	property bool enabled: true
	
	signal actionTriggered()
	
	clip: true
	focus: true
	
	Component
	{
		id: imgComponent
		
        Kirigami.Icon
		{
			id: imageHolder
			
			width: Math.min(parent.width, emojiSize)
			height: width
			color: textHolder.color
            opacity: 0.5
			source: emoji
		}
	}
	
	Component
	{
		id: animComponent
		AnimatedImage
		{ 
			id: animation; 
			source: emoji			
		}
	}
	
	MouseArea
	{
		id: _mouseArea
		anchors.fill: parent
		enabled: control.enabled
		onClicked: actionTriggered()
		
		hoverEnabled: true	
	}
	
	Column
	{
		anchors.centerIn: parent	
		
		Loader
		{
			id: loader			
			height: control.emoji ? emojiSize : 0
			width: height		
			anchors.horizontalCenter: parent.horizontalCenter
			sourceComponent: control.emoji ? (isGif ? animComponent : imgComponent) : undefined			
		}			
		
		Label
		{
			id: textHolder
			width: Math.min(control.width * 0.7, implicitWidth)			
			opacity: 0.5
			text: message ? qsTr(message) : "<h3>"+title+"</h3><p>"+body+"</p>"
            font.pointSize: Maui.Style.fontSizes.default
			
            padding: Maui.Style.space.medium
			font.bold: true
			textFormat: Text.RichText
			horizontalAlignment: Qt.AlignHCenter
			elide: Text.ElideRight
			color: _mouseArea.hovered ? Kirigami.Theme.highlightColor : Kirigami.Theme.textColor
			wrapMode: Text.Wrap				
		}			
	}
}


