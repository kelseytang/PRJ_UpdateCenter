

#--------Screen:App Update--------#
sComp_appUpdate=new ScrollComponent
	parent: content_appUpdate
	width: hd_appUpdate.width
	height: 744
	y: 24
	backgroundColor: "#CB3400"
	scrollHorizontal: false
	directionLock: true
	contentInset: 
		top: 250
		bottom:60
sComp_appUpdate.sendToBack()	
pgComp_appUpdate=new PageComponent
	parent: sComp_appUpdate.content
	width: hd_appUpdate.width
	height: 810
	scrollVertical: false
pg_1.parent=pgComp_appUpdate.content
pgComp_appUpdate.addPage(pg_2, "right")

tab_indicator.states=
	newUpdate:
		x:0
		animationOptions:
			time:.3
	history:
		x:467
		animationOptions:
			time:.3
tab_newUpdate.onTapEnd ->
	pgComp_appUpdate.snapToPage(pg_1)
	tab_indicator.animate("newUpdate")
	this.opacity=1
	tab_history.opacity=.5
tab_history.onTapEnd ->
	pgComp_appUpdate.snapToPage(pg_2)
	tab_indicator.animate("history")
	this.opacity=1
	tab_newUpdate.opacity=.5
pgComp_appUpdate.on "change:currentPage", ->
	pageName=pgComp_appUpdate.currentPage.name
	if pageName is "pg_2"
		tab_indicator.animate("history")
		tab_newUpdate.opacity=.5
		tab_history.opacity=1
	else
		tab_indicator.animate("newUpdate")
		tab_newUpdate.opacity=1
		tab_history.opacity=.5
#---------Scroll Control-------#
sComp_appUpdate.onMove ->
	scroll_Dist=Utils.round(sComp_appUpdate.scrollY,0)	
	if 0<scroll_Dist<176
		hd_appUpdate.y=-scroll_Dist
#--------END App Update--------#

#----Screen:Restoration----#
sComp_restore=new ScrollComponent
	width: 934
	height: 696
	y: 24
	x: 90
	parent: Home
	scrollHorizontal: false
	visible: false
	backgroundColor: "#FF7424"
	contentInset: 
		bottom: 100
content_restore.parent=sComp_restore.content
#----END Restoration----#

#----Screen:System----#
content_system.parent=Home
content_system.x=90
content_system.visible=false
#----END System----#

#-------Interaction: Tab Menu-------#
contentArray=[content_appUpdate,content_system,sComp_restore]
tabsArray=[btn_app,btn_system,btn_restore]
#-------Tab State-------#
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
#-------END Tab State-------#
hideContent=(tabNum)->
	for s in contentArray
		s.visible=false
	for m in tabsArray
		m.stateSwitch("disable")
		m.opacity=.5
	contentArray[tabNum].visible=true
	tabsArray[tabNum].opacity=1
	tabsArray[tabNum].stateSwitch("enable")

#-------Tab interaction-------#
btn_app.onTapEnd ->
	tabNum=0
	hideContent(tabNum)
btn_system.onTapEnd ->
	tabNum=1
	hideContent(tabNum)
btn_restore.onTapEnd ->
	tabNum=2
	hideContent(tabNum)
#-------END Tab interaction-------#

prepare.states=
	hide:
		opacity:0
		animationOptions:
			time:.3
	show:
		opacity: 1
		animationOptions:
			time:.3

# Set up FlowComponent
flow = new FlowComponent
flow.showNext(Home)

# Switch on click
btn_gallery.onTapEnd ->
	flow.showOverlayCenter(screen_gallery)
btn_download.onTapEnd ->
	prepare.visible=true
	prepare.bringToFront()
	prepare.animate("show")
	Utils.delay 2, ->
		prepare.animate("hide")
	Utils.delay 2.5, ->
		prepare.visible=false
		flow.showOverlayCenter(screen_battery)
img_battery.onTapEnd ->
	flow.showPrevious()

#-------------System Bar---------------#
statusBar.bringToFront()
navBar.bringToFront()
#-------------END System Bar---------------#

#--------Gallery---------#
pgComp_gallery=new PageComponent
	parent: screen_gallery
	width: screen_gallery.width
	height: screen_gallery.height
	scrollVertical: false
pgComp_gallery.sendToBack()
img_1.parent=pgComp_gallery.content
pgComp_gallery.addPage(img_2, "right")
pgComp_gallery.addPage(img_3, "right")

btn_close.onTapEnd ->
	flow.showPrevious()
#--------END Gallery---------#
	


