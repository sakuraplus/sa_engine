package
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.*;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import com.greensock.*;
	import com.greensock.plugins.*;


	//
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	//

    import flash.display.Loader;
    import flash.display.Sprite;



	///////////
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	////////////
	import flash.system.Capabilities;
	import flash.desktop.NativeApplication;
	import flash.ui.Keyboard;


	public class saE extends Sprite 
	{

		
		var needupdate:int = 0;
		///////////txt
		var req:URLRequest ;
		var loader:URLLoader = new URLLoader  ;
		////////////////////////
		var arrScript:Array;//储存script脚本
		var inscript = false;
		var ScrI:int=0;
		var arrScrInd:int=-1;//脚本片段索引
		///////////////////////
		var arr:Array;
		var ti = 0;//脚本序号
		//return
		var lastti = 0;//call跳转前的序号
		var calllabel = "";//跳转标签
		var lastScenario = "";//跳转前脚本
		//
		var asking = false;
		var gotoArr:Array = new Array;//跳转
		var loadtxt = false;//是否正在读取
		var readScenario:String;//当前使用脚本
		var firstScenario:String;//默认初始脚本
		/////////////////txt

		///////////////cg
		var cgXML = new XML ;
		var cgfileStream:FileStream;
		var cgLoader:URLLoader;// 加载cg图片
		var cgArray:Array;//loader数组
		var cgPage = 0;//翻页
		//////////////cg

		var svfileStream:FileStream;//固定变量xml

		var savefileStream:FileStream;//存档
		var loadXML:XML = new XML  ;//读取存档
		var StrAutosave:String ="autosave.xml" ;
		var StrSave:String ="save.xml" ;//默认保存路径


		/////读取配置xml
		var initXML = new XML  ;
		var initLoader:URLLoader;//r = new URLLoader(initURL);
		var gameStart = false;


		var evallist:XMLList;//变量
		var playingat:XMLList;//进度,当前脚本和行号
		var sevallist:XMLList;//变量
		var tempevallist:XMLList;//临时变量
		
		
		var craArray:Array = new Array  ;//立绘
		var askbtnArray:Array = new Array  ;//选项
		var askArray:Array = new Array  ;//选项
		var askLoadArray:Array = new Array  ;//选项
		var bgurl:String = new String  ;
		var bgdurtime=0;
	

		var durtime = 0;
		var sysLoader:Loader = new Loader  ;//菜单背景
		var btnSLoader:Loader = new Loader  ;//存档按钮
		var btnLLoader:Loader = new Loader  ;//快速读档
		var btnBLoader:Loader = new Loader  ;//imgreserve1回菜单
		var btnRLoader:Loader = new Loader  ;//imgreserve2
		var btnPLoader:Loader = new Loader  ;//回放按钮
		var btnSkipLoader:Loader = new Loader  ;//自动播放
		
		var saveable=true;

		var bgmurl:String;//背景音乐地址
		var soundBGM:Sound;
		var bgmchannel:SoundChannel;
		var BGtransform:SoundTransform;// bgmchannel.soundTransform;
		var bgm:URLRequest;

		var snd:Sound;//音效
		var sndchannel:SoundChannel;
		///var iii = new initS  ;

		public var btnsoundurl="";//按钮音效clicksound
		var btnsnd:Sound;
		var btnsndchannel:SoundChannel;


		var waiting = false;//等待

		var waittimer:Timer=new Timer(5000,1);;

		var onskip = false;//自动播放
		var skiptimer = new Timer(1000,1);
		var askmsg = "";//确认对话框参数

		var btnwaiting = false;//按钮按下后等待
		var waittimerBtn = new Timer(400,1);

		var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);//在ios中加载swf资源

		var FileP:File;//存档文件系统位置
		
		var Tformat:TextFormat = new TextFormat();
		
		var SaeText:SaEText;//=new SaEText ;
		var SaeBg:SaEBg=new SaEBg ;
		var SaeDialog:SaEDialog;
		var SaeTrace:SaETrace=new SaETrace;
		var SaePlayback:SaEPlayback;//=new SaEPlayback;
		var SaeDebug:SaEPlayback;//=new Debug;
		var gamedebug=false;
		var SaeMsgbox:SaEMsgbox;
		var SaeCg:SaECg;
		var SaeSavepanel:SaESavepanel;//''''
		
		public function saE()
		{

			
			bgurl = "";
			bgmurl = "";
			trace("☆saE开始01");
//			trace(analysisIF.analysis("3>2"));
			//trace("ZZZZZZZZZZZZZZZZ"+trimspace("   asd  wer   "));
			//trace("ZZZZZZZZZZZZZZZZ" + trimspace("asd wer   "));
			//trace("ZZZZZrrrrrrZZZZZ" + replacespace("  a s d  w e   r   "));
			trace("zzz"+(true||false&&true));
			trace("zzz"+(true&&false||true));
			loaderContext.allowCodeImport=true;//允许加载swf中脚本

			tracetxt.addChild(SaeTrace);
			
			addEventListener("NEXT",goNext);
			addEventListener("LoadError",IMGloadError);
			addEventListener("clickBack",msgBack);
			addEventListener("clickReplay",msgBack);
			addEventListener("clickLoad",msgBack);
			addEventListener("keyback",msgBack);


			trace("sae01-");
			
			//tracetxt.visible = false;
			//if (Capabilities.cpuArchitecture == "ARM")
			//if (Capabilities.os.toLowerCase().match("iphone")!=null ||Capabilities.os.toLowerCase().match("mac")!=null)
			//trace(Capabilities.os.toLowerCase().substring(0,5));
			if (Capabilities.os.toLowerCase().substring(0,6)=="iphone" ||Capabilities.os.toLowerCase().substring(0,3)=="mac")
			{
				showtrace("mac or ios  "+Capabilities.os+"//"+Capabilities.cpuArchitecture);
				FileP = new File(File.applicationDirectory.nativePath);
				FileP = FileP.resolvePath("..");
			}
			else if (Capabilities.os.toLowerCase().match("windows")!=null)
			{
				showtrace("win "+Capabilities.os+"//"+Capabilities.cpuArchitecture);
				FileP = new File(File.applicationDirectory.nativePath);
			}
			else
			{
				showtrace("android or else,use back to escape "+Capabilities.os+"//"+Capabilities.cpuArchitecture);
				FileP = new File(File.applicationStorageDirectory.nativePath);
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,handleDeactivate,false, 0, true);
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,onDeactivate);	//stage.addEventListener(Event.DEACTIVATE 也可以
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,onActivate);	
			}

			waittimerBtn.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerBtnComplete);
			MCwaiting.alpha = 0;//();
			
			////自动播放timer
			mcskip.visible=false;
			skiptimer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerSkipComplete);
			trace("1//////////");

			trace("3//////////");

			btnSystem.addChildAt(sysLoader,0);
			btnSystem.btnSave.addChildAt(btnSLoader,0);
			btnSystem.btnLoad.addChildAt(btnLLoader,0);
			btnSystem.btnBack.addChildAt(btnBLoader,0);
			btnSystem.btnReplay.addChildAt(btnRLoader,0);
			btnSystem.btnPlayback.addChildAt(btnPLoader,0);
			btnSystem.btnSkip.addChildAt(btnSkipLoader,0);

			//////////////////////
			btnsound.addEventListener(MouseEvent.CLICK, clickBtnSound);			
			
			//加载字体
			var TFloader:Loader  = new Loader();
			var TFurl:URLRequest = new URLRequest("setting/font.swf");//"fontfish.swf"
			TFloader.contentLoaderInfo.addEventListener(Event.COMPLETE, TextformatComplete);
			TFloader.load(TFurl,loaderContext);
			
			
		}
		//////////////////////	
		/////public  function xzzz(delimiter: String, ...limit)		
		//////////////////////

		//字体swf加载完成
		function TextformatComplete(event:Event):void
		{
			var fontArray:Array = Font.enumerateFonts(false);
			trace("☆字体swf加载完成02fontArray"+fontArray);
			Tformat.font = fontArray[0].fontName;
			
			//加载init
			var initURL:URLRequest = new URLRequest("setting/init.xml");
			initLoader = new URLLoader(initURL);
			initLoader.addEventListener(Event.COMPLETE,initxmlLoaded);		
			//loaderContext.applicationDomain =null;
			//loaderContext.allowCodeImport=false;
		}
		
		

		//关闭/打开背景音乐，保留音效
		function clickBtnSound(event:MouseEvent):void
		{
			btnsound.alpha=1;
			if(bgmchannel==null)
			{
				return;
			}
			//TweenLite.to(btnsound,durtime*4,{delay:2,alpha:0.1});
			if(BGtransform == null)
			{
				bgmvolume(0);
				btnsound.gotoAndStop(2);
				return;
			}

			if(BGtransform.volume>0.5)
			{
				bgmvolume(0);
				btnsound.gotoAndStop(2);
			}
			else
			{
				bgmvolume(1);
				btnsound.gotoAndStop(1);
			}

		}

		//按返回键退出，home键暂停音乐
		function handleDeactivate(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.BACK)
			{
				//提示退出
				event.preventDefault();//屏蔽默认事件  
				showtrace("KEY BACK ");
				askmsg = "keyback";
				SaeMsgbox.showmsg (askmsg, "要退出了么？");
				
				//NativeApplication.nativeApplication.exit();
			}
			else if(event.keyCode== Keyboard.MENU)  
                            {  
                             //menu 键
			    // showtrace("MENU");			
                            }  
                            else if(event.keyCode == Keyboard.SEARCH)  
                            {  
			  //  showtrace("SERACHHHH ");
                                //search      
                            }  
                            else  if (event.keyCode == Keyboard.HOME) {  
                                //Handle Home button.  
			
                            }  
		}
		
		var BGMposition:Number=0;
		function onDeactivate(event:Event):void
		{
			showtrace("onDeactivateeeeeeee ");
			BGMposition=bgmchannel.position;
			bgmchannel.stop();			
			//trace("stop-BGMPOSITION"+BGMposition);
		}


		
		function onActivate(event:Event):void
		{
			showtrace("onActivateeeeeeee ");
			bgmchannel = soundBGM.play(BGMposition);
		}


		//初次写入存档
		function updatecgxml():void
		{
			var UpdcgURL:URLRequest = new URLRequest("setting/cg.xml");
			var Updcgloader:URLLoader = new URLLoader(UpdcgURL);
			Updcgloader.addEventListener(Event.COMPLETE,UpdcgxmlLoaded);			
		}

		function UpdcgxmlLoaded(event:Event):void
		{
			trace ("UPDATE CG!!!!");
			var UpdcgXML = XML(event.target.data) ;
			var xi=cgXML.cgpanel.children().length();
			if(UpdcgXML.cgpanel.children().length()>xi)
			{
				while (UpdcgXML.cgpanel.children().length() > cgXML.cgpanel.children().length())
				{
				var cx=UpdcgXML.cgpanel.children()[xi];
				cgXML.cgpanel.appendChild(cx);
				xi++;
				}
				var file = FileP.resolvePath("Documents/cg.xml");
				var stream:FileStream = new FileStream  ;
				stream.open(file,FileMode.WRITE);
				stream.addEventListener(Event.COMPLETE,savecompleteHandler);
				stream.writeUTFBytes(cgXML.toString());
				stream.close();
				trace("CG UpDATE  xmlsave");
				needupdate ++;
//				writeSavexml();
			}
		}
		
		function updSateStatxml():void
		{
			var UpdStatURL:URLRequest = new URLRequest("setting/staticvar.xml");
			var UpdStatloader:URLLoader = new URLLoader(UpdStatURL);
			UpdStatloader.addEventListener(Event.COMPLETE,UpdStatxmlLoaded);
			
		}
		function UpdStatxmlLoaded(event:Event):void
		{
			trace ("UPDATE STATIC!!!!");
			//trace (event.target.data);
			var UpdStatXML = XML(event.target.data) ;
			var xi=sevallist.children().length();
			
			if(UpdStatXML.staticVar.children().length()>xi)
			{
				while (UpdStatXML.staticVar.children().length() >sevallist.children().length())
				{
				var cx=UpdStatXML.staticVar.children()[xi];
				sevallist.appendChild(cx);
				//trace(xi + "SCSCxx " + sevallist);
				xi++;
				}
				
				var file = FileP.resolvePath("Documents/staticvar.xml");
				var stream:FileStream = new FileStream  ;
				stream.open(file,FileMode.WRITE);
				stream.addEventListener(Event.COMPLETE,savecompleteHandler);
				stream.writeUTFBytes("<sv>" + sevallist.toString()+ "</sv>");				
				stream.close();
				trace("static update xmlsave");
				
				needupdate ++;
				//writeSavexml();
			}
			
		}

		function writeInitSavefile(numslot:int)
		{
			var file = FileP.resolvePath("Documents/cg.xml");
			if (file.exists)
			{
				trace("存在存在");//文件存在
				loadcgxml(); 
				updatecgxml();
				
			}
			else
			{
				////////////文件不存在则从包中拷贝
				var original0:File = File.applicationDirectory.resolvePath("setting/cg.xml");
				trace("save不存在   "+original0.nativePath);

				var newFile0 = FileP.resolvePath("Documents/cg.xml");
				original0.copyTo(newFile0, true);
				loadcgxml();
			}
			

			file = FileP.resolvePath("Documents/staticvar.xml");
			if (file.exists)
			{
				trace("存在存在");//文件存在
				updSateStatxml();
				loadstaticvarxml();
			}
			else
			{
				////////////文件不存在则从包中拷贝
				//showtrace("不存在不存在"+file.nativePath);
				var original1:File = File.applicationDirectory.resolvePath("setting/staticvar.xml");
				trace("staticvar不存在   "+original1.nativePath);

				var newFile1 = FileP.resolvePath("Documents/staticvar.xml");
				original1.copyTo(newFile1, true);
				loadstaticvarxml();
			}
			
			file = FileP.resolvePath("Documents/save.xml");
			if (file.exists)
			{
				trace("save存在存在");//文件存在
				loadsavexml();

			}
			else
			{
				////////////文件不存在则生成
				//showtrace("不存在不存在"+file.nativePath);
				var savexml=new XML;
				var slotxml=XML("<slot><name/><exist/><img/><txt/><svar/><playingat><scenario/><lastScenario/><lastreadline/><readline/><bgm/><bg/></playingat></slot>");
				slotxml.exist=false;
				var xmltemp="";//=slotxml;
				trace("SLOTxml"+slotxml);
				for (var i = 0; i < numslot; i++)
				{					
					slotxml.name=i;
					xmltemp+=slotxml.toString();
				}
				savexml=XML("<save>" +xmltemp + "</save>");	
				saveXML=savexml;
				trace( "savexmlsavexml"+ savexml.children()[2].toString());

				var stream:FileStream = new FileStream  ;
				stream.open(file,FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();
				stream.open(file,FileMode.WRITE);
				stream.addEventListener(Event.COMPLETE,savecompleteHandler);
				stream.writeUTFBytes(savexml.toString());
				stream.close();
				trace("init save  xmlsave");
			}			
			
//			writeSavexml();
			
		}

		//覆盖存档
		function anInitSavefile()
		{
			var original:File = File.applicationDirectory.resolvePath("setting/cg.xml");
			trace("cg覆盖   "+original.nativePath);
			var newFile = FileP.resolvePath("Documents/cg.xml");
			original.copyTo(newFile, true);


			SaeCg.initCG();
			loadcgxml();

			var original1:File = File.applicationDirectory.resolvePath("setting/staticvar.xml");
			trace("st 覆盖  "+original1.nativePath);
			var newFile1 = FileP.resolvePath("Documents/staticvar.xml");
			original1.copyTo(newFile1, true);

			loadstaticvarxml();

			ti++;
			analysisscript(ti);
		}

		//读取cgxml
		function loadcgxml():void
		{
			cgXML = new XML ;
			cgArray=new Array;
			cgPage = 0;
			trace(" loadcgxml");
			var file = FileP.resolvePath("Documents/cg.xml");
			cgfileStream = new FileStream();
			cgfileStream.addEventListener(Event.COMPLETE, readCgXMLfile);
			cgfileStream.openAsync(file, FileMode.READ);
		}
		//save file''''
		function loadsavexml():void
		{
			trace(" staticvarxml");
			var file = FileP.resolvePath("Documents/save.xml");
			savefileStream = new FileStream();
			savefileStream.addEventListener(Event.COMPLETE, saveXMLfile);
			savefileStream.openAsync(file, FileMode.READ);

			loadtxt = false;
		}
		//save file''''
		function saveXMLfile(event:Event):void
		{
			saveXML = new XML  ;
			saveXML = XML(savefileStream.readUTFBytes(savefileStream.bytesAvailable));
			savefileStream.close();
			
		}
		//固定变量
		function loadstaticvarxml():void
		{
			trace(" staticvarxml");
			var file = FileP.resolvePath("Documents/staticvar.xml");
			//var file = FileP.resolvePath("cg.xml");
			svfileStream = new FileStream();
			svfileStream.addEventListener(Event.COMPLETE, staticvarXMLfile);
			svfileStream.openAsync(file, FileMode.READ);
		}
		//固定变量
		function staticvarXMLfile(event:Event):void
		{
			trace("svfileStreamsvfileStream" );
			trace("svfileStream.readUTFBytes==" +svfileStream.readUTFBytes);
			trace("svfileStream.bytesAvailable==="+svfileStream.bytesAvailable );
			var svXML = XML(svfileStream.readUTFBytes(svfileStream.bytesAvailable));
			svfileStream.close();
			sevallist = svXML.staticVar;
			ansetdurtime();//uodate speed
			//trace("evallist sv=" +sevallist);
		}
		//cgxml
		function readCgXMLfile(event:Event):void
		{
			cgXML = XML(cgfileStream.readUTFBytes(cgfileStream.bytesAvailable));
			cgfileStream.close();
			SaeCg.readCGXML(cgXML);
		}

		//初始化
		function initxmlLoaded(event:Event):void
		{	
			trace("☆init加载完成03");
			gameStart = true;
			initXML = XML(initLoader.data);
			firstScenario = initXML.playingat.scenario;
			playingat = initXML.playingat;
			trace(("playingat.scenario" + playingat.scenario));
			readScenario = playingat.scenario;
			req = new URLRequest(("scenario/" + readScenario));//加载路径
			ti = playingat.readline;
			////////////txt
			trace("☆init-03 加载txt");
			loader.load(req);
			loader.addEventListener(Event.COMPLETE,TXTcompleteHandler);
			/////////////txt;
			
			////读取script
			trace("☆init-03 加载txt script");
			var reqSc = new URLRequest("scenario/script.txt");//加载路径
			var loaderSc:URLLoader = new URLLoader ;
			loaderSc.load(reqSc);
			loaderSc.addEventListener(Event.COMPLETE,SccompleteHandler);
			loaderSc.addEventListener(IOErrorEvent.IO_ERROR, LoadErrorHandler);

			///////初始化淡入淡出时间
			durtime = parseInt(initXML.durtime)/1000;
			trace(durtime+"......................");
			skiptimer.delay =parseInt(initXML.skiptime);// 
			waittimerBtn.delay =parseInt(initXML.btntime);// /

			////初始化立绘图层layer
			trace("durtime" + durtime);
			var i = 0;
			for (i = 0; i <  initXML.Layer.children().length(); i++)
			{
				var saeimg:SaEImg=new SaEImg;
				craArray.push(saeimg);
				imglayer.addChild(craArray[i]);
			}

			

			//////////按钮选项按下音效btn sound;
			if(initXML.Sui.clicksound. @ url.length()>0)
			{
				btnsoundurl=initXML.Sui.clicksound. @ url;
			}
			

			//////////初始化人物对话框msg;
			if(initXML.Sui.msgtalk. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.msgtalk. @ sizetxt);
			}else{
			Tformat.size=36;
				trace("msgtalk Tformat size default 36");
			}
			SaeDialog=new SaEDialog(initXML.Sui.msgtalk. @ img,initXML.Sui.msgtalk. @ colorname, initXML.Sui.msgtalk. @ colordialog,Tformat);   //
			msgTalk.addChild(SaeDialog);
			msgTalk.x = initXML.Sui.msgtalk. @ x;
			msgTalk.y = initXML.Sui.msgtalk. @ y;

			////初始化text
			if(initXML.Sui.txtlayer. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.txtlayer. @ sizetxt);
			}else{
			Tformat.size=36;
				trace("txtlayer Tformat size default 36");
			}
			SaeText=new SaEText( initXML.Sui.txtlayer. @colortxt,Tformat) ;
			txtlayer.visible = false;
			txtlayer.addChild(SaeText);

			////初始化showtrace
			if(initXML.Sui.txttrace. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.txttrace. @ sizetxt);
			}else{
			Tformat.size=22;
				trace("txttrace Tformat size default 22");
			}
			SaeTrace.init(initXML.Sui.txttrace. @ colortxt,initXML.Sui.txttrace. @ colorbg,parseInt(initXML.Sui.txttrace. @ durtime),Tformat);
			
			///初始化背景图
			imgBG.addChild(SaeBg);

			///初始化回放文字
			if(initXML.Sui.imgplayback. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.imgplayback. @ sizetxt);
			}else{
			Tformat.size=36;
			trace("imgplayback Tformat size default 36");
			}
			var playbacklength;
			if(initXML.Sui.imgplayback. @ lines.length()>0)
			{
				playbacklength=parseInt(initXML.Sui.imgplayback. @ lines);
			}else{
				playbacklength=8;
			trace("imgplayback playbacklength default 8");
			}
			SaePlayback=new SaEPlayback(initXML.Sui.imgplayback. @ colortxt,initXML.Sui.imgplayback. @ colorbg,Tformat,playbacklength);
			txtplayback.addChild(SaePlayback);

			///初始化debug
				//durtime = parseInt(initXML.durtime)/1000;
			if(initXML.debug==true)
			{
				gamedebug=true;
				Tformat.size=30;
				SaeDebug=new SaEPlayback("000000","ffffff",Tformat,5);
				stage.addChild(SaeDebug);//txtdebug
				SaeDebug.showText ();
				SaeDebug.mouseEnabled = false; 
				SaeDebug.mouseChildren = false; 

				SaeDebug.scaleX=0.5;
				SaeDebug.scaleY=0.5;

			}
			
			


			///初始化对话框
			if(initXML.Sui.msgbox. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.msgbox. @ sizetxt);
			}else{
			Tformat.size=30;
				trace("msgbox Tformat size default 30");
			}
			SaeMsgbox=new SaEMsgbox( initXML.Sui.msgbox. @ colorbg,initXML.Sui.msgbox. @ colortxt,initXML.Sui.msgbox. @ img,initXML.Sui.msgbox. @ pos, Tformat);
			msgbox.addChild(SaeMsgbox);
			
			//初始化CG
			if(initXML.Sui.cgScreen. @ sizetxt.length()>0)
			{
				Tformat.size=parseInt(initXML.Sui.cgScreen. @ sizetxt);
				trace("@ sizetxt cgScreen "+Tformat.size);
			}else{
			Tformat.size=26;
				trace("cgScreen Tformat size default-26");
			}
			SaeCg=new SaECg(initXML.Sui.cgScreen.@img, initXML.Sui.cgScreen.@pos,initXML.Sui.cgScreen.@colortxt, initXML.Sui.cgScreen.@txtbg, initXML.Sui.cgScreen.@colorbg, Tformat);
			cgSc.addChild(SaeCg);//cgScreen



			//初始化save''''
			var numslot=initXML.Sui.savepanel. @ numslot;
			SaeSavepanel = new SaESavepanel( initXML.Sui.savepanel. @ colorbg, initXML.Sui.savepanel. @ colortxt,
			initXML.Sui.savepanel. @ img,
			initXML.Sui.savepanel. @ pos, numslot,Tformat);
			// slotup + slotup + txtleft + slotup + txtwidth;
			savelayer.addChild(SaeSavepanel);//			
			for (i = 0; i < numslot; i++)
			{
				SaeSavepanel.saveloaderArray[i].addEventListener(MouseEvent.CLICK,clicksaveslot);
			}


			/////////sys菜单
			var sysURLReq:URLRequest = new URLRequest(initXML.Sui.imgsystem. @ img);
			sysLoader.load(sysURLReq);
			btnSystem.y = initXML.Sui.imgsystem. @ y;
			btnSystem.x = initXML.Sui.imgsystem. @ x1;//)840;

			//保存
			sysURLReq = new URLRequest(initXML.Sui.imgsave. @ img);
			btnSLoader.load(sysURLReq);
			btnSystem.btnSave.x = initXML.Sui.imgsave. @ x;
			btnSystem.btnSave.y = initXML.Sui.imgsave. @ y;
			//没有包含@file属性则使用默认路径save.xml
			if(initXML.Sui.imgsave. @file !=null)
			{
				StrSave=initXML.Sui.imgsave. @ file;
			}

			//快速读取自动存档
			sysURLReq = new URLRequest(initXML.Sui.imgload. @ img);
			btnLLoader.load(sysURLReq);
			btnSystem.btnLoad.x = initXML.Sui.imgload. @ x;
			btnSystem.btnLoad.y = initXML.Sui.imgload. @ y;		
			///没有包含@file属性则使用默认路径，包含file属性则修改默认存档路径
			if(initXML.Sui.imgload. @file !=null)
			{
				StrAutosave=initXML.Sui.imgload. @file;
				trace("nulll");
			}
				
			//返回/自定义按钮，自定义提示文字
			sysURLReq = new URLRequest(initXML.Sui.imgreserve1. @ img);
			btnBLoader.load(sysURLReq);
			btnSystem.btnBack.x = initXML.Sui.imgreserve1. @ x;
			btnSystem.btnBack.y = initXML.Sui.imgreserve1. @ y;

			//重新开始/自定义按钮，自定义提示文字
			sysURLReq = new URLRequest(initXML.Sui.imgreserve2. @ img);
			btnRLoader.load(sysURLReq);
			btnSystem.btnReplay.x = initXML.Sui.imgreserve2. @ x;
			btnSystem.btnReplay.y = initXML.Sui.imgreserve2. @ y;

			//回顾
			sysURLReq = new URLRequest(initXML.Sui.imgplayback. @ img);
			btnPLoader.load(sysURLReq);
			btnSystem.btnPlayback.x = initXML.Sui.imgplayback. @ x;
			btnSystem.btnPlayback.y = initXML.Sui.imgplayback. @ y;
			
			//自动播放
			sysURLReq = new URLRequest(initXML.Sui.imgskip. @ img);
			btnSkipLoader.load(sysURLReq);
			btnSystem.btnSkip.x = initXML.Sui.imgskip. @ x;
			btnSystem.btnSkip.y = initXML.Sui.imgskip. @ y;

			btnSystem.btnsys.addEventListener(MouseEvent.CLICK,clickShowsys);
			//btnSystem.btnSave.addEventListener(MouseEvent.CLICK,clickSave);
			btnSystem.btnSave.addEventListener(MouseEvent.CLICK,clickSaveBtn);//''''
			btnSystem.btnLoad.addEventListener(MouseEvent.CLICK,clickLoadBtn);
			btnSystem.btnBack.addEventListener(MouseEvent.CLICK,clickBack);
			btnSystem.btnReplay.addEventListener(MouseEvent.CLICK,clickReplay);
			btnSystem.btnPlayback.addEventListener(MouseEvent.CLICK,clickPlayback);
			btnSystem.btnSkip.addEventListener(MouseEvent.CLICK,clickSkip);

			//////////变量
			evallist = initXML.svar;
			//trace("evallist=" +evallist);
			
			//////////写入cg和存档，更新staticvar
			trace("☆init-03 加载cg和存档");
			writeInitSavefile(numslot);//写入cg和存档

			 stageInit();///////////
		}
		var saveXML=new XML;
		function clicksaveslot(event:Event)
		{//''''
			//save
			trace("clickslot1");
			trace(event.currentTarget.parent);
				
			var i = 0;
			i = SaeSavepanel.saveloaderArray.indexOf(event.currentTarget);
			//var file;// = FileP.resolvePath("Documents/save.xml");
			trace("clickslot2==----" + i);
			if (savestate == true)
			{
				//save
				saveSlot(i);
			
			}else {
				
				//load
				
				askmsg = "clickLoad";
				SaeMsgbox.showmsg (askmsg, initXML.Sui.imgload. @ txt);
				
				loadindex = i;
				
				
			}
			
		}
		var loadindex:int;
		/////////////////txt 读取script完成
		function SccompleteHandler(e:Event)
		{
			trace("☆读取script完成04");
			arrScript = [];
			var arrscT = e.target.data.split("[iscript ");//("<!");
			trace("==SC======="+arrscT.length);
			for each (var item in arrscT)
			{
				item="[iscript "+item;
				var scT = item.split("\n");
				var i = 0;
				for (i = 0; i < scT.length; i++)
				{ 
					scT[i] = trimspace(scT[i]);
					var str = scT[i];
					str = str.substring(0, str.indexOf("]") + 1);
					scT[i]=str;
					if (scT[i].length <= 2 || scT[i].indexOf("//") == 0)
					{
						//去除空行和注释
						scT.splice(i,1);
						i--;
					}
				}
			//	trace(i + "SCT=" + scT);
				if (scT.length > 1)
				{
				arrScript.push(scT);
				}
			}			
			trace("SC读取完成 "+arrScript[1]);
		}
		function LoadErrorHandler(e:Event)
		{
			//showtrace("file load error");
		}

		///////end txt script

		////////////////txt脚本读取完成
		function TXTcompleteHandler(e:Event)
		{
			trace("☆txt脚本读取完成04");
			arr = new Array  ;
			loadtxt = true;//读取完成
			arr = e.target.data.split("\n");
			trace("=============================");
			var i = 0;
			for (i = 0; i < arr.length; i++)
			{
				arr[i] = trimspace(arr[i]);
				if (arr[i].length <= 1 || arr[i].indexOf("//") == 0)
				{
					//去除空行和注释
					arr.splice(i,1);
					i--;
				}
			}
			//跳转数组
			gotoArr = new Array  ;
			for (i = 0; i < arr.length; i++)
			{
				arr[i] = arr[i].substring(arr[i].indexOf("["),arr[i].indexOf("]") + 1);
				var stag = arr[i].substring(1,arr[i].indexOf(" "));
				//建立索引
				if (stag == "label")
				{
					var labelname = arr[i].substring(arr[i].indexOf(" ") + 1,arr[i].indexOf("]"));
					var ar = [trimspace(labelname),i];
					gotoArr.push(ar);
				}
			}
			if (calllabel != "")
			{
				trace("read=calllabel" + calllabel);
				ti = anGOTO(calllabel, 0);
				
			}
			trace("read= ti" + ti);
			analysisscript(ti);
			txtlayer.addEventListener(MouseEvent.CLICK,clickNext);
			msgTalk.addEventListener(MouseEvent.CLICK,clickNext);
			btnNext.addEventListener(MouseEvent.CLICK,clickNext);
		}
		///////txt


		
		/////////////////////Timer等待结束
		function onTimerComplete(event:TimerEvent):void
		{
			//等待
			TweenLite.to(MCwaiting,0.5,{alpha:0});
			MCwaiting.stop();
			waiting = false;

			linebreak.play();//显示提示
			linebreak.visible = true;
			if (!inscript )
			{	
				trace("auto t");
				ti++;
				analysisscript(ti);
			}else {					
				trace("auto S   ScrI="+ScrI+" arrScrInd= "+arrScrInd);
				ScrI++;
				anIscript(arrScript[arrScrInd],ScrI);
			}
						
			trace("Time's Up!");
			if(onskip)
			{
				skiptimer.start();
		    }

		}
		function stopTimerSkip():void
		{
			//停止自动播放
			//trace("停止自动播放");
			skiptimer.reset();
			onskip = false;
			mcskip.visible=false;
		}

		function onTimerSkipComplete(event:TimerEvent):void
		{
			//自动播放timer
			if (! gameStart || ! loadtxt ||waiting)
			{
				trace("正在等待");
				return;
			}


			if (! asking)
			{
				linebreak.stop();
				linebreak.visible = false;
				ti++;
				if ((ti >= arr.length))
				{
					ti = 0;
				}
				analysisscript(ti);

			}
			if(onskip)
			{
				skiptimer.start();
			}else{
				mcskip.visible=false;
			}
		}


		function onTimerBtnComplete(event:TimerEvent):void
		{
			//按钮按下后延时
			btnwaiting = false;
			if(!waiting &&!onskip)
			{
			linebreak.play();
			linebreak.visible = true;
			}
		}

		function completeHandler(event:Event):void
		{
			//声音播放结束
			//trace("completeHandler: " + event);
		}




		//循环播放
		function soundCompleteHandler(event:Event):void
		{
			bgm = new URLRequest("sound/" +bgmurl);
			trace("soundCompleteHandler"+bgmurl);
			soundBGM = new Sound  ;
			soundBGM.addEventListener(Event.COMPLETE,completeHandler);
			soundBGM.load(bgm);
			bgmchannel = soundBGM.play();
			if(BGtransform!=null){
			bgmchannel.soundTransform=BGtransform;
			}
			bgmchannel.addEventListener(Event.SOUND_COMPLETE,soundCompleteHandler);
		}
		//end循环播放;

		

		///////////////////////////////
		var saveTempIndex=-1;
		//解析脚本
		function analysisscript(i:int):void
		{
			if (ti >= arr.length)
			{
				trace(ti+"最后一条");
				stopTimerSkip();
				ti = 0;
				i = 0;
			}
			
			
			if (arr[i].indexOf("[") == 0)
			{
				var stag = arr[i].substring(1,arr[i].indexOf(" "));
				if(gamedebug)
				{
					SaeDebug.write("»"+arr[i]);
				}
				if (arr[i].indexOf(" ") < 0)
				{
					stag = arr[i].substring(1,arr[i].length - 1);
					//trace("A~~" + stag+"//"+arr[i].length);
				}
				trace("●"+i+arr[i] );
				var txttemp=arr[i].substring(arr[i].indexOf(" ") + 1,arr[i].indexOf("]"));
				switch (stag)
				{
					case "showtip" :
						showtrace(txttemp);
						ti++;
						analysisscript(ti);
						return;
					case "showcg" :
						anSHOWCG();
						return;
					case "getcg" :
						anGETCG(txttemp);
						ti++;
						analysisscript(ti);
						return;
					case "autosave" :
						saveSlot(0);
						ti++;
						analysisscript(ti);
						return;
					case "enablesave" :
						saveable=true;
						btnSystem.btnSave.alpha=1;
						ti++;
						analysisscript(ti);
						return;
					case "disablesave" :
						saveable=false;
						btnSystem.btnSave.alpha=0.2;
						ti++;
						analysisscript(ti);
						return;
						
					case "load" :
						anLOAD(txttemp);
						return;

					case "text" :
						anTEXT(txttemp);
						return;
					case "dialogadd" :
						anDIALOGADD(txttemp);
						return;
					case "dialog" :
						anDIALOG(txttemp);
						return;
					case "askdialog" :
						anDIALOG(txttemp);
						return;

					case "img" :
						anIMG(txttemp);
						return;
					case "clearimg" :
						anCLEARIMG();
						ti++;
						analysisscript(ti);
						return;
					case "clr" :
						anCLR();
						return;						
					case "msghide" :
						anMSGhide();
						return;						
					case "msgshow" :
						anMSGshow();
						return;						
					case "background" :
						anBG(txttemp);
						ti++;
						analysisscript(ti);
						return;	
						
					case "ask" :
						stopTimerSkip();
						
						ti = anASK(i);
						analysisscript(ti);
						return;
					case "btn" :
						stopTimerSkip();
						ti = anBTN(i);
						analysisscript(ti);
						return;
					case "removebtn" :
						anBTNremove();
						ti++;
						analysisscript(ti);
						return;
						
					case "label" :
						ti++;
						analysisscript(ti);
						return;	
					case "goto" :
						ti=anGOTO(txttemp,i);
						analysisscript(ti);
						return;
						
					case "if" :
						ti=anIF(txttemp,i);
						analysisscript(ti);
						return;
					case "end" :
						ti++;
						analysisscript(ti);
						return;
					case "eval" :
						anEVAL(txttemp);
						ti++;
						analysisscript(ti);
						return;
					case "sound" :
						anSOUND( txttemp);
						ti++;
						analysisscript(ti);
						return;
					case "bgm" :
						anBGM(txttemp);				
						ti++;
						analysisscript(ti);
						return;
					case "bgmstop" :
						//bgmurl = "";
						anBGM("bgmstop");
						ti++;
						analysisscript(ti);
						return;
					case "return" :
						anReturn();
						stopTimerSkip();
						return;	
					case "call" :
						anCALL(txttemp);
						stopTimerSkip();
						return;
					case "wait" :
						anWait(txttemp);
						return;
					case "waitclick" :
						return;
					case "initsavefile" :
						anInitSavefile();
						return;
					case "script" :
						trace("scriptscript"+ txttemp);
						findIscript( txttemp);
						return;
					case "setdurtime" :
						trace("setdurtime!!!!!");
						ansetdurtime();
						ti++;
						analysisscript(ti);
						return;
					default :
						trace((stag + "please update your saE"));
						showtrace("please update your saE"+txttemp);
						ti++;
						analysisscript(ti);

						return;
				}

			}
			else
			{
				SaeDialog.Dialog(arr[ti],durtime);
			}
		}
		
		function findIscript(scriptname:String ):void
		{
			var ind = 0;
			scriptname = trimspace(scriptname);
			while (ind<arrScript.length)
			{
				var ttiscript = arrScript[ind][0].substring(arrScript[ind][0].indexOf(" ") + 1, arrScript[ind][0].indexOf("]"));
				ttiscript = trimspace(ttiscript);
				
				if(ttiscript==scriptname)
				{	
					arrScrInd = ind;
					break;
				}
				ind++;
			}
			if (arrScrInd < 0)
			{
				showtrace ("script not found");
				return;
			}
			inscript = true;		
			btnSystem.btnSave.alpha=0.4;
			anIscript(arrScript[ind],0);
		}
		function anIscript( arrS:Array ,i:int):void
		{
			if (i >= arrS.length || !inscript)
			{
				trace("最后一条SC");
				stopTimerSkip();
				
				i = 0;
				ScrI = 0;
				arrScrInd = -1;
				inscript = false;
				if(saveable)
				{
						btnSystem.btnSave.alpha=1;
				}
				ti++;
				analysisscript(ti);
				
				return;
			}
			
			if (arrS[i].indexOf("[") == 0)
			{
				var sstag = arrS[i].substring(1,arrS[i].indexOf(" "));
				if(gamedebug)
				{
					SaeDebug.write("»»"+arrS[i]);
				}
				if (arrS[i].indexOf(" ") < 0)
				{
					sstag = arrS[i].substring(1,arrS[i].indexOf("]"));
				}
				trace("S●" + i + arrS[i]);
				var txttemp=arrS[i].substring(arrS[i].indexOf(" ") + 1,arrS[i].indexOf("]"));

				switch (sstag)
				{
					case "iscript" :
					case "endiscript" :
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "showtip" :
						showtrace(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "showcg" :
						anSHOWCG();
						return;
					case "getcg" :
						anGETCG(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;

//					case "enablesave" :
//						saveable=true;
//						ScrI++;
//						anIscript(arrS,ScrI);
//						return;
//					case "disablesave" :
//						saveable=false;
//						ScrI++;
//						anIscript(arrS,ScrI);
//						return;
						
					case "load" :
						anLOAD(txttemp);
						return;

					case "text" :
						anTEXT(txttemp);
						return;
					case "dialogadd" :
						anDIALOGADD(txttemp);
						return;
					case "dialog" :
						anDIALOG(txttemp);
						return;

					case "img" :
						anIMG(txttemp);
						return;
					case "clearimg" :
						anCLEARIMG();
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "clr" :
						anCLR();
						return;						
					case "msghide" :
						anMSGhide();
						return;				
					case "msgshow" :
						anMSGshow();
						return;						
					case "background" :
						anBG(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;	
						

					case "goto" :
						ti = anGOTO(txttemp, i);
						
						i = 0;
						ScrI = 0;
						arrScrInd = -1;
						inscript = false;
						analysisscript(ti);
					
						return;
						
					case "if" :
						trace("S-ifffff");
						ScrI = aninscriptIF(arrS,txttemp, i);
						anIscript(arrS,ScrI);
						return;
					case "end" :
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "eval" :
						anEVAL(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "sound" :
						anSOUND(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "bgm" :
						anBGM(txttemp);
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "bgmstop" :
						//bgmurl = "";
						anBGM("bgmstop");
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					case "return" :
						trace("Ssssss-return");
						i = 0;
						ScrI = 0;
						arrScrInd = -1;
						inscript = false;
						btnSystem.btnSave.alpha=1;
						ti++;
						analysisscript(ti);
						return;	
					case "call" :
						anCALL(txttemp);
						stopTimerSkip();
						i = 0;
						ScrI = 0;
						arrScrInd = -1;
						inscript = false;
						
						return;
					case "waitclick" :
						return;
					case "initsavefile" :
						anInitSavefile();
						return;
					case "setdurtime" :
						trace("S-setdurtime!!!!!");
						ansetdurtime();
						ScrI++;
						anIscript(arrS,ScrI);
						return;
					default :
						trace(sstag + "in script");
						showtrace("in script "+txttemp);
						ScrI++;
						anIscript(arrS,ScrI);

						return;
				}

			}
			else
			{
				trace("S文字"+arrS[i]+"//");
				SaeDialog.Dialog(arrS[i],durtime);
			}
		}
		//////////////////////////txtx
		function writePlaybackArr(txt:String)
		{
			//加入回放数组
			SaePlayback.write(txt);
		}

		//////////////////////////////////////////获得cg
		function anGETCG(scenario:String )
		{
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			scenario = trimspace(scenario);

			var ci = cgXML.cgpanel.elements(scenario).childIndex();
			if (ci < 0)
			{
				trace("CG  ERROR");
				showtrace ("CG not found-[getcg]");
				return;
			}
			if(cgXML.cgpanel.children()[ci]. @ show == "true")
			{
				trace("已经获得了");
				return;
			}
			mcgetcg.play();
			cgXML.cgpanel.children()[ci]. @ show = "true";
			/////////////
			SaeCg.getCG(ci,cgXML);
			//////////////////////////file
			var file = FileP.resolvePath("Documents/cg.xml");
			var stream:FileStream = new FileStream  ;
			stream.open(file,FileMode.WRITE);
			stream.addEventListener(Event.COMPLETE,savecompleteHandler);
			stream.writeUTFBytes(cgXML.toString());
			stream.close();
			trace("CG  xmlsave");
			////////////////////file
		}
		/////显示cg
		function anSHOWCG()
		{
			SaeCg.showCG();
		}

	
		//////////////////////////////////////////////////////////////////////////////////////;

		////////////////////////////////////////////////////////////////
		function anLOAD(scenario:String )
		{
			scenario = trimspace(scenario);
			//var tt = trimspace(scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]")));
			loadSlot(parseInt(scenario));
		}

		//显示文字
		function anTEXT(scenario:String )
		{
			btnNext.visible = true;
			btnNext.x = 0;
			btnNext.y = 0;
			btnwaiting = true;
			waittimerBtn.start();
			linebreak.stop();
			linebreak.visible = false;

			txtlayer.visible = true;
			//var tt = trimspace(scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]")));
			//trace("antxt-scenario-"+scenario);
			scenario=trimspaceFront(scenario);
			scenario=replaceVar(scenario);
			writePlaybackArr(SaeText.showText(scenario));
		}
		
		function anDIALOGADD(scenario:String )
		{
			btnwaiting = true;
			waittimerBtn.start();
			linebreak.stop();
			linebreak.visible = false;

			//var tt = trimspace(scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]")));
			//tt = replaceVar(tt);
			//scenario=trimspaceFront(scenario);
			scenario=replaceVar(scenario);
			SaeDialog.DialogAdd(scenario);
			writePlaybackArr(scenario);
		}

		function anDIALOG(scenario:String )
		{
			btnwaiting = true;
			waittimerBtn.start();
			linebreak.stop();
			linebreak.visible = false;

			
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			//tt = replaceVar(tt);
			scenario=replaceVar(scenario);
			writePlaybackArr(SaeDialog.Dialog(scenario,durtime));
		}
		
		
		//立绘
		function anIMG(scenario:String )
		{
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			scenario = replaceVar(scenario);
			var ArrT = scenario.split("|");//ENGVER
			var i = ArrT.length;
			var strLayer = trimspace (ArrT[3]);
			var ci =  initXML.Layer.child(strLayer).childIndex();
			var dur=durtime;
			
			if(ArrT.length>4)
			{	
				dur=parseInt(ArrT[4])/1000;				
			}
						
			craArray[ci].showImg(trimspace(ArrT[0]),ArrT[1],ArrT[2],dur);
		
		}
		//IMGloadError
		function IMGloadError(event:Event):void {
		   trace("ioErrorHandler: " + event);
		   showtrace("LOAD error"+event.toString()+event.currentTarget .toString());
		}
		

		//立绘加载完成，clearimg，文字auto，wait结束
		function goNext(event:Event)
		{
			
			trace("goNext Sae xzxzxzzxzx"+gameStart+loadtxt+waiting+asking);
			if (! gameStart || ! loadtxt  )
			{
				trace("没开始，正在加载脚本");//||asking出现选项||waiting正在等待
				return;
			}
			if(arr.length <=0)
			{
				return;
			}
			if (!inscript )
			{	
				trace("auto t");
				ti++;
				analysisscript(ti);
			}else {					
				trace("auto S   ScrI="+ScrI+" arrScrInd= "+arrScrInd);
				ScrI++;
				anIscript(arrScript[arrScrInd],ScrI);
			}
		}


		//清除立绘
		function anCLEARIMG()
		{
			var i = 0;
			for (i = 0; i < craArray.length; i++)
			{
				craArray[i].anCLEARIMG(durtime);
			}
		}
		
		//清除·隐藏对话框
		function anCLR()
		{
			SaeDialog.Clr(durtime);
			btnNext.visible = true;
			btnNext.x = 0;
			btnNext.y = 0;
			
		}
		//隐藏对话框
		function anMSGhide()
		{
			SaeDialog.HideMsg(durtime);
		}
		//显示对话框，保留先前段内容
		function anMSGshow()
		{
			SaeDialog.ShowMsg(durtime);
		}
		
		//显示背景
		function anBG(tt:String)
		{
			var ArrT = tt.split("|");//ENGVER
			trace("ANBG"+tt+"//"+ArrT);
			ArrT[0]=trimspace(replaceVar(ArrT[0]));
			bgdurtime=durtime;
			if(ArrT.length>1)
			{
				bgdurtime=parseInt(ArrT[1])/1000;
			}
			if (ArrT[0]=="clear")
			{
				//清除背景
				
				bgurl = "";
				SaeBg.clearBg(bgdurtime);
			
				//清除背景
			}else{
				bgurl = ArrT[0];
				SaeBg.showBg(bgurl,bgdurtime);
			}
			
		}
		//end显示背景
		

		
		//选项
		function anBTN(index:int ):int
		{
			if (saveTempIndex == -1)
			{
				saveTempIndex = index-1;
				}
			linebreak.play();
			linebreak.visible = true;
			var i = 0;
			var taa = arr[index + i].substring(1,arr[index + i].indexOf(" "));

			while (taa == "btn")
			{
				i++;
				taa = arr[index + i].substring(1,arr[index + i].indexOf(" "));
			}
			
			var ta:String;

			for (var ishowask = 0; ishowask < i; ishowask++)
			{
				var t = arr[index].substring(arr[index].indexOf(" ") + 1,arr[index].indexOf("]"));
				var arrT = t.split("|");//ENGVER
				index++;
				///////////////
				askArray.push(arrT);
				
				var btnask:SaEBtnask =new SaEBtnask (replaceVar(arrT[0]),arrT[4],Tformat);
				
				btnask.x = arrT[1];//
				btnask.y = arrT[2];//
			
				btnask.addEventListener(MouseEvent.CLICK,clickbtn);

				askbtnArray.push(btnask);
				btn.addChild(btnask);
				btnask.alpha = 1;
			}
			
			return index;
		}
		//清除btn和ask
		function anBTNremove()
		{		
			
				saveTempIndex = -1;
			
			linebreak.stop();
			linebreak.visible = false;

			var iv = 0;
			for (iv = 0; iv < askbtnArray.length; iv++)
			{	
				askbtnArray[iv].removeEventListener(MouseEvent.CLICK,clickbtn);
				btn.removeChild(askbtnArray[iv]);
				askbtnArray[iv]=null;
				delete askbtnArray[iv];
			}
						
			askbtnArray = [];
			askArray = [];			
			asking = false;			
		}
		function anASK(index:int ):int
		{
			if (saveTempIndex == -1)
			{
				saveTempIndex = index-1;
				}
			linebreak.play();
			linebreak.visible = true;
			var i = 0;
			var taa = arr[index + i].substring(1,arr[index + i].indexOf(" "));

			while (taa == "ask")
			{
				i++;
				taa = arr[index + i].substring(1,arr[index + i].indexOf(" "));
			}
			
			var ta:String;

			for (var ishowask = 0; ishowask < i; ishowask++)
			{
				asking = true;
				
				var t = arr[index].substring(arr[index].indexOf(" ") + 1,arr[index].indexOf("]"));
				var arrT = t.split("|");//ENGVER
				index++;
				
				askArray.push(arrT);
				
				var btnask:SaEBtnask =new SaEBtnask (replaceVar(arrT[0]),trimspace(replaceVar(arrT[4])),Tformat);
				
				btnask.x = arrT[1];//
				btnask.y = arrT[2];//
			
				btnask.addEventListener(MouseEvent.CLICK,clickbtn);

				askbtnArray.push(btnask);
				btn.addChild(btnask);
				btnask.alpha = 1;
			}
			return index;
		}

		//点击选项
		function clickbtn(event:MouseEvent):void
		{
			if (waiting)
			{
				return;
			}
			stopTimerSkip()
			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			
			btnSOUND();
			var i = 0;
			i = askbtnArray.indexOf(event.currentTarget);
			var labelname =trimspace (replaceVar( askArray[i][3]));
			writePlaybackArr("  →"+askArray[i][0]);
			anBTNremove();
			
			//查找script		
			if (labelname.substring(0,7)=="script:")
			{
				findIscript(labelname.slice(7, labelname.length) );
				return;
			}
			
			
			
			for (var ig=gotoArr.length-1;ig>=0;ig--)
			{
				if (gotoArr[ig][0] == labelname)
				{
					ti = gotoArr[ig][1] + 1;
					analysisscript(ti);
					return;
				}
			}
		}
		//end点击选项


		
		//等待
		function anWait(scenario:String )
		{
			linebreak.stop();
			linebreak.visible = false;
			TweenLite.to(MCwaiting,0.5,{alpha:1});
			MCwaiting.play();
			waiting = true;
			
			//var tt = trimspace(scenario.substring(scenario.indexOf(" ") + 1, scenario.indexOf("]")));
			scenario = trimspace(replaceVar(scenario));
			trace("wait "+parseInt(scenario)+"~"+scenario);
			if(isNaN (parseInt(scenario)))
			{
				//如果wait没有参数
				scenario=durtime;
			}
			

			waittimer = new Timer(parseInt(scenario),1);
			waittimer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			waittimer.start();
			//trace("WWWWWWWWWWWait");
		}

		//跳转到其他脚本文件
		function anCALL(scenario:String )
		{
			ScrI = 0;
			arrScrInd = -1;
			inscript = false;			
			lastti = ti;
			lastScenario = readScenario;
			//记录跳转前段脚本位置
			loadtxt = false;//读取期间禁止点击
			//
			//var tt=trimspace(scenario .substring(scenario .indexOf(" ") + 1,scenario .indexOf("]")));
			
			var ArrT = scenario.split("|");//ENGVER
			readScenario = trimspace(replaceVar( ArrT [0]));// 脚本文件
			trace(("CALL readScenario==" + readScenario));
			req = new URLRequest(("scenario/" + readScenario));//加载路径
			loader = new URLLoader  ;
			loader.load(req);
			loader.addEventListener(Event.COMPLETE, TXTcompleteHandler);
			if (ArrT.length > 1) 
			{
				//如果包含跳转标签
				calllabel = trimspace(ArrT[1]);
				trace("calllabel= " + calllabel);
			}else{
				ti = 0;
			}
			trace("CALL=lastti" + lastti+" lastScenario="+lastScenario);
		}

		//返回跳转前脚本
		function anReturn()
		{
			loadtxt = false;
			
			if(readScenario!=lastScenario)
			{
				readScenario = lastScenario;
			
				req = new URLRequest(("scenario/" + readScenario));//加载路径
				loader = new URLLoader  ;
				loader.load(req);
				loader.addEventListener(Event.COMPLETE, TXTcompleteHandler);
				calllabel = "";
				ti = lastti+1;
				trace("return=ti" + lastti);
			}else{
				
				showtrace("return error");
			}
		}

	

		//按钮音效
		function btnSOUND()
		{
			if(btnsoundurl!="")
			{
				btnsnd = new Sound  ;
				btnsnd.load(new URLRequest("sound/" +btnsoundurl));
				btnsndchannel = btnsnd.play();
			}
		}

		//音效
		function anSOUND(scenario:String )
		{
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			scenario = trimspace(replaceVar(scenario));
			snd = new Sound  ;
			snd.load(new URLRequest(("sound/" + scenario)));
			sndchannel = snd.play();

			return;
		}

		//背景音乐
		function anBGM(scenario:String)
		{
				
			try
			{
				//关闭之前的bgm
				bgmchannel.stop();
				soundBGM.close();
			}
			catch (myError:Error)
			{
				trace("~~~~");
			}
			
			scenario = trimspace(replaceVar(scenario));
			if (scenario == "bgmstop")
			{
				trace ("bgmstop");
				bgmurl = "";
				return;
			}
			trace("播放1"+bgmurl);
			if(bgmurl == scenario)
			{
				return;			//如果和正在播放的相同							
			}
			
			bgmurl = scenario;		

			bgm = new URLRequest("sound/" + scenario);
			soundBGM = new Sound  ;
		trace("播放"+bgm);
			soundBGM.load(bgm);
			bgmchannel = soundBGM.play();
			if(BGtransform!=null){
				bgmchannel.soundTransform=BGtransform;
			}
			bgmchannel.addEventListener(Event.SOUND_COMPLETE,soundCompleteHandler);

			return;

		}

			//变量赋值
		function anEVAL(scenario:String )
		{
			
			var pattern:RegExp =/[|]/g;
			scenario=scenario.replace(pattern, "");
			

			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			var ArrT;
			var operator:String;
			if(scenario.indexOf("=")>0)
			{
				 ArrT = scenario.split("=");
				operator="=";
			}else if(scenario.indexOf("+")>0)
			{
				 ArrT = scenario.split("+");
				operator="+";
			}else if(scenario.indexOf("-")>0)
			{
				 ArrT = scenario.split("-");
				operator="-";
			}
			trace("anEVAL  1  "+ArrT[0]+"-"+ArrT[1]);
			ArrT[0]=trimspace(replaceprefix(ArrT[0]));
			//ArrT[0].substring((ArrT[0].indexOf("@") + 1),ArrT[0].indexOf(" ",ArrT[0].indexOf("@") + 1));
			//trace(scenario+"///"+st);			
			ArrT[1]=trimspace(replaceVar(ArrT[1]));//允许赋值为变量
			trace("ArrT[1]= "+ArrT[1]);
			var v ;//= evallist.elements(st);
			var ci;// = evallist.elements(st).childIndex();
			
			var found=false;
			var i=0;
			while (i<sevallist.children().length() )
			{
				//遍历静态变量列表
				if(sevallist.children()[i].name()==ArrT[0])
				{
					found=true;
					v = sevallist.elements(ArrT[0]);
					ci= sevallist.elements(ArrT[0]).childIndex();
					sevallist.children()[ci] =analysiseval(v,operator,ArrT[1]);//更新变量值
					
					//////////////////////////file写入存档

					var file = FileP.resolvePath("Documents/staticvar.xml");

					var stream:FileStream = new FileStream  ;
					stream.open(file,FileMode.WRITE);

					stream.addEventListener(Event.COMPLETE,savecompleteHandler);
					stream.writeUTFBytes("<sv>" + sevallist.toString()+ "</sv>");
					//stream.writeUTFBytes(sevallist.toString());
					stream.close();
					trace("static  xmlsave");
					////////////////////file
					break;
				}
				i++;
			}

			i=0;
			while (i<evallist.children().length())
			{
				//遍历变量列表
				if(evallist.children()[i].name()==ArrT[0])
				{
					found=true;
					v = evallist.elements(ArrT[0]);
					ci= evallist.elements(ArrT[0]).childIndex();
					evallist.children()[ci] =analysiseval(v,operator,ArrT[1]);//更新变量值
					break;
				}
				i++;
			}
			i=0;
			
			if(!found)
			{
				//变量不存在，建立临时变量
				var t="<"+ArrT[0]+">"+ArrT[1]+"</"+ArrT[0]+">";
				if(tempevallist==null)
				{					
					t="<temp><temp>"+t+"</temp></temp>";
					var tx:XML = new XML(t);
					tempevallist=tx.temp;    
					trace("tempppp"+tempevallist);
				}else if(tempevallist.children().length()==0){
					
					t="<temp><temp>"+t+"</temp></temp>";
					var tx2:XML = new XML(t);
					
					tempevallist=tx2.temp;    
					trace("2tempppp"+tempevallist);
				}else{
					while (i<=tempevallist.children().length())
					{
						//增加
						trace("tempppp---"+tempevallist);
						
						if(i==tempevallist.children().length())
						{
							var txmls:XML = new XML(t);
							
							tempevallist.prependChild(txmls);    
							trace("tempppp-add-"+tempevallist);
							return;;
						}
						if(tempevallist.children()[i].name()==ArrT[0])
						{
							//更新变量值
							v = tempevallist.elements(ArrT[0]);
							ci= tempevallist.elements(ArrT[0]).childIndex();
							tempevallist.children()[ci] =analysiseval(v,operator,ArrT[1]);
							trace("eval-tempevallist-"+i);
							return;;
						}
						
						i++;
					}
					
				}
			}
			
			trace("evalll"+ArrT[1]);
			
			return;
		}


		function analysiseval(st0:String ,st1:String,st2:String)
		{

			if( st1=="=" && (isNaN (parseInt(st0))||isNaN (parseInt(st2))))
			{
				trace("string--"+evallist);
				return st2.toString();
			}
			if( st1=="+" &&( isNaN (parseInt(st0))||isNaN (parseInt(st2))))
			{
				trace("string++"+evallist);
				st0+=st2.toString();
				return st0;
			}
			//||isNaN (parseInt(v)))
			var v=st0;
			switch (st1)
			{
				case "+" :
					trace(" +");
					v = parseInt(v) + parseInt(st2);
					break;
				case "-" :
					trace("-");
					v = parseInt(v) - parseInt(st2);
					break;
				case "=" :
					trace(" =");
					v = parseInt(st2);
					break;
				default :
					trace("some other ");
			}
			return  parseInt(v);
		}

		

		//判断
		function anIF(scenario:String ,index:int):int
		{
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			//tt = replaceVar(tt);
			scenario =replaceVar(scenario);
			trace("1IFFFFFFFF"+scenario);
			scenario=replacespace(scenario);
			trace("2IFFFFFFFF"+scenario);
			if (analysisIF.analysis(scenario))
			{
				return index+1;
			}
			else
			{
				trace("false!");
				/////判断错误
				var i = index + 1;
				
				while (replacespace(arr[i]) != "[endif]" && (i < arr.length))
				{
					trace(i+"⊕"+arr[i] +"⊕");
					i++;
				}
				index = i + 1;
				return index;
			
			}
		}
		function aninscriptIF(arrS:Array ,scenario:String ,index:int):int
		{
			//var tt = scenario.substring(scenario.indexOf(" ") + 1,scenario.indexOf("]"));
			//tt = replaceVar(tt);
			scenario = replaceVar(scenario);
			trace("1sIFFFFFFFF"+scenario);
			scenario=replacespace(scenario);
			trace("2sIFFFFFFFF"+scenario);
			if (analysisIF.analysis(scenario))
			{
				trace("yesssssssssss///");
				
				return index+1;
			}
			else
			{
				trace("false!");
				/////判断错误
				var i = index + 1;
				
				while (arrS[i] != "[end if]" && (i < arrS.length))
				{
					trace(i+"☆"+arrS[i] +"☆");
					i++;
				}
				index = i + 1;
				return index;
			
			}
		}

		//跳转
		function anGOTO(scenario:String, index:int):int
		{
			scenario=trimspace (replaceVar(scenario));
			trace("GOTO-"+scenario);
			//如果没找到,则返回当前序号index
			for each (var item in gotoArr)
			{				
				if (item[0] == scenario)
				{
					trace("gooo!!item[0]" + item);	
					index= item[1];
					trace("gooo!!" + index);					
					//showtrace("gooo!!" + index);					
					return index;
				}
			}
			showtrace("goto label not found");
			return index+1; 
		}
		

		//设置淡入淡出时间 倍率
		function ansetdurtime()
		{
			var sp=parseInt(sevallist.elements("speed"));
			//储存在静态变量存档中
			trace("ansetdurtime"+sevallist.elements("speed"));
			if(!isNaN(sp))
			{
				durtime=parseInt(initXML.durtime)*sp/10000;
			}
			trace("ansetdurtime-sp-"+sp+"//"+durtime);
		}

		//////////////////////////////////////////////////
		//替换变量
		function replaceVar(str:String):String
		{	
			trace("replaceVar--str="+str);
			var strT:String;
			var t:String;
			var sti = 0;
			var edi = 0;

			var tlist=sevallist+evallist;
			if(tempevallist!=null)
			{
				//如果包含临时变量
				tlist+=tempevallist;
			}

			while (str.indexOf("@",sti) >= 0 && str.indexOf(" ",edi+1) > 0)
			{
				
				//遍历 文字中包含的所有变量
				sti = str.indexOf("@",sti+1);
				edi = str.indexOf(" ",sti +1);
				strT = str.substring((sti + 1),edi);
				trace("sti/edi="+sti+"   "+edi+"="+strT);
				sti++;
				//strT=replaceprefix(strT);
				
				//变量名称
				t = "@" + strT + " ";
				trace("replaceVar   "+edi+"/"+t);
				////////////////////////////////////////////////////////////////////
				var haselement=false;
				var i=0;
				while (i<tlist.children().length() &&i>=0 )
				{
					if(tlist.children()[i].name()==strT)
					{
						str = str.replace(t,tlist.elements(strT));
						//替换，跳出循环
						trace("replaceVar  ok! "+str);
						i=-2;
						haselement=true;
					}
					i++;
				}
				if(!haselement)
				{
					//没有匹配,不替换
					trace("没有匹配,不替换");
					if(gamedebug)
					{
						SaeDebug.write("»»» replace error"+str);
					}
				}
			}
			
			return str;
		}
		///end替换变量

		//替换变量后，去除多余空格replacespace
		function replacespace(str:String):String
		{
			var pattern:RegExp =/ /g;
			str=str.replace(pattern, "");

				return str;
			
		}
		
		//去除变量名前缀后缀
		function replaceprefix(str:String,...separater):String
		{
			var Strprefix="@";
			var	Strsuffix=" "; 
			if(separater.length==2)
			{
				Strprefix=separater[0];
				Strsuffix=separater[1]; 
			}
			if(str.indexOf(Strprefix)>=0 &&str.indexOf(Strsuffix,str.indexOf(Strprefix) + 1)>0)
			{
				str=str.substring((str.indexOf(Strprefix) + 1),str.indexOf(Strsuffix,str.indexOf(Strprefix) + 1));
			}
			return str;
		}
		
		
		//去除首尾空格
		function trimspace(str:String):String
		{
			var pattern:RegExp =/^ +/;
			str=str.replace(pattern, "");
			 pattern =/ +$/;
			str=str.replace(pattern, "");	
			 pattern =/^\t+/;
			str=str.replace(pattern, "");	
			//trace(str.replace(pattern, "@@@"));	
			return str;// trimBack(trimFront(str," ")," ");
		}

		function trimspaceFront(str:String):String
		{
			//char = stringToCharacter(char);			
			//while (str.charAt(0) == char && str.length>0)
			//{
			//	str = trimFront(str.substring(1),char);
			//}
			var pattern:RegExp =/^ +/;
			str=str.replace(pattern, "");
			return str;
		}

		/////////////////////////////////////////////////////////////////////


		//点击对话框
		function clickNext(event:MouseEvent):void
		{
			stopTimerSkip();//停止自动播放

			if (! gameStart || ! loadtxt ||waiting|| asking)
			{
				//没开始，正在加载脚本，正在等待，出现选项
				return;
			}
			
			if (! btnwaiting)
			{	
				//点击间隔
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			
			linebreak.stop();
			linebreak.visible = false;
			//隐藏点击提示

			if (!inscript )
			{
				ti++;
				if (ti >= arr.length)
				{
					ti = 0;
				}
				analysisscript(ti);
			}else {	
				ScrI++;
				anIscript(arrScript[arrScrInd],ScrI);
			}			

		}
		//end点击对话框

		function stageInit()
		{

		trace(" stage Init");
			ScrI = 0;
			arrScrInd = -1;
			inscript = false;
				
			stopTimerSkip();//停止自动播放
			waiting = false;//等待
			
			waittimer.reset();
			MCwaiting.stop();
			MCwaiting.alpha=0;
			//等待
			tempevallist=new XMLList ;

			
			
			btnNext.visible = true;
			btnNext.x = 0;
			btnNext.y = 0;
			trace("saeINIT--");
			SaeDialog.init();
			SaeText.init();
			SaeBg.init();
			SaePlayback.init();
			
			var i = 0;
			for (i = 0; i < craArray.length; i++)
			{
				craArray[i].anCLEARIMG(durtime);
			}
			var iv = 0;
			for (iv = 0; iv < askbtnArray.length; iv++)
			{
				btn.removeChild(askbtnArray[iv]);
			}
	
			askArray = [];
			askbtnArray = [];
			asking = false;

		}

		//显示提示
		function showtrace(str:String)
		{
			SaeTrace.showText(replaceVar(str));
		}

	
		/////////////////////////

		///////////////////////////////////////////////////////////菜单
		function bgmvolume(v:Number ):void
		{
			if(bgmchannel!=null){
			
			BGtransform = bgmchannel.soundTransform;
			BGtransform.volume = v;
           		bgmchannel.soundTransform = BGtransform;
			//TweenLite.to(BGtransform, 2, {volume:v});
			}
		}

		function clickShowsys(event:MouseEvent):void
		{
			stopTimerSkip();//停止自动播放

			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			
			//显示收回菜单栏
			if (btnSystem.x >= 700)
			{
				TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x2)});
			}
			else
			{
				TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
			}

		}


		function msgBack(event:Event):void
		{
			trace("--MSGB"+askmsg+"///"+event.type);
			switch (event.type)
			{
				case "clickBack" :
					
					trace("clickBack");
					stageInit();//清除按钮临时变量，清除等待状态
					//anCALL( initXML.Sui.imgreserve1. @ goto);
					/////////call;
					loadtxt = false;
					readScenario = initXML.Sui.imgreserve1. @ goto;
					ti = 0;//loadXML.playingat.readline;
					req = new URLRequest("scenario/" + readScenario);//加载路径
					loader = new URLLoader  ;
					loader.load(req);
					loader.addEventListener(Event.COMPLETE,TXTcompleteHandler);
				
					///////////call
					return;
				case "clickReplay" :
					stageInit();//清除按钮临时变量，清除等待状态
					//anCALL( initXML.Sui.imgreserve2. @ goto);
					
					///////////call
					loadtxt = false;
					readScenario = initXML.Sui.imgreserve2. @ goto;
					ti = 0;
					trace(((ti + "load```CALL") + readScenario));
					req = new URLRequest(("scenario/" + readScenario));//加载路径
					loader = new URLLoader  ;
					loader.load(req);
					loader.addEventListener(Event.COMPLETE,TXTcompleteHandler);
					///////////call;
					return;
				case "clickLoad" :
					trace("clickLoad");
					loadSlot(loadindex );
					return;
				case "keyback" :
					
					NativeApplication.nativeApplication.exit();
					return;
				default :
					trace((askmsg + "   xxx"));
					break;
			}
		}


		function clickSkip(event:MouseEvent):void
		{
			//自动播放
			if ((readScenario == firstScenario))
			{
				//trace("readScenario===" + readScenario + "//init=" + initXML.playingat.scenario);
				showtrace("you can not use skip here");
				return;
			}
			if (! gameStart || ! loadtxt||inscript)
			{
				return;
			}
			btnSOUND();
			onskip=true;
			mcskip.visible=true;
			skiptimer.start();
			TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
			
		}

		function clickPlayback(event:MouseEvent):void
		{
			//显示回放
			stopTimerSkip();

			btnSOUND();
			trace("clickPlayback");
			SaePlayback.showText ();

			TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
		}

		function clickReplay(event:MouseEvent):void
		{
			//跳转到replay设定的脚本
			stopTimerSkip();

//			if (readScenario == firstScenario)
//			{
//				showtrace("you cannot use this");
//				return;
//			}
			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			btnSOUND();
			askmsg = "clickReplay";
			SaeMsgbox.showmsg (askmsg, initXML.Sui.imgreserve2. @ txt);

			TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});

		}
		function clickBack(event:MouseEvent):void
		{
			//跳转到back设定脚本
			stopTimerSkip();

			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			btnSOUND();
			askmsg = "clickBack";
			SaeMsgbox.showmsg (askmsg, initXML.Sui.imgreserve1. @ txt);
			TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
		}
		function clickSaveBtn(event:MouseEvent):void
		{
			//存档''''
			savestate = true;
			stopTimerSkip();
			SaeSavepanel.showslot(true, saveXML);//(true,evallist,playingat);
			if (readScenario == firstScenario || !saveable||inscript)
			{
				showtrace("you cannot save here");
//				return;
			}
			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			btnSOUND();
//			Save(StrSave);
//			TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
		}
	

		
		function saveSlot(index:int)
		{
			if (saveTempIndex > 0)
				{
					playingat.readline = saveTempIndex;
				}else {
					playingat.readline = ti;
				}
				
				playingat.scenario = readScenario;
				playingat.bgm = bgmurl;
				playingat.bg = bgurl;
				playingat.lastreadline=lastti;
				playingat.lastScenario=lastScenario; 

				saveXML.children()[index].exist = true;
				saveXML.children()[index].img = bgurl;
				saveXML.children()[index].txt=(1+new Date().month)+"/"+new Date().date+"-"+new Date().hours+":"+new Date().minutes+":"+new Date().seconds;
				if (index == 0) {
					saveXML.children()[index].txt+="\n AUTO"
				}
				saveXML.children()[index].svar=evallist;
				saveXML.children()[index].playingat=playingat;
				trace("clickslot3"+saveXML);

				var file = FileP.resolvePath( "Documents/save.xml");
				var stream:FileStream = new FileStream  ;
				stream.open(file,FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();
				stream.open(file,FileMode.WRITE);
				stream.addEventListener(Event.COMPLETE,savecompleteHandler);
				stream.writeUTFBytes(saveXML.toString());
				stream.close();
				trace("init save  xmlsave");
				
				
				SaeSavepanel.refreshslot (saveXML);
//
		}

		function savecompleteHandler(event:Event):void
		{
			trace("stream=======================ok");
			
		}

		var savestate = true;//save或load状态
		
		function clickLoadBtn(event:MouseEvent):void
		{
			//读取设定的存档文件
			stopTimerSkip();

			if (! btnwaiting)
			{
				btnwaiting = true;
				waittimerBtn.start();
			}
			else
			{
				return;
			}
			btnSOUND();
			savestate = false;
			SaeSavepanel.showslot(false , saveXML);//(true,evallist,playingat);
			//askmsg = "clickLoad";
			//SaeMsgbox.showmsg (askmsg, initXML.Sui.imgload. @ txt);
			//TweenLite.to(btnSystem,durtime,{x:parseInt(initXML.Sui.imgsystem. @ x1)});
		}
		function loadSlot(index:int)
		{
			loadindex = index;
			var file = FileP.resolvePath( "Documents/save.xml");
			if (! file.exists)
			{
				showtrace("file not exists");
				return;
			}
			stageInit();
			savefileStream = new FileStream();
			savefileStream.addEventListener(Event.COMPLETE, savefileLoaded);
			savefileStream.openAsync(file, FileMode.READ);

			trace(file.nativePath);//ok
			loadtxt = false;	
		}

		function savefileLoaded(event:Event):void
		{
			
			saveXML = new XML  ;
			saveXML = XML(savefileStream.readUTFBytes(savefileStream.bytesAvailable));
			savefileStream.close();
			
			SaeSavepanel.savelayer.visible=false;
			SaeSavepanel.savelayer.y=900;
			
			//loadXML = new XML  ;
			loadXML = saveXML.children()[loadindex ];
			savefileStream.close();

			trace("读取存档2"+loadXML);

			//////////变量;
			var i=0;
			trace("//////load/////"+evallist);
			while (i<loadXML.svar.children().length() )
			{	
				var ci= evallist.elements(loadXML.svar.children()[i].name()).childIndex()
				evallist.children()[ci]=loadXML.svar.children()[i];
				i++;
			}
			trace("//////load/////"+evallist);
			//evallist = loadXML.svar;
			//////////变量

			/////////call;
			loadtxt = false;
			readScenario = loadXML.playingat.scenario;
			ti = loadXML.playingat.readline;
			lastti =loadXML.playingat.lastreadline;
			lastScenario = loadXML.playingat.lastScenario;
			ti++;
			bgurl = loadXML.playingat.bg;

			if (bgurl != "")
			{
				trace("load-bgurl");
				anBG(bgurl);
			}
			else
			{
				anBG("clear");
			}

			//bgmurl = loadXML.playingat.bgm;
			if (loadXML.playingat.bgm != "")
			{
				trace("有-old="+bgmurl+" new= "+loadXML.playingat.bgm);
				anBGM(loadXML.playingat.bgm);
			}
			else
			{
				anBGM("bgmstop");
			}

			req = new URLRequest(("scenario/" + readScenario));//加载路径
			loader = new URLLoader  ;
			loader.load(req);
			loader.addEventListener(Event.COMPLETE,TXTcompleteHandler);

		}
		//////////////////////////////////////////存档

	}

}