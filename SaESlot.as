package
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.text.*;

	
	import flash.display.Sprite;
	import flash.display.*;


	public class SaESlot  extends Sprite
	{
//		var msglayer:Sprite =new Sprite ();
		var bgLoader = new Loader  ;

		public var txt:TextField = new TextField();
		public var nodename:String= new String;
		

		
		//创建对话框
		public function SaESlot(bgurl:String  ,PosImg:String,str:String,Tformat:TextFormat)
		{			
			nodename=str;
			var slotPos = PosImg.split(",");//背景，确定，取消按钮位置x,y,x,y,w,h
			var bgURLReq:URLRequest = new URLRequest(bgurl);			
			bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,BGloadComplete);
			bgLoader.load(bgURLReq);
			
			bgLoader.x=parseInt(slotPos[0]);
			bgLoader.y=parseInt(slotPos[1]);
			addChild(bgLoader);
			//bgLoader.scaleX=txtScale;
			//bgLoader.scaleY=txtScale;	
			
			
//			btnYLoader.addEventListener(MouseEvent.CLICK,clickyes);

			
//			var fontArray:Array = Font.enumerateFonts(false);
//			Tformat.font = fontArray[0].fontName;
			Tformat.align="center";
			Tformat.size = 20;
		
			txt.textColor =uint("0xff3399");
//			txt.autoSize =TextFieldAutoSize.Left;		
			if( Font.enumerateFonts(false).length>0)
			{
			txt.embedFonts=true;
			}
			txt.selectable =false;
			txt.multiline=true;
			txt.defaultTextFormat = Tformat;
			txt.setTextFormat (Tformat);

			txt.x=parseInt(slotPos[2]);
			txt.y=parseInt(slotPos[3]);
			txt.text=str;
			
			addChild(txt);
			trace("SLOT "+bgLoader.x+"/"+txt.x+"/"+txt.text);
					
//			addChild(msglayer);
			
		}
		public function showmsg(type:String,str:String )
		{
//			txt.scaleX=1;
//			txt.scaleY=1;	
//			msgtype=type;
//			txt.htmlText =str;
//			msglayer.visible=true;
//			msglayer.y=0;
//			msglayer.x=0;

		}
		
		function clickyes(event:Event)
		{
//				msglayer.visible=false;
//				msglayer.y=900;
//				
//				switch (msgtype)
//				{
//					case "clickBack" :
//						msglayer.dispatchEvent(evtB);
//						trace("MSG--B");
//						return;
//					case "clickReplay" :
//						trace("MSG--R");
//						msglayer.dispatchEvent(evtR);
//						return;
//					case "clickLoad" :
//						trace("MSG--L");
//						msglayer.dispatchEvent(evtL);
//						return;
//					case "keyback" :
//						trace("MSG--K");
//						msglayer.dispatchEvent(evtK);
//						return;
//					default :
//						break;
//				}
//			

		}
		function clickno(event:Event)
		{
//			msglayer.visible=false;
//			msglayer.y=900;
		}
		function BGloadComplete(event:Event)
		{
//			txtcenterX+=event.currentTarget.width/2;
//			txt.x=txtcenterX;
		}

	}

}