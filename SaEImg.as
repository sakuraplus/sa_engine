package
{

	import flash.events.*;
	import flash.net.URLRequest;

	import flash.display.Sprite;
	import flash.display.*;
	import flash.display.Loader;
	import flash.system.LoaderContext;
	////////////
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;


	public class SaEImg  extends Sprite
	{
		var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);//在ios中加载swf资源
		
		public var imgUrl:String="" ;
		var container:Sprite = new Sprite();

		var craLoader1:Loader = new Loader  ;
		var craLoader0:Loader = new Loader  ;//交替使用
		var posX:int=0;
		var posY:int=0;
		var dur:Number=0;
		var showloader:Boolean =false;//false=0up,true=1up
		
		public var evtC:Event = new Event("NEXT",true);
		public var evtE:Event = new Event("LoadError",true);

		
		public function SaEImg()
		{
			loaderContext.allowCodeImport=false;//允许加载swf中脚本
			craLoader1.contentLoaderInfo.addEventListener(Event.COMPLETE,IMGloadComplete);
			craLoader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,IMGloadError);
			craLoader0.contentLoaderInfo.addEventListener(Event.COMPLETE,IMGloadComplete);
			craLoader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,IMGloadError);
			craLoader1.alpha=0;
			craLoader0.alpha=0;
			container.addChild(craLoader1);
			container.addChild(craLoader0);
			addChild(container);
		}
		
		public function showImg(url:String,posx:int,posy:int,durtime:Number)
		{
			posX=posx;
			posY=posy;
			dur=durtime;

			switch (url)
			{
				case "" :
					//[img 头像.jpg,500,500,M] 图片在role/文件夹,头像url为空时清除图片，直接进行下一条脚本
					trace("♂url="+url);
					imgUrl="";
					showloader=false;
					TweenLite.to(craLoader0,dur,{alpha:0});
					TweenLite.to(craLoader1,dur,{alpha:0});//,overwrite:2
					container.dispatchEvent(evtC);
					return;
				case "unload" :
					//[img unload,0,0,M] unloadandstop图层中的swf ，ios中不能使用带有as的swf，直接进行下一条脚本
					trace("unload url="+url);
					showloader=false;
					craLoader0.unloadAndStop();
					craLoader1.unloadAndStop();
					imgUrl="";
					container.dispatchEvent(evtC);
					return;
				case imgUrl :
					//与原图片相同时,移动图片，直接进行下一条脚本
					trace("♂url,imgUrl="+url);
					trace("move");
					moveCra();
					container.dispatchEvent(evtC);
					return;
				default :
					//不满足，更新url，显示新图片
					imgUrl=url;
					_showImg(url,durtime);

					return;
			}


		}

		//显示图片
		public function _showImg(url:String,durtime:Number)
		{
			var craURLReq:URLRequest = new URLRequest("role/" + url);//
			craLoader1.x=posX;
			craLoader0.x=posX;
			craLoader1.y=posY;
			craLoader0.y=posY;
			showloader=!showloader;
			TweenLite.killTweensOf(craLoader1);
			TweenLite.killTweensOf(craLoader0);
			if(showloader)
			{
				craLoader1.alpha=0;
				trace("craloader1 load");
				craLoader1.unloadAndStop();
				craLoader1.load(craURLReq,loaderContext);
				container.setChildIndex(craLoader1,0);///////////////置于底层				
			}else{
				//0=0up				
				craLoader0.alpha=0;
				trace("craloader0 load");
				craLoader0.unloadAndStop();
				craLoader0.load(craURLReq,loaderContext);
				container.setChildIndex(craLoader0,0);///////////////置于底层
			}
		}
		
		//IMGloadError
		function IMGloadError(event:IOErrorEvent):void {
		    trace("ioErrorHandler: " + event);			
		    container.dispatchEvent(evtE);

		}

		//立绘加载完成
		function IMGloadComplete(event:Event)
		{
			
			trace(event.currentTarget.loader.alpha+"△~~~"+craLoader0.alpha+"/"+craLoader1.alpha);
			
			//加载完成的图片置于底层，旧图片在上层淡出
			if(showloader)
			{
				if(craLoader0.alpha>0.2)		
				{
					trace("--craLoader1 show"+showloader);
					craLoader1.alpha=1;
					TweenLite.to(craLoader0,dur,{alpha:0});//,overwrite:2	
				}
				else
				{
					trace("--第一次出现craLoader1 show"+showloader);
					TweenLite.to(craLoader1,dur,{alpha:1});//,overwrite:2	
				}
			}else{
				if(craLoader1.alpha>0.2)//							
				{
					trace("++craLoader0 show"+showloader+"/"+dur);
					craLoader0.alpha=1;
					TweenLite.to(craLoader1,dur,{alpha:0});//,overwrite:2	
				}
				else
				{
					trace("++第一次出现craLoader0 show"+showloader+"/"+dur);
					TweenLite.to(craLoader0,dur,{alpha:1});//,overwrite:2	
				}
			}
			
			
			container.dispatchEvent(evtC);
		}


		//[clearimg]清除所有头像立绘, 直接进行下一条脚本
		function anCLEARIMG(dur:int)
		{
			imgUrl="";
			showloader=false;
			TweenLite.to(craLoader1,dur,{alpha:0});//,overwrite:2		
			TweenLite.to(craLoader0,dur,{alpha:0});//,overwrite:2		
		}
		//移动
		private function moveCra()
		{
			trace("move--"+dur);
			if(!showloader)
			{
				TweenLite.to(craLoader0,dur,{x:posX,y:posY});//,overwrite:2
				craLoader1.x =posX;
				craLoader1.y =posY;
				
			}else{
				//0=0up			
				TweenLite.to(craLoader1,dur,{x:posX,y:posY});//,overwrite:2
				craLoader0.x =posX;
				craLoader0.y =posY;
			}
		}

		

	}

}