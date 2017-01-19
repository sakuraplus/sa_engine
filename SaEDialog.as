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
	import flash.text.TextField;
	import flash.text.*;


	public class SaEDialog  extends  Sprite 
	{
		var loaderContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);//在ios中加载swf资源

		public var imgUrl:String="" ;
		var container:Sprite = new Sprite();		
		var msgLoader:Loader = new Loader  ;
		
		var txtTalk:TextField=new TextField;
		var txtName:TextField=new TextField;

		var dur:Number=0;
		
		public var evtC:Event = new Event("NEXT",true);
		public var evtE:Event = new Event("LoadError",true);
	

		
		public function SaEDialog(url:String,colorN:String,colorD:String,Tformat:TextFormat,Tsize:String)
		{
			trace("new saemsg"+Tformat+"//"+Tformat.font);
			var fontArray:Array = Font.enumerateFonts(false);
			trace("new saemsg saefontArray"+fontArray);
			Tformat.font = fontArray[0].fontName;
			
			msgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR ,IMGloadError);
			var msgURLReq:URLRequest = new URLRequest(url);
			msgLoader.load(msgURLReq);

			Tformat.size =parseInt(Tsize);// 36;
			
			txtName.x=24;
			txtName.y=6;
			txtName.width=900;
			txtName.textColor =uint("0x"+colorN);
			txtName.embedFonts=true;
			txtName.selectable =false;			
			txtName.defaultTextFormat = Tformat;
			txtName.setTextFormat (Tformat);
			
			txtTalk.multiline=true;
			txtTalk.x=24;
			txtTalk.y=52;
			txtTalk.width=930;
			
			txtTalk.textColor =uint("0x"+colorD);
			txtTalk.autoSize =TextFieldAutoSize.RIGHT;			
			txtTalk.embedFonts=true;
			txtTalk.selectable =false;			
			txtTalk.defaultTextFormat = Tformat;
			txtTalk.wordWrap=true;
			txtTalk.multiline=true;
			txtTalk.setTextFormat (Tformat);
			
			
			container.addChild(msgLoader);
			container.addChild(txtName);
			container.addChild(txtTalk);
			addChild(container);
	
		}
		
		public function init()
		{
			trace("DIALOG init");
			txtTalk.htmlText = "";
			txtName.htmlText = "";
			container.alpha=0;
			container.visible=false;			
		}

		//显示对话，返回文字用于回放记录
		public function DialogAdd(str:String):String
		{
			container.visible = true;
			container.alpha=1;			
			txtTalk.htmlText +=  str;
			return str;
		}
		
		public function Dialog(str:String,dur:Number):String
		{
			var replaytxt="";
		
			var ArrT = str.split("|");//ENGVER
			if (ArrT.length <2)
			{
				txtTalk.htmlText = ArrT[0];
				replaytxt=ArrT[0];
				return replaytxt;			
			}
			
			txtTalk.htmlText = ArrT[1];
			txtName.htmlText = ArrT[0];

			container.visible = true;
		
			if (container.alpha < 1)
			{
				TweenLite.to(container,dur,{alpha:1});
			}


			if (ArrT.length >2)
			{
				if(ArrT[2]=="auto")
				{
					 container.dispatchEvent(evtC);
				}
			}
			replaytxt=ArrT[1];
			return replaytxt;			
		}
		
		public function Clr(durtime:int)
		{
			txtTalk.htmlText = "";
			txtName.htmlText = "";
			TweenLite.to(container,dur,{alpha:0});
			 container.dispatchEvent(evtC);
		}

		//显示隐藏台词，在台词有内容时可用
		public function ShowMsg(durtime:int)
		{
			if(txtTalk.text.length>0  || txtName.text.length>0)
			{
				TweenLite.to(container,durtime,{alpha:1});
				container.visible=true;
			}
			container.dispatchEvent(evtC);
		}
		public function HideMsg(durtime:int)
		{
			container.alpha=0;
			container.visible=false;
			container.dispatchEvent(evtC);
		}
		
		//IMGloadError
		function IMGloadError(event:IOErrorEvent):void {
		    trace("ioErrorHandler: " + event);
		    container.dispatchEvent(evtE);

		}

	
		
		/////////////////////////

		

	}

}