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
			var slotPos = PosImg.split(",");//x,y,x,y,w,sc
			var bgURLReq:URLRequest = new URLRequest(bgurl);			
			bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,BGloadComplete);
			bgLoader.load(bgURLReq);
			
			bgLoader.x=parseInt(slotPos[0]);
			bgLoader.y=parseInt(slotPos[1]);
			bgLoader.scaleX =parseInt(slotPos[5]);
			bgLoader.scaleY =parseInt(slotPos[5]);
			
			addChild(bgLoader);

			Tformat.align="center";
			Tformat.size = 20;
		
			txt.textColor =uint("0xff3399");
		
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
			txt.width=parseInt(slotPos[4]);
			txt.text=str;
			
			addChild(txt);
			trace("SLOT "+bgLoader.x+"/"+txt.x+"/"+txt.text);
					
//			addChild(msglayer);
			
		}
		public function slotrefresh(savetxt:String,saveurl:String )
		{
//			
			trace("slot refresh"+saveurl);
			//bgLoader.load( new URLRequest(saveurl));//新图片
			txt.text=savetxt;

		}
		
		function clickyes(event:Event)
		{

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