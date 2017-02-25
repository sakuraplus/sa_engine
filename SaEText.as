package
{
	import flash.events.*;
	import flash.text.*;
	import flash.display.Sprite;
	


	public class SaEText  extends Sprite
	{
		
		var txt:TextField = new TextField();
		var _txtlayer:Sprite = new Sprite();
		//var Tformat:TextFormat = new TextFormat();
		public var evtC:Event = new Event("NEXT",true);

		public function SaEText(color:String,Tformat:TextFormat)
		{			
			var fontArray:Array = Font.enumerateFonts(false);
			Tformat.font = fontArray[0].fontName;
			//Tformat.size =parseInt(Tsize);// 36;
			
			
			txt.textColor =uint("0x"+color);//ffcc66;
			txt.autoSize =TextFieldAutoSize.LEFT;			
			txt.embedFonts=true;
			txt.selectable =false;			
			txt.defaultTextFormat = Tformat;
			txt.wordWrap=true;
			txt.multiline=true;
			txt.setTextFormat (Tformat);
			addChild(_txtlayer);	
			_txtlayer.addChild(txt);
		}
		public function init()
		{
			
				txt.x = 0;
				txt.y = 0;
				_txtlayer.x = 960;
				_txtlayer.y = 640;
				txt.htmlText = "";
				txt.visible = false;
		}
		//返回文字用于回放记录
		public function showText(scenario:String):String 
		{
			var ArrT = scenario.split("|");//ENGVER
			var replaytxt="";
			_txtlayer.x = 0;// parseInt(ArrT[1]);
			_txtlayer.y = 0;// parseInt( ArrT[2]);
			
			txt.x = parseInt(ArrT[1]);
			txt.y = parseInt( ArrT[2]);
			txt.width = ArrT[3];

			if (ArrT[0] == "add")
			{
				txt.visible = true;
				txt.htmlText += ArrT[4];
				replaytxt=ArrT[4];
				
			}
			else if (ArrT[0] == "new")
			{
				txt.visible = true;
				txt.htmlText = ArrT[4];
				replaytxt=ArrT[4];
				
			}
			else if (ArrT[0] == "clear")
			{

				txt.x = 0;
				txt.y = 0;
				_txtlayer.x = 960;
				_txtlayer.y = 640;
				txt.htmlText = " ";
				txt.visible = false;

				_txtlayer.dispatchEvent(evtC);
			}


			if (ArrT.length >5)
			{
				if(ArrT[5]=="auto")
				{
					_txtlayer.dispatchEvent(evtC);			
					
				}
			}
			return replaytxt;
		}
	}

}