package 
{

	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.*;
    import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
		import flash.system.LoaderContext;

	public class onlinetest extends MovieClip
	{

		var SaeMsgbox:SaEMsgbox;
		var Tformat:TextFormat = new TextFormat();
				var loaderContext:LoaderContext = new LoaderContext();//在ios中加载swf资源

		public function onlinetest()
		{
			// constructor code
			trace("1");	
			var TFloader:Loader  = new Loader();
			var TFurl:URLRequest = new URLRequest("setting/font.swf");//"fontfish.swf"
			TFloader.contentLoaderInfo.addEventListener(Event.COMPLETE, TextformatComplete);
			TFloader.load(TFurl,loaderContext);

			//Tformat.size=30;
	
		

			//SaeMsgbox.showmsg ( "clickReplay", "要退出了么？");
		}

		function TextformatComplete(event:Event):void
		{
			var fontArray:Array = Font.enumerateFonts(false);
			trace("☆字体swf加载完成02fontArray"+fontArray);
			Tformat.font = fontArray[0].fontName;
			trace("2");

			SaeMsgbox = new SaEMsgbox("ff3333","00cc99","ui/msgbg.png,ui/yes.png,ui/no.png","280,220,290,330,480,330,290,350",Tformat);
			trace("3");

			addChild(SaeMsgbox);
			trace("4");	
			SaeMsgbox.showmsg ( "clickReplay", "要退出了么？");
		}
	}

}