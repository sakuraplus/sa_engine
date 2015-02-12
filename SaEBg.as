package
{
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	import flash.display.Sprite;
	import flash.display.*;
	import flash.system.LoaderContext;
	////////////
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;


	public class SaEBg  extends Sprite
	{
		var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);//在ios中加载swf资源

		public var imgUrl:String="" ;
		var container:Sprite = new Sprite();
		
		var bgLoader1:Loader = new Loader  ;
		var bgLoader0:Loader = new Loader  ;//交替使用

		var dur:Number=0;
		var bgLoaderState:Boolean =false;//false=0up,true=1up
		
		public var evtC:Event = new Event("NEXT",true);
		public var evtE:Event = new Event("LoadError",true);
		//public var my_event:test_event=new test_event();	

		
		public function SaEBg()
		{
			
			bgLoader1.contentLoaderInfo.addEventListener(Event.COMPLETE,bgIMGloadComplete);
			bgLoader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,bgIMGloadError);
			bgLoader0.contentLoaderInfo.addEventListener(Event.COMPLETE,bgIMGloadComplete);
			bgLoader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,bgIMGloadError);
			
				
			bgLoader1.alpha=0;
			bgLoader0.alpha=0;
			container.addChild(bgLoader1);
			container.addChild(bgLoader0);
			addChild(container);
	
		}
		
		//[background 图片url] 显示背景
		public function showBg(url:String,durtime:Number)
		{
			dur=durtime;
			
			if (url=="")
			{
				//使用[background clear] 清除背景
				 clearBg(durtime);				
				return;
			}


			var bgURLReq:URLRequest = new URLRequest("ui/" + url);
			if (bgLoaderState)
			{
				//loader1在上
				bgLoader0.alpha = 0;
				bgLoader0.load(bgURLReq);
				container.setChildIndex(bgLoader1,0);
			}
			else
			{
				bgLoader1.load(bgURLReq);
				bgLoader1.alpha = 0;
				container.setChildIndex(bgLoader0,0);
			}
			bgLoaderState = ! bgLoaderState;
			
			//container.dispatchEvent(evtC);				
		}
		
		//清除背景图
		public function clearBg(durtime:Number)
		{
			trace("清除背景图31清除背景图31清除背景图31");
			TweenLite.to(bgLoader1,durtime,{alpha:0});
			TweenLite.to(bgLoader0,durtime,{alpha:0});
			imgUrl = "";
			//container.dispatchEvent(evtC);
		}

		//清除背景图
		public function init()
		{
			bgLoader1.alpha=0;
			bgLoader0.alpha=0;
			trace("清除背景图3init");
			imgUrl = "";
			//TweenLite.to(bgLoader1,durtime,{alpha:0});
			//TweenLite.to(bgLoader0,durtime,{alpha:0});
		}
		
		//IMGloadError加载错误，显示错误信息
		function bgIMGloadError(event:IOErrorEvent):void {
		    trace("ioErrorHandler: " + event);
		    container.dispatchEvent(evtE);
		}

		//立绘加载完成
		function bgIMGloadComplete(event:Event)
		{
			TweenLite.to(event.currentTarget.loader,dur,{alpha:1});
			
		}


	}

}