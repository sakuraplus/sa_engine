#TITLE=SaE_Eng
#INFO
New Cliptext library
#SORT=n




#T=img flash
[img IMG_FILE,0,0,LAYER_NAME]
[wait 500]
[img ,0,0,LAYER_NAME]
#T=funt color
 <font  color="#ffff00"></font>
 #T=<b>TEXT_CONTENT</b>
<b></b>
#T=<br>
<br>
#T=<i></i>
<i></i>

#T=[ask ]selection
[ask TEXT_CONTENT,720,400,LABEL,IMG_FILE]
#T=[askdialog]
[askdialog CHARACTER_NAME,TEXT_CONTENT,IMG_FILE,400,200,LAYER_NAME] 

#T=[autosave]
[autosave]
#T=[background]
[background img_file]
#T=[bgm]change bgm
[bgm bgm_file]
#T=[bgmstop]
[bgmstop]
#T=[call]change scenario file
[call txt_file]


#T=[clearimg]clear all layer
[clearimg]
#T=[dialog img]
[dialog CHARACTER_NAME,TEXT_CONTENT,IMG_FILE,400,200,LAYER_NAME]
#T=[text]text auto skip
,auto]
#T=[text add]
[text add,0,20,600,TEXT_CONTENT]
#T=[text clear]
[text clear]
#T=[text new]
[text new,0,20,600,]

#T=[clr]hide msg
[clr] 
#T=[dialog]
[dialog CHARACTER_NAME,LINES_TEXT_CONTENT]
#T=[dialogadd]
[dialogadd LINES_TEXT_CONTENT]
#T=[eval]variable
[eval @variable_name ,+,value]
#T=[getcg]
[getcg CG_name]
#T=[goto]goto label
[goto label]
#T=[if]
[if (@variable_name >value)] 
[end if]
#T=[img]”“C
[img img_file,500,140,layer_name]
#T=[label]
[label label]
#T=[load]
[load savefile.xml]
#T=[showtip]tips
[showtip tips]
#T=[sound]“Ù–ß
[sound sound_file]
#T=[wait]
[wait time_in_millisecond]
#T=waitclick
[waitclick]
[initsavefile]
#T=[initsavefile]initialize save file
[initsavefile]

#