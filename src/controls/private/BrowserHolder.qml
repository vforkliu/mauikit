import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import org.kde.kirigami 2.7 as Kirigami
import org.kde.mauikit 1.0 as Maui

QtObject
{
	property Maui.FMList browser
	property bool visible: browser.status.code === Maui.FMList.LOADING || browser.status.code === Maui.FMList.ERROR || ( browser.status.code === Maui.FMList.READY && browser.status.empty === true)
	
	
	property string emoji: browser.status.icon
	
	property string title : browser.status.title
	
	property string body: browser.status.message
	
	property int emojiSize: Maui.Style.iconSizes.huge
	
}
