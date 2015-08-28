package org.pinenuts.manager
{	
	import flash.utils.getDefinitionByName;
	
	public final class SingletonManager
	{
		private static var registerClassList:Vector.<String> = new Vector.<String>();

		private static var classMap:Object = {};
		/**
		 * 是否已被注册
		 * @param interfaceName 单例接口名
		 * **/
		static public function isRegistered(interfaceName:String):Boolean
		{
			return !!classMap[interfaceName];
		}

		/**
		 * 注册类
		 * @param	interfaceName 接口名或者类全名
		 * @param	className 类全名称
		 **/
		public static function registerClass(interfaceName:String,className:String):void
		{
			var c:Class = classMap[interfaceName];
			if (!c){
				classMap[interfaceName] = createClass(className);
				registerClassList.push(interfaceName);
			}
		}
		/**
		 * 获取类
		 * @param	interfaceName 接口名或者类全名
		 * @return 类实例
		 **/
		public static function getClass(interfaceName:String):Class
		{
			return classMap[interfaceName];
		}
		/**
		 * 获取单例类
		 * @param	interfaceName 接口名或者类全名
		 * @return 调用单例类的getInstance()方法返回的类实例
		 **/
		public static function getInstance(interfaceName:String):Object
		{
			var c:Class = classMap[interfaceName];
			if (!c)
			{
				throw new Error("parameters error,[SingletonManager],No class registered for interface '" + interfaceName + "'.");
				return null;
			}
			return c["getInstance"]();
		}
		
		/**
		 * @private
		 * 输出注册的类
		 * 
		 **/
		public static function registerClassNameList():String
		{
			var len:int = registerClassList.length;
			if(len==0)
				return null;
			var listStr:String = "";
			for(var i:int=0;i<len;i++)
			{
				listStr+="*"+registerClassList[i]+"*"+"\n";
			}
			return listStr;
		}
		
		/**
		 * 创建类实例
		 * @param	className 类全名
		 * @return	类实例
		 **/
		private static function createClass(className:String):Class
		{
			return Class(getDefinitionByName(className));
		}		
	}
}