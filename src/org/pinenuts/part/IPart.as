package org.pinenuts.part
{
	import flash.events.IEventDispatcher;
	
	import org.pinenuts.node.IVisualNode;
	import org.pinenuts.vo.DomNodeVO;

	/**
	 * 零件接口
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * */
	public interface IPart extends IEventDispatcher
	{
		/**绑定的节点对象**/
		function set node(value:IVisualNode):void;
		function get node():IVisualNode;
		
		/**
		 * 可用性
		 **/
		function set enable(value:Boolean):void;
		function get enable():Boolean;
		/**
		 * 节点id名称，每个实例的Id名要保持唯一
		 **/
		function set id(value:String):void;
		function get id():String;
		
		//=============================================
		/**
		 * 初始化对象
		 **/
		function initialize():void;	
		
		/**
		 * 清空所有子显示对象
		 * **/
		function clearAllElements():void;
		/**
		 * 设置自定义的零件属性<br />
		 * 
		 * dom中的节点除了有必要的属性之外，还可以自定义节点属性。在所有实现IDomNode接口的类当中，
		 * 需要获取自定义属性值时都可以实现或者重写optionDefinedProperties()方法。<br />
		 * 所有的自定义属性及其值都可以通过DomNodeVO类中的definedProperties(Object)属性<br />
		 * <br />
		 * 由于框架组件会在派发creationComplete事件时，清空组件的domNodeVO，因此调用optionDefinedProperties()会在这之前。
		 * 特别的，当需要多次调用该方法时，请对domNodeVO做非空判断处理。
		 * **/
		/**
		 * 同步属性
		 * **/
		function syncOtherProperties(properties:Object):void;
		
	}
}