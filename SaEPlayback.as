package
{
	import flash.events.*;
	import flash.text.*;
	import flash.display.Sprite;
	
	
	public class SaEPlayback  extends Sprite
	{
		
		var txt:TextField = new TextField();
		var _txtlayer:Sprite = new Sprite();
		var playbackArray:Array = new Array  ;//回放记录
		var Arraylength:int = 8;//回放记录


		public function SaEPlayback(colorT:String,colorB:String,Tformat:TextFormat,arraylength:int)
		{			
			//文字样式

			trace("new saePB"+Tformat+"//"+Tformat.font);
			var fontArray:Array = Font.enumerateFonts(false);
			Arraylength=arraylength;
			//Tformat.size = 36;
			txt.autoSize =TextFieldAutoSize.LEFT;			
			txt.embedFonts=true;
			txt.selectable =false;			
			txt.defaultTextFormat = Tformat;
			txt.wordWrap=true;
			txt.multiline=true;
			txt.x=20;
			txt.y=20;
			txt.width=820;
			txt.htmlText = "";
			txt.textColor =uint("0x"+colorT);//ffcc66;
			_txtlayer.x = 960;
			_txtlayer.y = 640;
			_txtlayer.visible=false;
			//背景色
			var square:Sprite = new Sprite();
			square.graphics.beginFill(uint("0x"+colorB),0.8);
			square.graphics.drawRect(0, 0, 960, 640);
			
			addChild(_txtlayer);	
			_txtlayer.addChild(square);
			_txtlayer.addChild(txt);
			_txtlayer.addEventListener(MouseEvent.CLICK,closePlayback);		
		}

		//读取存档和跳转到预设脚本时清空记录
		public function init()
		{
			_txtlayer.visible=false;
			txt.htmlText = "";
			playbackArray=[];	
		}
		//写入记录
		public function write(tt:String) 
		{
			trace(tt);
			//加入回放数组textHeight : Number 
			if(playbackArray.length>Arraylength)
			{
				playbackArray.shift();
			}
			playbackArray.push("  "+tt);//+"<br>"
			  txt.htmlText="";
			 for each (var item in playbackArray)
			{
				txt.htmlText+=item;
			}
		}

		public function showText() 
		{
			trace("SPB-showText");
			_txtlayer.visible=true;
			_txtlayer.y=0;
			_txtlayer.x=0;
		}
		function closePlayback(event:MouseEvent):void
		{
			_txtlayer.y=-700;
			_txtlayer.visible=false;
		}

	}

}