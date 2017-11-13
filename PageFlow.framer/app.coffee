#--------Array--------#
contentArray=[content_appUpdate,content_system,content_restore]
tabsArray=[btn_app,btn_system,btn_restore]
#--------END Array--------#

content_system.parent=Home
content_system.visible=false
content_restore.parent=Home
content_restore.visible=false
statusBar.bringToFront()
navBar.bringToFront()
hideContent=(tabNum)->
	for s in contentArray
		s.visible=false
	for m in tabsArray
		m.stateSwitch("disable")
		m.opacity=.5
	contentArray[tabNum].visible=true
	tabsArray[tabNum].opacity=1
	tabsArray[tabNum].stateSwitch("enable")

btn_app.states=
	enable:
		backgroundColor:"#FF5B47"
	disable:
		backgroundColor: "transparent"
btn_system.states=
	enable:
		backgroundColor:"#0022FF"
	disable:
		backgroundColor: "transparent"
btn_restore.states=
	enable:
		backgroundColor:"#FFBB00"
	disable:
		backgroundColor: "transparent"


btn_app.onTapEnd ->
	tabNum=0
	hideContent(tabNum)
btn_system.onTapEnd ->
	tabNum=1
	hideContent(tabNum)
btn_restore.onTapEnd ->
	tabNum=2
	hideContent(tabNum)