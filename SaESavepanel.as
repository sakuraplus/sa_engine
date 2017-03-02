package 
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.text.*;


	import flash.display.Sprite;
	import flash.display.*;
	
	//import flash.filesystem.File;
	//import flash.filesystem.FileMode;
	//import flash.filesystem.FileStream;


	public class SaESavepanel extends Sprite
	{

		var txt:TextField = new TextField  ;
		var savelayer:Sprite = new Sprite  ;
		var msgtype:String;
		var txtwidth = 600;
		var txtcenterX = 400;
		var txtcenterY = 400;
		var firsttime = true;

		
		//var strpos = "100,50,10,10,200,500";//x,y,x,y,w,h
		public var saveloaderArray:Array=new Array;//loader数组
		var savetxtArray:Array = new Array;//loader数组
		
		var saveXML:XML;

		//创建对话框
		public function SaESavepanel(colorB:String,colorT:String,bgurl:String,pos:String,numslot:int,Tformat:TextFormat)
		{
			saveXML = new XML();
			var ArrUrl = bgurl.split(",");//背景//，取消按钮图片
			var bgurl = ArrUrl[0];
//			var btnimg1 = ArrUrl[1];
//			var btnimg2 = ArrUrl[2];

			var PosImg = pos.split(",");//背景x，背景y，按钮x，按钮y，按钮w，按钮h  300,100,320,150,300,400


			var square:Sprite = new Sprite  ;
			square.graphics.beginFill(uint(("0x" + colorB)),0.4);
			square.graphics.drawRect(0,0,960,640);
			square.addEventListener(MouseEvent.CLICK,clickclose);

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
//			var slotPos = strpos.split(",");//背景，确定，取消按钮位置x,y,x,y,w,h
			var slotspaceY:int = parseInt(PosImg[5]) / numslot;			
			var slotheight:int = 0.9 * slotspaceY;
			var slotup:int = 0.05 * slotspaceY;
			var slotwidth:int = slotheight * 2 / 3;
			var txtleft:int = slotup * 5 + slotwidth;
			var txtwidth:int =  parseInt(PosImg[4]) - slotup * 4 - slotwidth;
			var imgscale:int =100* slotheight/640;
			var strtemp = slotup +","+ slotup +","+ txtleft+"," + slotup +","+ txtwidth+","+imgscale;
			for (var i = 0; i < numslot; i++)
			{
				var sstr="EMPTY SLOT";//"NM"+new Date().milliseconds+"MMccc";
				var SaeSlot:SaESlot=new SaESlot("",strtemp ,sstr,Tformat);//''''x,y,x,y,W,sc"20,20,200,20,200" 
				savelayer.addChild(SaeSlot);
				saveloaderArray.push(SaeSlot);
				SaeSlot.x =parseInt( PosImg[2]);
				SaeSlot.y = parseInt(PosImg[3]) + slotspaceY * i ;
				
				trace("save-SaeSlot"+SaeSlot.x+"/"+SaeSlot.y+"//");
				SaeSlot.addEventListener(MouseEvent.CLICK,clickslot);

			}

			
			addChild(savelayer);
			savelayer.visible = false;
			savelayer.x = PosImg[0];
			savelayer.y = PosImg[1];

		}
		public function showslot(save:Boolean,savexml:XML)
		{//(save:Boolean, evallist:XML, playingat:XML)
			savelayer.visible = true;
			savelayer.y = 0;
			savelayer.x = 0;
			if (!firsttime && save)
			{
				//保存则不需要刷新
				return;
			}
			firsttime = false;
				trace("SHOWSAVE"+savexml);
			for (var i = 0; i <  savexml.children().length(); i++)
			{
				refreshslot(savexml);

				if( !save &&savexml.children()[i].exist==false )
				{
					saveloaderArray[i].visible=false;
				}

			}

		}
		public function refreshslot(savexml:XML)
		{//(save:Boolean, evallist:XML, playingat:XML)

			trace("refreshslot"+savexml);
			for (var i = 0; i <  savexml.children().length(); i++)
			{
				if (savexml.children()[i].exist==true)
				{	
					saveloaderArray[i].visible=true;
					if ( savexml.children()[i].txt != saveloaderArray[i].txt.text)
					{
						trace("SHOWMSG"	+savexml.children()[i].txt+"---"+savexml.children()[i].img);
						saveloaderArray[i].slotrefresh(	savexml.children()[i].txt, savexml.children()[i].img);
					}
					
				}

			}

		}


		function clickclose(event:Event)
		{
			savelayer.visible=false;
			savelayer.y=900;
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