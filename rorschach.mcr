-- Rorschach v2.5 - 22/12/13
-- Developed by Midge Sinnaeve
-- www.themantissa.net
-- Licensed under GPL v2

macroScript Rorschach
	category:"DAZE"
	toolTip:"Rorschach: Create weird shit. Instantly."
	buttonText:"Rorschach"
(
	
	rollout rorschach "Rorschach" width:295 height:670
	(
		label lbl_version "Rorschach v2.5" pos:[210,5] width:80 height:16

		dropdownList ddl_modeltype "Base geometry (if none is selected)" pos:[10,30] width:275 height:40 items:#("Random Object", "Geosphere", "Torus Knot", "Hose", "Hedra", "Spindle", "RingWave", "Box", "Torus", "Tube")
		
		GroupBox grp_params "Rorschach Parameters:" pos:[10,80] width:275 height:445

		label lbl_mods "Modifiers" pos:[20,100] width:100 height:17
		label lbl_amount "Amount" pos:[135,100] width:90 height:17
		label lbl_force "Force" pos:[240,100] width:35 height:17

		button btn_rndmods "Randomize" pos:[20,125] width:100 height:35
		button btn_rndamount "Randomize" pos:[135,125] width:90 height:35
		button btn_rndforce "R" pos:[240,125] width:32 height:35

		button btn_modsall "All" pos:[20,170] width:50 height:20 enabled:true toolTip:"Enable All Modifiers"
		button btn_modsnone "None" pos:[70,170] width:50 height:20 enabled:true toolTip:"Enable No Modifiers"
		button btn_sldmin "Min" pos:[135,170] width:30 height:20 enabled:true toolTip:"Set Amount to Minimum"
		button btn_sldreset "Rst" pos:[165,170] width:30 height:20 enabled:true toolTip:"Reset Amount"
		button btn_sldmax "Max" pos:[195,170] width:30 height:20 enabled:true toolTip:"Set Amount to Maximun"
		button btn_forceall "A" pos:[240,170] width:16 height:20 enabled:true toolTip:"Force All Modifiers"
		button btn_forcenone "N" pos:[256,170] width:16 height:20 enabled:true toolTip:"Force No Modifiers"
		
		checkbutton ckb_displace "Displace" pos:[20,200] width:100 height:20 enabled:true toolTip:"Enable Displacement" checked:true
		slider sld_displace "" pos:[135,200] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceDisplace "" pos:[250,205] width:16 height:16

		checkbutton ckb_noise "Noise" pos:[20,230] width:100 height:20 enabled:true toolTip:"Enable Noise" checked:true
		slider sld_noise "" pos:[135,230] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceNoise "" pos:[250,235] width:16 height:16
	
		checkbutton ckb_spherify "Spherify" pos:[20,260] width:100 height:20 enabled:true toolTip:"Enable Spherify" checked:true
		slider sld_spherify "" pos:[135,260] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceSpherify "" pos:[250,265] width:16 height:16

		checkbutton ckb_ripple "Ripple" pos:[20,290] width:100 height:20 enabled:true toolTip:"Enable Ripple" checked:true
		slider sld_ripple "" pos:[135,290] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceRipple "" pos:[250,295] width:16 height:16

		checkbutton ckb_bend "Bend" pos:[20,320] width:100 height:20 enabled:true toolTip:"Enable Bend" checked:true
		slider sld_bend "" pos:[135,320] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceBend "" pos:[250,325] width:16 height:16

		checkbutton ckb_twist "Twist" pos:[20,350] width:100 height:20 enabled:true toolTip:"Enable Twist" checked:true
		slider sld_twist "" pos:[135,350] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceTwist "" pos:[250,355] width:16 height:16

		checkbutton ckb_rorschach "Rorschach" pos:[20,380] width:100 height:20 enabled:true toolTip:"Enable Rorschach Mode (Symmetry Modifier)" checked:true
		slider sld_rorschach "" pos:[135,380] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceRorschach "" pos:[250,385] width:16 height:16

		checkbutton ckb_relax "Relax" pos:[20,410] width:100 height:20 enabled:true toolTip:"Enable Relax" checked:true
		slider sld_relax "" pos:[135,410] width:100 height:25 range:[0.5,1.5,1] type:#float orient:#horizontal ticks:10
		checkbox chk_forceRelax "" pos:[250,415] width:16 height:16

		checkbutton ckb_turbo "Turbosmooth" pos:[20,440] width:100 height:20 enabled:true toolTip:"Enable Turbosmooth" checked:true
		slider sld_turbo "" pos:[135,440] width:100 height:25 range:[1,3,1] type:#integer orient:#horizontal ticks:3
		checkbox chk_forceTurbo "" pos:[250,445] width:16 height:16
		
		button btn_rndall "Randomize All" pos:[20,475] width:255 height:40

		label lbl_warning "Force will force the enabled modifiers. Otherwise they have a random chance of being added to the stack." pos:[10,530] width:275 height:35 enabled:true

		button btn_submit "GO!" pos:[10,565] width:275 height:55
		
		progressBar pb_progress "" pos:[10,630] width:275 height:8 value:0 color:[0,255,0]
		label lbl_progress "" pos:[10,645] width:275 height:15
		
		
		
		
		-- GLOBAL FUNCTIONS & VARIABLES --
		
			-- DISTORT FUNCTIONS --
	
				fn addDisplace obj =
				(
					local rMap = random 0 1
					if rMap == 1 then rMap = true else rMap = false
					local iTex = cellular size:(random 50 150) fractal:true iterations:(random 1.0 5.0) name:"CellDisp"
					iTex.output.invert = true
					local iMod = Displace strength:((random -100 100) * sld_displace.value) map:iTex useMap:rMap
					addModifier obj iMod
				)
				
				fn addNoise obj =
				(
					local pn = random 0 1
					local iMod = Noisemodifier scale:(random 5.0 50.0) strength:[(random (rad2/3) (rad1/3) * sld_noise.value), (random (rad2/3) (rad1/3)  * sld_noise.value), (random (rad2/3) (rad1/3)  * sld_noise.value)]
					
					if pn == 1 then
					(
						iMod.gizmo.pos += [random 0 rad1,random 0 rad1,random 0 rad1]
						iMod.gizmo.rotation += quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
					else
					(
						iMod.gizmo.pos -= [random 0 rad1,random 0 rad1,random 0 rad1]
						iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
				
					addModifier obj iMod

				)
					
				fn addSpherify obj =
				(
					local iMod = Spherify percent:(floor((random 25 50) * sld_spherify.value))
					addModifier obj iMod
				)
				
				fn addRipple obj =
				(
					local iMod = Ripple amplitude1:((random -15.0 15.0) * sld_ripple.value) amplitude2:((random -15.0 15.0) * sld_ripple.value) wavelength:(random 25 75)

					if pn == 1 then
					(
						iMod.gizmo.pos = iMod.gizmo.pos + [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
						iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
					else
					(
						iMod.gizmo.pos = iMod.gizmo.pos - [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
						iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
						
					addModifier obj iMod
				)
				
				fn addBend obj =
				(		
					local iMod = Bend BendAngle:((random 30 160) * sld_bend.value) BendAxis:(random 0 2) BendDir:(random 0 90)
					
					pn = random 0 1
					if pn == 1 then
					(
						iMod.gizmo.pos += [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
						iMod.gizmo.rotation += quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
					else
					(
						iMod.gizmo.pos -= [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
						iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
					)
					
					addModifier obj iMod
				)
				
				fn addTwist obj =
				(
					local iMod = Twist angle:((random 30 180) * sld_twist.value) axis:(random 0 2)
					if pn == 1 then
						(
							iMod.gizmo.pos += [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
							iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
						)
						else
						(
							iMod.gizmo.pos -= [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
							iMod.gizmo.rotation -= quat (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0) (random 0.0 1.0)
						)
						
					addModifier obj iMod
				)
				
				fn addRorschach obj =
				(
					local iMod = symmetry axis:(random 0 2)
					iMod.mirror.pos -= [(random 0 rad1),(random 0 rad1),(random 0 rad1)]
					iMod.mirror.rotation -= quat ((random 0.0 0.5) * sld_rorschach.value) ((random 0.0 0.5) * sld_rorschach.value) ((random 0.0 0.5) * sld_rorschach.value) ((random 0.0 0.5) * sld_rorschach.value)
					
					addModifier obj iMod
				)
				
				fn addRelax obj =					
				(
					local iMod = Relax Relax_Value:((random 0.01 1) * sld_relax.value) iterations:( (random 10 50) *sld_relax.value)
					
					addModifier obj iMod
				)
				
				fn addTurbo obj =					
				(
					local iMod = Turbosmooth iterations:sld_turbo.value
					
					addModifier obj iMod
				)
				
				fn centerObj =
				(
					$.pivot = $.center
					$.pos = [0,0,0]
					$.rotation = quat 0 0 0 0
				)
				
				-- CREATOR FUNCTIONS
				
				fn addMods =
				(
					if ckb_displace.state == on then
					(
						pb_progress.value = 20
						lbl_progress.text = "Adding Displace Modifier"
						if chk_forceDisplace.checked == true then
						(
							addDisplace selection[1]
						)
						else
						(
							local rnddisp = random 0 1
							if rnddisp == 1 then
							(
								addDisplace selection[1]
							)
						)
					)
					
					if ckb_noise.state == on then
					(
						pb_progress.value = 30
						lbl_progress.text = "Adding Noise Modifier"
						if chk_forceNoise.checked == true then
						(
							addNoise selection[1]
						)
						else
						(
							local rndnoise = random 0 1
							if rndnoise == 1 then
							(
								addNoise selection[1]
							)
						)
					)
				
					if ckb_spherify.state == on then
					(
						pb_progress.value = 40
						lbl_progress.text = "Adding Spherify Modifier"
						if chk_forceSpherify.checked == true then
						(
							addSpherify selection[1]
						)
						else
						(
							local rndsphere = random 0 1
							if rndsphere == 1 then
							(
								addSpherify selection[1]
							)
						)
					)
					
					if ckb_ripple.state == on then
					(
						pb_progress.value = 50
						lbl_progress.text = "Adding Ripple Modifier"
						if chk_forceRipple.checked == true then
						(
							addRipple selection[1]
						)
						else
						(
							local rndripple = random 0 1
							if rndripple == 1 then
							(
								addRipple selection[1]
							)
						)
					)
					
					if ckb_bend.state == on then
					(
						pb_progress.value = 60
						lbl_progress.text = "Adding Bend Modifier"
						if chk_forceBend.checked == true then
						(
							addBend selection[1]
						)
						else
						(
							local rndbend = random 0 1
							if rndbend == 1 then
							(
								addBend selection[1]
							)
						)
					)
					
					if ckb_twist.state == on then
					(
						pb_progress.value = 70
						lbl_progress.text = "Adding Twist Modifier"
						if chk_forceTwist.checked == true then
						(
							addTwist selection[1]
						)
						else
						(
							local rndtwist = random 0 1
							if rndtwist == 1 then
							(
								addTwist selection[1]
							)
						)
					)
					
					if ckb_rorschach.state == on then
					(
						pb_progress.value = 80
						lbl_progress.text = "Adding Symmetry Modifier (SLOW)"
						if chk_forceRorschach.checked == true then
						(
							addRorschach selection[1]
						)
						else
						(
							local rndrorschach = random 0 1
							if rndrorschach == 1 then
							(
								addRorschach selection[1]
							)
						)
					)
					
					if ckb_relax.state == on then
					(
						pb_progress.value = 90
						lbl_progress.text = "Adding Relax Modifier"
						if chk_forceRelax.checked == true then
						(
							addRelax selection[1]
						)
						else
						(
							local rndrelax = random 0 1
							if rndrelax == 1 then
							(
								addRelax selection[1]
							)
						)
					)
					
					if ckb_turbo.state == on then
					(
						pb_progress.value = 99
						lbl_progress.text = "Adding Turbosmooth Modifier"
						if chk_forceTurbo.checked == true then
						(
							addTurbo selection[1]
						)
						else
						(
							local rndturbo = random 0 1
							if rndturbo == 1 then
							(
								addTurbo selection[1]
							)
						)
					)
				)
		
				-- RANDOM BOOLEAN SWITCH
				
				fn onoff = 
				(
					check = random 0 1
					if check == 0 then
					(
						return false
					)
					else
					(
						return true
					)
				)
			
		
			-- INTERFACE FUNCTIONS --
			
			-- 1. Randomizers
			
			fn rndmods =
			(
				ckb_displace.checked = onoff()
				ckb_noise.checked = onoff()
				ckb_spherify.checked = onoff()
				ckb_ripple.checked = onoff()
				ckb_bend.checked = onoff()
				ckb_twist.checked = onoff()
				ckb_rorschach.checked = onoff()
				ckb_relax.checked = onoff()
				ckb_turbo.checked = onoff()
			)
			
			fn rndamount =
			(
				sld_displace.value = random 0.5 1.5
				sld_noise.value = random 0.5 1.5
				sld_spherify.value = random 0.5 1.5
				sld_ripple.value = random 0.5 1.5
				sld_bend.value = random 0.5 1.5
				sld_twist.value = random 0.5 1.5
				sld_rorschach.value = random 0.5 1.5
				sld_relax.value = random 0.5 1.5
				sld_turbo.value = random 1 3
			)
			
			fn rndforce =
			(
				chk_forceDisplace.checked = onoff()
				chk_forceNoise.checked = onoff()
				chk_forceSpherify.checked = onoff()
				chk_forceRipple.checked = onoff()
				chk_forceBend.checked = onoff()
				chk_forceTwist.checked = onoff()
				chk_forceRorschach.checked = onoff()
				chk_forceRelax.checked = onoff()
				chk_forceTurbo.checked = onoff()
			)
			
			
			
			-- 2. Main Creation Functions --
			
			fn creator =
			(
				global p = random 1 5
				global q = random 1 5
				global rad1 = random 25 75
				global rad2 = rad1 / random 2.0 4.0
				global ecc = random 0.9 1.1
				global lmp = random 0 25
				global lmph = random -0.5 0.5
				
				global pn = random 0 1
				if pn == 1 then
					(
						sign = "+"
					)
					else
					(
						sign = "-"
					)
				
				global selector = ddl_modeltype.selection
				
					
				if $ != undefined then
				(
					addMods()
				)
				else
				(
					pb_progress.value = 10
					lbl_progress.text = "Creating base shape"
					if selector == 1 then selector = random 2 10
					if selector == 2 then
					(
						GeoSphere pos:[0,0,0] radius:(rad1*2) segments:(random 12 24) isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 3 then
					(
						Torus_Knot smooth:2 Base_Curve:0 Segments:(random 64 128) sides:(random 32 64) radius:rad1 radius2:rad2 p:p q:q Eccentricity:ecc Twist:0 Lumps:lmp Lump_Height:lmph Gen_UV:1 U_Tile:1 V_Tile:1 U_Offset:0 V_Offset:0 Warp_Height:0 Warp_Count:0 pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 4 then
					(
						rndsegs = random 32 64
						rndsides = random 32 64
						
						Hose Hose_Height:(rad1*2) Round_Hose_Diameter:(rad2*2) Segments_Along_Hose:rndsegs Round_Hose_Sides:rndsides mapcoords:on pos:[0,0,0] isSelected:on
						
						addMods()
						centerObj()
					)
					else if selector == 5 then
					(
						fam = random 0 4
						p = random 0.0 1.0
						q = random 0.0 1.0
						sp = random 50.0 200.0
						sq = random 50.0 200.0
						sr = random 50.0 200.0
						
						Hedra family:25 family:fam p:p q:q scalep:sp scaleq:sq scaler:sr radius:(rad1*2) mapcoords:on pos:[0,0,0] isSelected:on
						
						modPanel.addModToSelection (tessellate ()) ui:on
							$.modifiers[#Tessellate].faceType = 1
							$.modifiers[#Tessellate].tension = 0
							$.modifiers[#Tessellate].iterations = random 0 1
						
						modPanel.addModToSelection (TurboSmooth ()) ui:on
						
						addMods()
						centerObj()
					)
					else if selector == 6 then
					(
						Spindle sides:32 Cap_segments:16 heightsegs:8 radius:(rad1*2) width:(rad1*2) height:(rad1*2) Cap_Height:(rad2*2) mapcoords:1 pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 7 then
					(
						rndcycle = random 0 8
						rndflux = random 0.0 70.0
						rndcycle2 = random 0 8
						rndflux2 = random 0.0 70.0
						rndrs = random 4 8
						rndhs = random 4 8
						RingWave radius:(rad1*2) Radius_Segs:rndrs ring_width:(rad1) height:(rad2*2) Height_Segs:rndhs ring_segments:64 Outer_Edge_Breakup:on Major_Cycles_Outer:rndcycle Major_Cycle_Flux_Outer:rndflux Minor_Cycles_Inner:rndcycle2 Major_Cycle_Flux_Inner: rndflux2 mapcoords:1 pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 8 then
					(
						local rndlength = random 32 64
						local rndwidth = random 32 64
						local rndheight = random 32 64
						Box lengthsegs:rndlength widthsegs:rndwidth heightsegs:rndheight length:(rad1) width:(rad2*2) height:(rad1*2) mapcoords:on pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 9 then
					(
						local rndsegs = random 32 64
						Torus smooth:2 segs:rndsegs sides:(rndsegs/2) radius1:(rad1) radius2:(rad2) tubeTwist:0 mapcoords:on pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					else if selector == 10 then
					(
						local rndsides = random 32 64
						Tube smooth:on sides:rndsides capsegs:(rndsides/4) heightsegs:(random 6 16) radius1:(rad1) radius2:(rad2) height:(rad2/2) mapcoords:on pos:[0,0,0] isSelected:on
						addMods()
						centerObj()
					)
					
				)
				pb_progress.value = 100
				lbl_progress.text = "Finished!"
			)
			
			
		-- INTERFACE STATES --
			
			
		on btn_rndmods pressed do
		(
			rndmods()
		)
		on btn_rndamount pressed do
		(
			rndamount()
		)
		on btn_rndforce pressed do
		(
			rndforce()
		)
		on btn_modsall pressed do
		(
			ckb_displace.checked = on
			ckb_noise.checked = on
			ckb_spherify.checked = on
			ckb_ripple.checked = on
			ckb_bend.checked = on
			ckb_twist.checked = on
			ckb_rorschach.checked = on
			ckb_relax.checked = on
			ckb_turbo.checked = on
		)
		on btn_modsnone pressed do
		(
			ckb_displace.checked = off
			ckb_noise.checked = off
			ckb_spherify.checked = off
			ckb_ripple.checked = off
			ckb_bend.checked = off
			ckb_twist.checked = off
			ckb_rorschach.checked = off
			ckb_relax.checked = off
			ckb_turbo.checked = off
		)
		on btn_sldmin pressed do
		(
			sld_displace.value = 0.5
			sld_noise.value = 0.5
			sld_spherify.value = 0.5
			sld_ripple.value = 0.5
			sld_bend.value = 0.5
			sld_twist.value = 0.5
			sld_rorschach.value = 0.5
			sld_relax.value = 0.5
			sld_turbo.value = 0.5
		)
		on btn_sldreset pressed do
		(
			sld_displace.value = 1.0
			sld_noise.value = 1.0
			sld_spherify.value = 1.0
			sld_ripple.value = 1.0
			sld_bend.value = 1.0
			sld_twist.value = 1.0
			sld_rorschach.value = 1.0
			sld_relax.value = 1.0
			sld_turbo.value = 1.0
		)
		on btn_sldmax pressed do
		(
			sld_displace.value = 1.5
			sld_noise.value = 1.5
			sld_spherify.value = 1.5
			sld_ripple.value = 1.5
			sld_bend.value = 1.5
			sld_twist.value = 1.5
			sld_rorschach.value = 1.5
			sld_relax.value = 1.5
			sld_turbo.value = 3
		)
		on btn_forceall pressed do
		(
			chk_forceDisplace.checked = on
			chk_forceNoise.checked = on
			chk_forceSpherify.checked = on
			chk_forceRipple.checked = on
			chk_forceBend.checked = on
			chk_forceTwist.checked = on
			chk_forceRorschach.checked = on
			chk_forceRelax.checked = on
			chk_forceTurbo.checked = on
		)
		on btn_forcenone pressed do
		(
			chk_forceDisplace.checked = off
			chk_forceNoise.checked = off
			chk_forceSpherify.checked = off
			chk_forceRipple.checked = off
			chk_forceBend.checked = off
			chk_forceTwist.checked = off
			chk_forceRorschach.checked = off
			chk_forceRelax.checked = off
			chk_forceTurbo.checked = off
		)
		on btn_rndall pressed do
		(
			rndmods()
			rndamount()
			rndforce()
		)
		on btn_submit pressed do
		(
			print "Creating Weird Shit..."
			creator()
		)
	)
	createDialog rorschach pos:[50,150]
)
