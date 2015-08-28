package org.pinenuts.manager
{	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	
	import org.pinenuts.node.INode;
	//import org.workerbee.error.SystemErrorMessage;
	//import org.workerbee.manager.IManager;

	/**
	 * 类工厂<br />
	 * @productversion	workerbee 1.0
	 * @author	 晨光熹微
	 * date		2012.11
	 * **/
	public final class ClassFactoryManager extends EventDispatcher
	{
		public function ClassFactoryManager()
		{
			super();
		}
		
		static public function createNode(nodeClassName:String,domain:ApplicationDomain=null):INode
		{
			var node:INode;
			var NodeClass:Class;
			try{
				NodeClass = (domain)?Class(domain.getDefinition(nodeClassName)):Class(getDefinitionByName(nodeClassName));
				node = (new NodeClass()) as INode;
			}catch(error:Error){
				error.message+=" classFactoryCreateError ClassFactory-creatDisplay() "+error.message;
				throw error;
				return null;
			}
			if(!node){
				throw new Error("classFactoryCreateError ClassFactory-creatDisplay() 创建的display为null!");
				return null;
			}
			return node;
		}
		
		/**
		 * 创建显示对象
		 * @param	className 类全名称
		 * @param	domain	  域对象
		 * @return	显示对象
		 * **/
		public static function creatDisplay(className:String,domain:ApplicationDomain=null):DisplayObject
		{
			var display:DisplayObject;
			var ViewClass:Class;
			try{
				ViewClass = (domain)?Class(domain.getDefinition(className)):Class(getDefinitionByName(className));
				display = (new ViewClass()) as DisplayObject;
			}catch(error:Error){
				error.message+=" classFactoryCreateError ClassFactory-creatDisplay() "+error.message;
				throw error;
				return null;
			}
			if(!display){
				throw new Error("classFactoryCreateError ClassFactory-creatDisplay() 创建的display为null!");
				return null;
			}
			return display;
		}
		
		/**
		 * 创建位图数据对象
		 * @param	className 类全名称
		 * @return	位图对象
		 * **/
		public static function creatBitmapData(className:String,domain:ApplicationDomain=null):BitmapData
		{
			var ImgClass:Class;
			var bitmapData:BitmapData;
			try{
				ImgClass = (domain)?Class(domain.getDefinition(className)):Class(getDefinitionByName(className));
				bitmapData = (new ImgClass()) as BitmapData;
			}catch(error:Error){
				throw new Error("classFactoryCreateError ClassFactory-creatBitmapData()"+error.message);
				return null;
			}			
			return bitmapData;
		}
		/**
		 * 创建字体对象
		 * @param	className 类的全名称
		 * @return	字体对象
		 * **/
		public static function creatFont(className:String):Font
		{
			try{
				var FontClass:Class = getDefinitionByName(className) as Class;
				Font.registerFont(FontClass);
				var font:Font = (new FontClass()) as Font;
			}catch(error:Error){
				error.message+=" classFactoryCreateError ClassFactory-creatFont()";
				throw new error;
				return null;
			}
			return font;
		}		
		/**
		 * 从指定的域中创建字体对象
		 * @param	className 类的全名称
		 * @param	domain	指定的域
		 * @return	字体对象
		 * **/
		public static function creatFontFormDomain(className:String,domain:ApplicationDomain):Font
		{
			try{
				var FontClass:Class = Class(domain.getDefinition(className));
				Font.registerFont(FontClass);
				var font:Font = (new FontClass()) as Font;
			}catch(error:Error){
				error.message+=" classFactoryCreateError ClassFactory-creatFont()";
				throw new error;
				return null;
			}
			return font;
		}
	}
}