package
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.text.*;

	
	import flash.display.Sprite;
	import flash.display.*;


	public class SaEMsgbox  extends Sprite
	{
		
		var txt:TextField = new TextField();
		var msglayer:Sprite =new Sprite ();
		var msgtype:String;
		var txtwidth=600;
		var txtcenterX=400;
		var txtcenterY=400;
		public var evtB:Event = new Event("clickBack",true);
		public var evtR:Event = new Event("clickReplay",true);
		public var evtL:Event = new Event("clickLoad",true);
		public var evtK:Event = new Event("keyback",true);
		
		//创建对话框
		public function SaEMsgbox(colorB:String,colorT:String ,url:String  ,pos:String,Tformat:TextFormat)
		{			
			var ArrUrl = url.split(",");//背景，确定，取消按钮图片
			var bgurl=ArrUrl[0];
			var btnimg1=ArrUrl[1];
			var btnimg2=ArrUrl[2];
			
			var PosImg = pos.split(",");//背景，确定，取消按钮位置

			var square:Sprite = new Sprite();
			square.graphics.beginFill(uint("0x"+colorB),0.4);
			square.graphics.drawRect(0, 0, 960, 640);
			msglayer.addChild(square);
			
			var bgURLReq:URLRequest = new URLRequest(bgurl);
			var bgLoader = new Loader  ;
			bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,BGloadComplete);
			bgLoader.load(bgURLReq);
			msglayer.addChild(bgLoader);
			bgLoader.x=parseInt(PosImg[0]);
			bgLoader.y=parseInt(PosImg[1]);
			txtcenterX	=bgLoader.x;

			var yesURLReq:URLRequest = new URLRequest(btnimg1);
			var btnYLoader = new Loader  ;
			btnYLoader.load(yesURLReq);
			msglayer.addChild(btnYLoader);
			btnYLoader.x=parseInt(PosImg[2]);
			btnYLoader.y=parseInt(PosImg[3]);
			btnYLoader.addEventListener(MouseEvent.CLICK,clickyes);

					
			var noURLReq:URLRequest = new URLRequest(btnimg2);
			var btnNLoader = new Loader  ;
			btnNLoader.load(noURLReq);
			msglayer.addChild(btnNLoader);
			btnNLoader.x=parseInt(PosImg[4]);
			btnNLoader.y=parseInt(PosImg[5]);
			btnNLoader.addEventListener(MouseEvent.CLICK,clickno);
			
			
//			var fontArray:Array = Font.enumerateFonts(false);
//			Tformat.font = fontArray[0].fontName;
			Tformat.align="center";
			//Tformat.size = 30;
			addChild(txt);			
			txt.textColor =uint("0x"+colorT);
			txt.autoSize =TextFieldAutoSize.CENTER;		
			if( Font.enumerateFonts(false).length>0)
			{
				txt.embedFonts=true;
			}
		
			txt.selectable =false;
			txt.multiline=true;
			txt.defaultTextFormat = Tformat;
			txt.setTextFormat (Tformat);
			txt.x=960/2;
			txtcenterY=parseInt(PosImg[6]);
			if (PosImg.length > 7) 
			{
				txtwidth=parseInt(PosImg[7]);
			}

			msglayer.addChild(txt);				
			addChild(msglayer);
			msglayer.visible=false;
			msglayer.y=900;
			
		}
		public function showmsg(type:String,str:String )
		{
			txt.scaleX=1;
			txt.scaleY=1;	
			msgtype=type;
			txt.htmlText =str;
			msglayer.visible=true;
			msglayer.y=0;
			msglayer.x=0;

			txt.y=txtcenterY-txt.height/2;

			if(txt.width>txtwidth)
				{

					var txtScale=txtwidth/txt.width;
					txt.scaleX=txtScale;
					txt.scaleY=txtScale;		
					txt.x=txtcenterX-txt.width/2;					
				}
		}
		
		function clickyes(event:Event)
		{
			msglayer.visible=false;
			msglayer.y=900;
			
			switch (msgtype)
			{
				case "clickBack" :
					msglayer.dispatchEvent(evtB);
					trace("MSG--B");
					return;
				case "clickReplay" :
					trace("MSG--R");
					msglayer.dispatchEvent(evtR);
					return;
				case "clickLoad" :
					trace("MSG--L");
					msglayer.dispatchEvent(evtL);
					return;
				case "keyback" :
					trace("MSG--K");
					msglayer.dispatchEvent(evtK);
					return;
				default :
					break;
			}
		

		}
		function clickno(event:Event)
		{
			msglayer.visible=false;
			msglayer.y=900;
		}
		function BGloadComplete(event:Event)
		{
			txtcenterX+=event.currentTarget.width/2;
			txt.x=txtcenterX;
		}

	}

}