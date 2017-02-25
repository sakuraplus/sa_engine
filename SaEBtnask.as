package
{
	import flash.events.*;
	import flash.net.URLRequest;

	import flash.text.*;

	
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;

	public class SaEBtnask  extends Sprite
	{
		var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);//在ios中加载swf资源
		var askLoader = new Loader;
		var txt:TextField = new TextField();

		public function SaEBtnask(str:String,bgurl:String,Tformat:TextFormat)
		{		
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			//loaderContext.allowCodeImport=false;//允许加载swf中脚本
			
			var fontArray:Array = Font.enumerateFonts(false);
			Tformat.font = fontArray[0].fontName;
			Tformat.size = 30;
			addChild(txt);			
			txt.textColor =0xffcc66;
			txt.autoSize =TextFieldAutoSize.CENTER;			
			txt.embedFonts=true;
			txt.selectable =false;
			txt.multiline=true;
			txt.defaultTextFormat = Tformat;
			txt.visible=false;
			//txt.alpha=0;
			txt.htmlText=str;
			
			txt.setTextFormat (Tformat);
			
			
			var askURLReq:URLRequest = new URLRequest("ui/" + bgurl);
			
			askLoader.load(askURLReq,loaderContext);
			//addChildAt(askLoader,0);
			askLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,ASKloadComplete);			
			askLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,IMGloadError);

		}

		//清除
		private function onRemoveFromStage(e:Event):void
        {
			askLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,ASKloadComplete);			
			askLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR ,IMGloadError);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			askLoader.unloadAndStop(false);
			askLoader=null;
			txt=null;

//             trace(">>>>>>>>>>>>>>> btnremove-saeb!!");
      }

	
		function IMGloadError(event:IOErrorEvent):void 
		{
			txt.visible=true;
			trace("BTNioErrorHandler: " + event);
			txt.htmlText+=event.toString ();
			askLoader.unload();
		}
		function ASKloadComplete(event:Event)
		{
			txt.visible=true;
			//选项背景图加载完成
			event.currentTarget.removeEventListener(Event.COMPLETE,ASKloadComplete);			
			txt.x = (event.currentTarget.width - txt.width)/ 2;			
			txt.y = (event.currentTarget.height - txt.height)/ 2;			
			addChildAt(event.currentTarget.content,0);
			askLoader.unload();
		}
	}

}