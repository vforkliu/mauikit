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
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import org.kde.kirigami 2.2 as Kirigami
import org.kde.mauikit 1.0 as Maui

import QtQuick.Controls.Material 2.1

import "private"

import SyncingModel 1.0 
import SyncingList 1.0

Kirigami.AbstractApplicationWindow
{
    id: root
    visible: true
    width: Screen.width * (isMobile ? 1 : 0.4)
    height: Screen.height * (isMobile ? 1 : 0.4)
	
	contentItem.anchors.leftMargin: 0
	contentItem.anchors.rightMargin: 0
	contentItem.anchors.margins: 0
	
	property bool showAccounts : true

	/***************************************************/
    /******************** ALIASES *********************/
    /*************************************************/
    property alias page : page
    property alias footBar : page.footBar
    property alias headBar : page.headBar
    property alias dialog: dialogLoader.item
    
    property alias leftIcon : menuBtn
    property alias rightIcon : searchBtn
    
    default property alias content : page.content
    property alias mainMenu : mainMenu.content
    property alias about : aboutDialog
    property alias accounts: _accountsDialogLoader.item
    property alias currentAccount: _accountCombobox.currentText
    property alias notifyDialog: _notify
    

    //redefines here as here we can know a pointer to PageRow
    wideScreen: isWide


    /***************************************************/
    /*********************** UI ***********************/
    /*************************************************/

    property bool isWide : root.width >= Kirigami.Units.gridUnit * 30
    
    property int radiusV : unit * 4
    property int iconSize : iconSizes.medium * (isMobile ? 0.95 : 1)

    readonly property int unit : Maui.Style.unit
    readonly property int rowHeight: Maui.Style.rowHeight
    readonly property int rowHeightAlt: Maui.Style.rowHeightAlt

    readonly property int toolBarHeight: Maui.Style.toolBarHeight
    readonly property int toolBarHeightAlt: Maui.Style.toolBarHeightAlt

    readonly property int contentMargins: space.medium
    readonly property var fontSizes: Maui.Style.fontSizes
    readonly property var space : Maui.Style.space
    readonly property var iconSizes : Maui.Style.iconSizes
    
    property string colorSchemeName : Qt.application.name

    /***************************************************/
    /********************* COLORS *********************/
    /*************************************************/
	
	readonly property var colorScheme: ({
		Default : 1,
		Light : 2,
		Dark: 3,
		Custom: 4
	})

    property color borderColor: Qt.tint(textColor, Qt.rgba(backgroundColor.r, backgroundColor.g, 
backgroundColor.b, 0.7))
    property color backgroundColor: Maui.Style.backgroundColor
    property color textColor: Maui.Style.textColor
    property color highlightColor: Maui.Style.highlightColor
    property color highlightedTextColor: Maui.Style.highlightedTextColor
    property color buttonBackgroundColor: Maui.Style.buttonBackgroundColor
    property color viewBackgroundColor: Maui.Style.viewBackgroundColor
    property color altColor: Maui.Style.altColor
    property color altColorText: Maui.Style.altColorText
    property color accentColor : buttonBackgroundColor
    
    property color bgColor: viewBackgroundColor
    property color headBarBGColor: backgroundColor
    property color headBarFGColor: textColor

    readonly property string darkBorderColor: Qt.darker(darkBackgroundColor, 1.5)
    readonly property string darkBackgroundColor: "#303030"
    readonly property string darkTextColor: "#FAFAFA"
    readonly property string darkHighlightColor: "#29B6F6"
    readonly property string darkHighlightedTextColor: darkTextColor
    readonly property string darkViewBackgroundColor: "#212121"
    readonly property string darkDarkColor: "#191919"
    readonly property string darkButtonBackgroundColor :  "#191919"
    readonly property color darkAltColor: "#333"
    readonly property color darkAltColorText: darkTextColor
    readonly property color darkAccentColor : darkButtonBackgroundColor
    readonly property color darkBgColor: darkBackgroundColor


    property color warningColor : Maui.Style.warningColor
    property color dangerColor : Maui.Style.dangerColor
    property color infoColor : Maui.Style.infoColor
    property color suggestedColor : Maui.Style.suggestedColor
    
    /* ANDROID THEMING*/

    Material.theme: Material.Light
    Material.accent: highlightColor
    Material.background:  headBarBGColor 
    Material.primary: headBarBGColor
    Material.foreground: textColor

    /***************************************************/
    /**************** READONLY PROPS ******************/
    /*************************************************/

    readonly property bool isMobile : Kirigami.Settings.isMobile
    readonly property bool isAndroid: Qt.platform.os == "android"

    readonly property real screenWidth : Screen.width
    readonly property real screenHeight : Screen.height

    /***************************************************/
    /********************* PROPS **********************/
    /*************************************************/

    property bool altToolBars : isMobile
    property bool floatingBar : altToolBars

    property int footBarAligment : Qt.AlignCenter
    property bool footBarOverlap : false
    property bool allowRiseContent: floatingBar && footBarOverlap
    property int footBarMargins: space.big
    
    property alias searchButton : searchBtn
    property alias menuButton : menuBtn

    /***************************************************/
    /******************** SIGNALS *********************/
    /*************************************************/
    signal menuButtonClicked();
    signal searchButtonClicked();
	signal goBackTriggered();
	signal goFowardTriggered();
	
    //    overlay.modal: Rectangle
    //    {
    //        color: Color.transparent(altColor, 0.5)
    //    }


    //    overlay.modeless: Rectangle {
    //        color: "transparent"
    //    }
	
   
	onClosing:
	{
		if(!isMobile)
		{	
			var height = root.height
			var width = root.width
			var x = root.x
			var y = root.y		
			Maui.FM.saveSettings("GEOMETRY", Qt.rect(x, y, width, height), "WINDOW")			
		}		
	}
	
	property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation || Screen.primaryOrientation === Qt.InvertedPortraitOrientation	
	onIsPortraitChanged: 
	{
		if(isPortrait)
		{
            console.log("PORTARIT MODE CHANGED")
            width: Screen.width
            height: Screen.height
		}
	}
	
    onHeadBarBGColorChanged: 
    {
        if(!isMobile && colorSchemeName.length > 0 && !altToolBars)
            Maui.KDE.setColorScheme(colorSchemeName, headBarBGColor, headBarFGColor)
        else if(isAndroid && !altToolBars)
            Maui.Android.statusbarColor(headBarBGColor, false)
		else if(isAndroid && altToolBars)
			Maui.Android.statusbarColor(viewBackgroundColor, true)
				
    }
    
    onHeadBarFGColorChanged: 
    {
        if(!isAndroid && !isMobile && colorSchemeName.length > 0 && !altToolBars)
            Maui.KDE.setColorScheme(colorSchemeName, headBarBGColor, headBarFGColor)
        else if(isAndroid && !altToolBars)
            Maui.Android.statusbarColor(headBarBGColor, false)
			else if(isAndroid && altToolBars)
				Maui.Android.statusbarColor(viewBackgroundColor, true)
    }
    
    background: Rectangle
    {
        color: bgColor
    }
    
  
// 		globalDrawer.height: root.height - headBar.height
// 		globalDrawer.y: headBar.height
	

    Maui.Page
    {
        id: page
        anchors.fill: parent
        
        leftMargin: root.globalDrawer && (root.globalDrawer.modal === false) ? root.globalDrawer.contentItem.width * root.globalDrawer.position : 0
        
        margins: 0
        headBar.plegable: false
        headBar.height: toolBarHeight + space.small
        headBar.implicitHeight: toolBarHeight + space.small

        headBarExit: false

        altToolBars: root.altToolBars
        floatingBar : root.floatingBar
        footBarAligment : root.footBarAligment
        footBarOverlap : root.footBarOverlap
        footBarMargins: root.footBarMargins
        allowRiseContent: root.allowRiseContent

        background: Rectangle
        {
            color: bgColor
        }

        headBar.colorScheme.backgroundColor: headBarBGColor
        headBar.colorScheme.textColor: headBarFGColor

        headBar.leftContent: Maui.ToolButton
        {
            id: menuBtn
            iconName: "application-menu"
			iconColor: headBarFGColor
            checked: mainMenu.visible  
            onClicked:
            {
                menuButtonClicked()
				mainMenu.visible ? mainMenu.close() : mainMenu.popup(parent, parent.x ,  altToolBars ? 0 : parent.height+ space.medium)
            }
            
            Maui.Menu
            {
				id: mainMenu
				modal: true
				
				width: unit * 200
				
				Item
				{
					height: _accountCombobox.visible ? unit * 90 : 0
					
					anchors
					{
						left: parent.left
						right: parent.right
						top: parent.top
						margins: space.medium
					}
					
					Maui.ComboBox
					{
						id: _accountCombobox
						anchors.centerIn: parent
// 						parent: mainMenu
						popup.z: 999
						width: parent.width
						visible: (count > 1) && showAccounts
						textRole: "user"
						flat: true
						model: showAccounts ? accounts.model : undefined
						iconButton.iconName: "user-identity"
						iconButton.isMask: false
					}
				}
				
				MenuSeparator
				{
                    visible: _accountCombobox.visible
                }
				
				Maui.MenuItem
				{
					text: qsTr("Accounts")
					visible: root.showAccounts
					icon.name: "list-add-user"
					onTriggered: 
					{
						if(root.accounts)
							accounts.open()
					}
				}				
				
				Maui.MenuItem
				{
					text: qsTr("About")
					icon.name: "documentinfo"
					onTriggered: aboutDialog.open()
				}
				
				MenuSeparator {}
				
			}			
        }

        headBar.rightContent: Maui.ToolButton
        {
            id: searchBtn
            iconName: "edit-find"
            iconColor: headBarFGColor
            onClicked: searchButtonClicked()
        }
        
        Keys.onBackPressed:
        {
			goBackTriggered();
			console.log("GO BACK CLICKED")
			event.accepted = true
		}
		
		Shortcut
		{
			sequence: "Forward"
			onActivated: goFowardTriggered();
		}
		
		Shortcut
		{
			sequence: StandardKey.Forward
			onActivated: goFowardTriggered();
		}
		
		Shortcut
		{
			sequence: StandardKey.Back
			onActivated: goBackTriggered();
		}
		
    }      
    
    Maui.AboutDialog
    {
        id: aboutDialog  
    }    

    Loader
    {
		id: _accountsDialogLoader
		sourceComponent: root.showAccounts ? _accountsDialogComponent : undefined
	}
	
	Component
	{
		id: _accountsDialogComponent
		AccountsHelper {}	
	}	
	
	Maui.Dialog
	{
		id: _notify
		property var cb : ({})
		verticalAlignment: Qt.AlignTop
		defaultButtons: false
		colorScheme.backgroundColor: altColor
		colorScheme.textColor: altColorText
		
		maxHeight: Math.max(unit * 120, (_notifyLayout.implicitHeight))
		maxWidth: isMobile ? parent.width * 0.9 : unit * 500
		
		Timer 
		{
			id: _notifyTimer			
			onTriggered: _notify.close()
		}
		
		onClosed: _notifyTimer.stop()
		
		MouseArea
		{
			anchors.fill: parent
			onClicked: 
			{
				if(_notify.cb)
					_notify.cb()
					
				_notify.close()
			}
		}
	
		GridLayout
		{
			anchors.fill: parent
			
			columns: 2
			rows: 1
			
			Item
			{
				Layout.fillHeight: true
				Layout.preferredWidth: iconSizes.huge + space.big
				Layout.row: 1
				Layout.column: 1
				
				Maui.ToolButton
				{
					id: _notifyIcon
					size: iconSizes.large
					
					anchors.centerIn: parent
					isMask: false
				}				
			}
			
			Item
			{
				Layout.fillHeight: true
				Layout.fillWidth: true	
				Layout.row: 1
				Layout.column: 2
				
				ColumnLayout
				{
					anchors.fill: parent
					id: _notifyLayout
					
					Label
					{
						id: _notifyTitle
						Layout.fillHeight: true
						Layout.fillWidth: true
						font.weight: Font.Bold
						font.bold: true
						font.pointSize: fontSizes.big
						color: _notify.colorScheme.textColor
						elide: Qt.ElideRight
						wrapMode: Text.Wrap
					}
					
					Label
					{
						id: _notifyBody
						Layout.fillHeight: true
						Layout.fillWidth: true
						font.pointSize: fontSizes.default	
						color: _notify.colorScheme.textColor
						elide: Qt.ElideRight
						wrapMode: Text.Wrap
					}
				}
			}
		}
		
		function show(callback)
		{
			_notify.cb = callback
			_notifyTimer.start()

			_notify.open()
		}
	}
	
	Loader
	{
		id: dialogLoader
	}    

     Component.onCompleted:
     {
         if(isAndroid && altToolBars)
			 Maui.Android.statusbarColor(backgroundColor, true)			 
			 
			 if(!isMobile)
			 {	
				 var rect = Maui.FM.loadSettings("GEOMETRY", "WINDOW", Qt.rect(root.x, root.y, root.width, root.height))
				 root.x = rect.x
				 root.y = rect.y
				 root.width = rect.width
				 root.height = rect.height
				 
			 }
		
     }
     
     Connections
     {
		 target: Maui.FM
		 
		 onNewItem: notify("dialog-information", qsTr("File uploaded"), "Your file has been uploaded to your account /n"+path)
		 onWarningMessage: notify("dialog-information", "Oops!", message)
	}

    function switchColorScheme(variant)
    {
        switch(variant)
        {
        case colorScheme.Default:

            backgroundColor = Maui.Style.backgroundColor
            textColor = Maui.Style.textColor
            highlightColor = Maui.Style.highlightColor
            highlightedTextColor = Maui.Style.highlightedTextColor
            buttonBackgroundColor = Maui.Style.buttonBackgroundColor
            viewBackgroundColor = Maui.Style.viewBackgroundColor
            altColor = Maui.Style.altColor
            borderColor = Maui.Style.borderColor
            if(isAndroid) Maui.Android.statusbarColor(backgroundColor, true)
            break

        case colorScheme.Dark:
            borderColor = darkBorderColor
            backgroundColor = darkBackgroundColor
            textColor = darkTextColor
            highlightColor = darkHighlightColor
            highlightedTextColor = darkHighlightedTextColor
            buttonBackgroundColor = darkButtonBackgroundColor
            viewBackgroundColor = darkViewBackgroundColor
            altColor = darkDarkColor
            altColorText = darkAltColorText
            bgColor =darkBgColor
            
            if(isAndroid) Maui.Android.statusbarColor(backgroundColor, false)
            break         
        }
    }
    
    function notify(icon, title, body, callback, timeout)
	{
		_notifyIcon.iconName = icon 
		_notifyTitle.text = title
		_notifyBody.text = body
		_notifyTimer.interval = timeout ? timeout : 2500
		
		_notify.show(callback) 
	}
    
    /** FUNCTIONS **/
    //    function riseContent()
    //    {
    //        if(allowRiseContent)
    //            flickable.flick(0, flickable.contentHeight* -2)
    //    }

    //    function dropContent()
    //    {
    //        if(allowRiseContent)
    //            flickable.flick(0, flickable.contentHeight* 2)

    //    }
}
