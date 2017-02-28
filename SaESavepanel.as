package 
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.text.*;


	import flash.display.Sprite;
	import flash.display.*;


	public class SaESavepanel extends Sprite
	{

		var txt:TextField = new TextField  ;
		var savelayer:Sprite = new Sprite  ;
		var msgtype:String;
		var txtwidth = 600;
		var txtcenterX = 400;
		var txtcenterY = 400;

		



		public var evtB:Event = new Event("clickBack",true);
		public var evtR:Event = new Event("clickReplay",true);
		public var evtL:Event = new Event("clickLoad",true);
		public var evtK:Event = new Event("keyback",true);

		var strpos = "100,50,10,10,200,500";//x,y,x,y,w,h
		public var saveloaderArray:Array=new Array;//loader数组
		var savetxtArray:Array=new Array;//loader数组

		//创建对话框
		public function SaESavepanel(colorB:String,colorT:String,url:String,pos:String,numslot:int,Tformat:TextFormat)
		{
			var ArrUrl = url.split(",");//背景，确定，取消按钮图片
			var bgurl = ArrUrl[0];
			var btnimg1 = ArrUrl[1];
			var btnimg2 = ArrUrl[2];

			var PosImg = pos.split(",");//背景，确定，取消按钮位置

			var square:Sprite = new Sprite  ;
			square.graphics.beginFill(uint(("0x" + colorB)),0.4);
			square.graphics.drawRect(0,0,960,640);
			savelayer.addChild(square);

			var bgURLReq:URLRequest = new URLRequest(bgurl);
			var bgLoader = new Loader  ;
			bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,BGloadComplete);
			bgLoader.load(bgURLReq);
			savelayer.addChild(bgLoader);
			bgLoader.x = parseInt(PosImg[0]);
			bgLoader.y = parseInt(PosImg[1]);
			txtcenterX = bgLoader.x;

			/////////////////////////
			var slotPos = strpos.split(",");//背景，确定，取消按钮位置x,y,x,y,w,h
			var slotspaceY:int = parseInt(slotPos[5]) / numslot;
			var slotheight:int = 0.9 * slotspaceY;
			var slotup:int = 0.05 * slotspaceY;
			var slotwidth:int = slotheight * 2 / 3;
			var txtleft:int = slotup * 3 + slotwidth;
			for (var i = 0; i < numslot; i++)
			{
				var sstr="NM"+new Date().milliseconds+"MMccc";
				var SaeSlot:SaESlot=new SaESlot(btnimg1,"20,50,100,50"  ,sstr,Tformat);//''''
				savelayer.addChild(SaeSlot);
				saveloaderArray.push(SaeSlot);
				SaeSlot.x =parseInt( slotPos[2]);
				SaeSlot.y = parseInt(slotPos[3]) + slotspaceY * i ;
				
				trace("save-SaeSlot"+SaeSlot.x+"/"+SaeSlot.y+"//"+btnimg1);
//				SaeSlot.addEventListener(MouseEvent.CLICK,clickslot);

			}

			
			addChild(savelayer);
			savelayer.visible = false;
			savelayer.x = PosImg[0];
			savelayer.y = PosImg[1];

		}
		public function showmsg(xml:XML)
		{

			savelayer.visible = true;
			savelayer.y = 0;
			savelayer.x = 0;


		}
		function clickslot(event:Event)
		{
			trace("clickslot1");
			trace(event.currentTarget.parent);
			
			trace(event.currentTarget);
			var i = 0;
			i = saveloaderArray.indexOf(event.currentTarget);
			trace("clickslot2==----"+i);
		}
		
		function BGloadComplete(event:Event)
		{
			txtcenterX +=  event.currentTarget.width / 2;
			txt.x = txtcenterX;
		}

	}

}