txt_package.txt="0MB/241MB"

txtAnimation=()-> 
	# Format template value to only have 2 decimals. 
	txt_package.templateFormatter = 
		speed: (value) ->
			Utils.round(value, 0)
	 
	# Animate template value from 0 to 100. 
	txt_package.animate
		template: 
			speed: 241




btnStatus=0
buffering=new Animation bar_fg,
	x:60
	width: 30
bar_fg.originX=0

btn_cancel.states=
	show:
		opacity:1
		animationOptions:
			time:.4
	hide:
		opacity: 0
		animationOptions:
			time:.4

btn_download.states=
	show:
		opacity:1
		brightness: 100
		animationOptions:
			time:1
	hide:
		opacity: 0
		animationOptions:
			time:.3
	clicked:
		brightness: 50
		animationOptions:
			time:.3
	downloaded:
		brightness: 100
		opacity: 1
		backgroundColor: "#FFC524"
		animationOptions:
			time:.4
			delay:.4



Download_App.onTapEnd ->
	btn_download.brightness=100
	switch btnStatus
		when 0
			btnStatus=1
			btn_download.animate("hide")
			buffering.start()
			Utils.delay 2, ->
				downloading()
				
		when 1
			btnStatus=0
			btn_download.animate("show")
			buffering.reset()
			
		when 2
			btnStatus=0
			btn_download.backgroundColor="#4B6AFF"
			txt_download.text="Download"
	

bufferingRever=buffering.reverse()
buffering.on Events.AnimationEnd, bufferingRever.start
bufferingRever.on Events.AnimationEnd, buffering.start

	
downloading=()->
	txt_package.text="{speed}MB/241MB"
	txtAnimation()
	buffering.stop()
	bufferingRever.stop()
	bar_loading.visible=true
	barAni=new Animation bar_loading,
		width:90
	barAni.start()
	barAni.onAnimationEnd ->
		btn_download.animate("downloaded")
		txt_download.text="Open"
		btnStatus=2
		Utils.delay 1,->
			bar_loading.visible=false
			bar_loading.width=2