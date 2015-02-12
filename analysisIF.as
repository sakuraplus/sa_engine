package 
{

	//import saE;

	public class analysisIF 
	{
		//private var aa:test;


		public function analysisIF()
		{
			//analysis(str)
			
			
			
		}
		public static function analysis(str:String):Boolean
		{

			
			var ifArr:Array=new Array();
			var TifArr:Array=new Array();
			var st = 0;
			var ed = 0;
			var con:String;
			if (str.indexOf(")&&(") >= 0)
			{
				con = "&&";
			}
			else if (str.indexOf(")||(") >= 0)
			{
				con = "||";
			}
			while (str.indexOf("(") >= 0&& str.indexOf(")") >= 0)
			{

				st = str.indexOf("(");
				ed = str.indexOf(")");
				ifArr.push(str.substring(st+1,ed));
				//trace("~~"+str.substring(st+1,ed));
				str=str.substring(ed+1,str.length);
				trace(str);
			}
			trace(ifArr);
			var Tboolean:Array =new Array();
			var i = 0;
			for (i=0; i<ifArr.length; i++)
			{
				if (ifArr[i].indexOf("&&") >= 0)
				{
					TifArr = ifArr[i].split("&&");
					//trace("T"+TifArr);
					Tboolean.push(TArr(TifArr,"&&"));
				}
				else if (ifArr[i].indexOf("||") >= 0)
				{
					TifArr = ifArr[i].split("||");
					//trace("T"+TifArr);
					Tboolean.push(TArr(TifArr,"||"));
				}
				else
				{
					Tboolean.push( condition(ifArr[i]));
				}
			}
			if (con=="&&")
			{
				for each (var itemand in Tboolean)
				{
					//trace("<<"+itemand);
					if (! itemand)
					{
						//trace("xxxxxx!!");
						return false;

					}
				}
				return true;
			}
			else if (con=="||")
			{

				for each (var itemor in Tboolean)
				{
					//trace("<<"+itemor);
					if (itemor)
					{
						//trace("vvvvvv!");
						return true;

					}
				}
				return false;
			}
			else
			{
				return Tboolean[0];
			}
			return false;

		}

	protected static	 function TArr(Arr:Array,str:String ):Boolean
		{
			if (str=="&&")
			{
				for each (var itemand in Arr)
				{
					//trace("&&&"+itemand);
					if (! condition(itemand))
					{
						//trace("xxxxxx");
						return false;

					}
				}
				return true;
			}

			if (str=="||")
			{
				for each (var itemor in Arr)
				{
					//trace("|||"+itemor);
					if (condition(itemor))
					{
						//trace("vvvv");
						return true;

					}
				}
				return false;
			}


			return false;


		}









		////////////
		protected static function condition(str:String):Boolean
		{
			
			var arr;
						
			if (str.indexOf("==") >= 0)
			{
				//==   
				if(compString(str,"=="))
				{
					return true;
				}
				arr = getCheckInt(str,"==");
				return arr[0] == arr[1];
			}
			else if (str.indexOf("!=") >= 0)
			{
				//!= 
				if(compString(str,"!="))
				{
					return true;
				}
				arr = getCheckInt(str,"!=");
				return arr[0] != arr[1];
			}
			else if (str.indexOf(">=") >= 0)
			{
				//>=   
				arr = getCheckInt(str,">=");
				return arr[0] >= arr[1];
			}
			else if (str.indexOf("<=") >= 0)
			{
				//<=   
				arr = getCheckInt(str,"<=");
				return arr[0] <= arr[1];
			}
			else if (str.indexOf(">") >= 0)
			{
				//>   
				arr = getCheckInt(str,">");
				return arr[0] > arr[1];
			}
			else if (str.indexOf("<") >= 0)
			{
				//<   
				arr = getCheckInt(str,"<");
				return arr[0] < arr[1];
			}
			return false;
		}

		protected static function getCheckInt(str:String,s:String)
		{
			var arr;
			arr = str.split(s);		   
			
			arr[0] = parseInt(arr[0]);
			arr[1] = parseInt(arr[1]);

			return arr;
		}
		
		protected static function compString(str:String,s:String):Boolean 
		{
			var arr;
			arr = str.split(s);
			if(isNaN (parseInt(arr[0])) && isNaN (parseInt(arr[1])))
		   {
			   
				//arr[0] = arr[0].replace(" ","");
				//arr[1] = arr[1].replace(" ","");
				//trace("比较string-- " +arr[0]+"//"+arr[1]);
				if(s=="==")
				{
					return arr[0] == arr[1];
				}
				if(s=="!=")
				{
					return arr[0] != arr[1];
				}
		   }					
					   
			return false;
			
		}



	}

}