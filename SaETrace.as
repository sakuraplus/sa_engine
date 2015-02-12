package 
{
	import flash.text.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flash.display.Sprite;
	
	public class SaETrace extends Sprite
	{

		var txt:TextField = new TextField();
		
		var Tformat:TextFormat = new TextFormat();
		var tracetimer:Timer = new Timer(5000,1);//显示提示信息的时间
		
		
		public function SaETrace()
		{
			txt.x = 0;
			txt.y = 0;
			

			txt.text = "";
			txt.visible = false;			
			txt.autoSize = TextFieldAutoSize.LEFT;
		
			txt.selectable = false;
			txt.width=900;
			txt.wordWrap = true;
			txt.multiline = true;
			txt.background =true;
			addChild(txt);
			tracetimer.addEventListener(TimerEvent.TIMER_COMPLETE,ontraceTimerComplete);
			trace("saetrace-");
		}
	

		//设定样式
		public function init(colorB:String,colorT:String,dur:int,Tformat:TextFormat)
		{
			trace("new SaETrace"+Tformat+"//"+Tformat.font);
			var fontArray:Array = Font.enumerateFonts(false);
			Tformat.font = fontArray[0].fontName;
			Tformat.size = 22;
			txt.defaultTextFormat = Tformat;
			txt.embedFonts = true;
			txt.textColor =uint("0x"+colorT);//#333366;
			txt.backgroundColor=uint("0x"+colorB);
			txt.alpha=0.5;
			tracetimer = new Timer(dur,1);//显示提示信息的时间
			tracetimer.addEventListener(TimerEvent.TIMER_COMPLETE,ontraceTimerComplete);
			trace("saetrace init-"+dur);

		}
		//显示，开始计时
		public function showText(scenario:String)
		{
			trace("showtxt-"+txt.text+">>"+scenario);
			txt.visible = true;
			if (txt.text == "")
			{
				trace("--saetrace===");
				txt.htmlText  = scenario;
			}else{
				trace("--saetrace+++");
				txt.htmlText +=(scenario);
			}
			tracetimer.reset();
			tracetimer.start();

		}

		//计时结束
		function ontraceTimerComplete(event:TimerEvent):void
		{
			txt.text="";
			txt.visible=false;
		}

	}
}