package
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.text.*;

	
	import flash.display.Sprite;
	import flash.display.*;

	//import com.greensock.*;
	//import com.greensock.plugins.*;



	public class SaECg  extends Sprite
	{
		
		var txt:TextField = new TextField();
		var cglayer:Sprite =new Sprite ();
		var cgs:Sprite =new Sprite ();
		var cgArray:Array =new Array ;
		var cgPage:int = 0;
		var cgXML:XML=new XML;
		
		//public var evtB:Event = new Event("clickBack",true);
//		public var evtR:Event = new Event("clickReplay",true);
//		public var evtL:Event = new Event("clickLoad",true);
//		public var evtK:Event = new Event("keyback",true);
		
		//创建cg欣赏面板
		public function SaECg(btnurl:String ,pos:String,colorT:String,colorTB:String,colorBG:String,Tformat:TextFormat)
		{			
			cglayer.visible = false;
			cglayer.y = 1000;
			addChild(cglayer);
			
			var ArrUrl = btnurl.split(",");//关闭，下页上页按钮图片
			var posBtn = pos.split(",");//关闭，下页上页按钮坐标，文字坐标
			trace("saeCG "+ArrUrl);
			trace("saeCG "+posBtn);
			
			//关闭按钮
			var exitURLReq:URLRequest = new URLRequest(ArrUrl[0]);
			var exitLoader = new Loader  ;
			exitLoader.load(exitURLReq);
			cglayer.addChild(exitLoader);
			exitLoader.x=parseInt(posBtn[0]);
			exitLoader.y=parseInt(posBtn[1]);
			exitLoader.addEventListener(MouseEvent.CLICK,clickcgExit);
			//btnYLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,ASKloadComplete);			
						
			//下一页
			var nextURLReq:URLRequest = new URLRequest(ArrUrl[1]);
			var nextLoader = new Loader  ;
			nextLoader.load(nextURLReq);
			cglayer.addChild(nextLoader);
			nextLoader.x=parseInt(posBtn[2]);
			nextLoader.y=parseInt(posBtn[3]);
			nextLoader.addEventListener(MouseEvent.CLICK,clickcgNext);

			//上一页	
			var prvURLReq:URLRequest = new URLRequest(ArrUrl[2]);
			var prvLoader = new Loader  ;
			prvLoader.load(prvURLReq);
			cglayer.addChild(prvLoader);
			prvLoader.x=parseInt(posBtn[4]);
			prvLoader.y=parseInt(posBtn[5]);
			prvLoader.addEventListener(MouseEvent.CLICK,clickcgPrv);
			
			
			
			trace("new SaEMagbox"+Tformat+"//"+Tformat.font);
			//文字
			var fontArray:Array = Font.enumerateFonts(false);
			trace("new SaEMagbox saefontArray"+fontArray);
			Tformat.font = fontArray[0].fontName;
			Tformat.size = 26;
			addChild(txt);			
			txt.textColor =uint("0x"+colorT);
			txt.backgroundColor=uint("0x"+colorTB);
			txt.autoSize =TextFieldAutoSize.LEFT;			
			txt.embedFonts=true;
			txt.selectable =false;
			txt.multiline=true;
			txt.defaultTextFormat = Tformat;
			txt.setTextFormat (Tformat);
			txt.x=parseInt(posBtn[6]);
			txt.y=parseInt(posBtn[7]);
			txt.htmlText="WWWxxx123[]-=";
			txt.visible=false;
			cglayer.addChild(txt);				
			
			//绘制背景
			var square:Sprite = new Sprite();
			square.graphics.beginFill(uint("0x"+colorBG),0.4);//uint("0x"+colorB)
			square.graphics.drawRect(0, 0, 960, 640);
			cglayer.addChildAt(square,0);
			
			//addChild(cglayer);
			
		}
		
		
		
		//////////////////////读取cg存档
		public function readCGXML(cgxml:XML)
		{
			cgXML =cgxml;
			///////////////////////////////;
			cgArray = [];
			
			//将全部cg添加到列表
			var i = 0;
			for (i = 0; i < cgXML.cgpanel.children().length(); i++)
			{
				var cgLoader:Loader = new Loader  ;
				//cgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,CGloadComplete);
				cgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,CGloadError);
				cgArray.push(cgLoader);

				trace(("cgXMLcgXML--" + cgXML.cgpanel.children()[i]. @ show));
				var cgURLReq:URLRequest = new URLRequest(("ui/" + cgXML.cgpanel.children()[i]. @ img));

				cgLoader.load(cgURLReq);
				
				//4x2排列，已经获得的alpha1，可点击查看大图，未获得的alpha0.1
				cgLoader.scaleX = 0.2;
				cgLoader.scaleY = 0.2;
				cgLoader.x = 70 + (i % 4) * 210;//24+((i%8)%4)*240;
				cgLoader.y = 96 + Math.floor(((i % 8) / 4)) * 240;

				if (cgXML.cgpanel.children()[i]. @ show == "true")
				{
					cgLoader.addEventListener(MouseEvent.CLICK,cgClick);
				}
				else
				{
					cgLoader.alpha = 0.1;
				}
				cglayer.addChildAt(cgArray[i],4);
			}
			//显示页码0
			showcgpage(0);
		}

		//[getcg 名字] 不透明显示，增加点击事件
		public function getCG(ci:int,cgxml:XML)
		{
			cgXML=cgxml;
			trace("saeCG getcg"+ci);
			cgArray[ci].alpha = 1;
			cgArray[ci].addEventListener(MouseEvent.CLICK,cgClick);
		}
		//[showcg]进入cg欣赏画面
		public function showCG()
		{
			cglayer.x = 0;
			cglayer.y = 0;
			cglayer.visible = true;
		}

		//[initsavefile]初始化所有cg和存档
		public function initCG()
		{
			for each (var item in cgArray)
			{
				trace("removeChild<<"+item);
				cglayer.removeChild(item);
			}
		}
		
		//cg界面，显示当前页的8张
		function showcgpage(i:Number)
		{
			for (i = 0; i < cgArray.length; i++)
			{
				if (((i >= cgPage * 8) && i <= ((8 * cgPage) + 7)))
				{
					cgArray[i].visible = true;
					trace("saeCG "+i);
				}
				else
				{
					cgArray[i].visible = false;
				}
			}

		}
		
		
		
		//下页，循环翻页
		function clickcgNext(event:MouseEvent):void
		{
			
			if ((cgPage > Math.floor(cgArray.length / 8) - 1))
			{
				cgPage = 0;
			}
			else
			{
				cgPage++;
			}
			trace(("cgPage++" + cgPage));
			showcgpage(cgPage);
		}
		//关闭cg
		function clickcgExit(event:MouseEvent):void
		{
			cgPage = 0;
			cglayer.visible = false;
			cglayer.y = 1000;
		}
		//上页
		function clickcgPrv(event:MouseEvent):void
		{
			
			if ((cgPage <= 0))
			{
				cgPage = Math.floor(cgArray.length / 8);
			}
			else
			{
				cgPage--;
			}
			trace(("cgPage-- " + cgPage));
			showcgpage(cgPage);
		}

		
		//点击放大图片
		function cgClick(event:MouseEvent):void
		{
			trace(("cgclick" + event.currentTarget));
			//显示文字
			var i  = cgArray.indexOf(event.currentTarget);
			txt.htmlText=cgXML.cgpanel.children()[i]. @ name;
			txt.visible=true;
			

			trace(cgXML.cgpanel.children()[i]. @ name);
			
			//没放大则放大显示，已经放大则缩小回原位
			if (event.currentTarget.scaleX < 0.4)
			{
				event.currentTarget.scaleX = 1;
				event.currentTarget.scaleY = 1;
				event.currentTarget.x = 0;
				event.currentTarget.y = 0;
				//调整深度
				for (var ii = 0; ii < cgArray.length; ii++)
				{
					if (ii != i)
					{
						//trace((ii + "MMMM0"));
						cglayer.setChildIndex(cgArray[ii],4);
					}
				}
			}
			else
			{
				txt.visible = false;
				txt.htmlText="";
				event.currentTarget.scaleX = 0.2;
				event.currentTarget.scaleY = 0.2;
				event.currentTarget.x = 70 + (i % 4) * 210;
				event.currentTarget.y = 96 + Math.floor(((i % 8) / 4)) * 240;
			}
		}


//		function CGloadComplete(event:Event)
//		{
//			trace("CG OK");
//		}
		function CGloadError(event:Event)
		{
			//cgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,CGloadComplete);
			//cgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,CGloadError);
			trace("CG ERROR");
		}
	}

}