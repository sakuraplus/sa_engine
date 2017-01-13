#TITLE=SaE_Eng
#INFO
New Cliptext library
#SORT=n




#T=img flash
[img xxx.png,0,0,layer_name]
[wait 500]
[img ,0,0,layer_name]
#T=funt color
 <font  color="#ffff00"></font>
 #T=<b>text</b>
<b></b>
#T=<br>
<br>
#T=<i></i>
<i></i>

#T=[ask ]selection
[ask selection,720,400,label,btnIMG]
#T=[askdialog]
[askdialog character_name,lines,img_file,400,200,layer_name] 

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
[dialog character_name,lines,img_file,400,200,layer_name]
#T=[text]text auto skip
,auto]
#T=[text add]
[text add,0,20,600,]
#T=[text clear]
[text clear]
#T=[text new]
[text new,0,20,600,]

#T=[clr]hide msg
[clr] 
#T=[dialog]
[dialog character_name,lines]
#T=[dialogadd]
[dialogadd lines]
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