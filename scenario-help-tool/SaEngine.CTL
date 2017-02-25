#TITLE=SaE_Eng
#INFO
Cliptext library of sakusaku engine
#SORT=n

#T=font color
 <font  color="#ffff00">^!</font>
#T=<u>under line</u>
<u>^!</u>
#T=<br>
<br>^!
#T=[ask]selection
[ask TEXT_CONTENT|720|400|LABEL_NAME|IMG_FILE]
#T=[btn]button
[ask TEXT_CONTENT|720|400|LABEL_NAME|IMG_FILE]
#T=[script]script as label
script: SCRIPT_NAME
#T=[askdialog]
[askdialog CHARACTER_NAME|TEXT_CONTENT|IMG_FILE|400|200|LAYER_NAME] 
#T=[removebtn]
[removebtn]
^!


#T=[img]imagine
[img IMG_FILE|500|140|LAYER_NAME]
#T=[img]clear layer
[img clear|500|140|LAYER_NAME]
#T=[clearimg]clear all layer
[clearimg]
^!



#T=[background]
[background IMG_FILE]
#T=[bgm]change bgm
[bgm BGM_FILE]
#T=[bgmstop]
[bgmstop]
^!
#T=[sound]sound effect
[sound SOUND_FILE]


#T=[dialog]with img
[dialog CHARACTER_NAME|TEXT_CONTENT|IMG_FILE|400|200|LAYER_NAME]
#T=[dialog]
[dialog CHARACTER_NAME|TEXT_CONTENT]
#T=[dialog]Auto
[dialog CHARACTER_NAME|TEXT_CONTENT|auto]
#T=[dialogadd]
[dialogadd TEXT_CONTENT]
#T=[clr]clear dialog
[clr] 
^!
#T=[msghide]hide dialog
[msghide]
^!
#T=[msgshow]hide dialog
[msgshow] 
^!
					
#T=[showtip]tips
[showtip TEXT_CONTENT]


#T=[text]add auto skip
|auto]
#T=[text add]
[text add|0|20|600|TEXT_CONTENT]
#T=[text new]
[text new|0|20|600|TEXT_CONTENT]
#T=[text clear]
[text clear]
^!


#T=[goto]goto label
[goto LABEL_NAME]

#T=[label]
[label LABEL_NAME]

#T=[eval]variable
[eval @VARIABLE_NAME |OPERATOR|VALUE]

#T=[if]
[if  @VARIABLE_NAME  OPERATOR  VALUE] 
^!
[end if]

#T=[getcg]
[getcg CG_name]
^!
#T=[showcg]
[showcg]
^!

#T=[enablesave]
[enablesave]
^!
#T=[disablesave]
[disablesave]
^!
#T=[autosave]
[autosave]
^!
#T=[load]
[load SAVE_FILE]


#T=[call]change scenario file
[call TXT_FILE]

#T=[call]with label
[call TXT_FILE|LABEL_NAME]

#T=[return]
[return]
^!
#T=[script]call script
[script SCRIPT_NAME]
#T=[iscript]in game script
[iscript SCRIPT_NAME]
#T=[endiscript]in game script
[endiscript SCRIPT_NAME]


#T=[wait]
[wait TIME_IN_MILLISECOND]

#T=waitclick
[waitclick]
^!

#T=[initsavefile]initialize save file
[initsavefile]
^!
#T=[setdurtime]set time
[setdurtime]
^!


#T=img flash
[img IMG_FILE|0|0|LAYER_NAME]
[wait 500]
[img |0|0|LAYER_NAME]


#