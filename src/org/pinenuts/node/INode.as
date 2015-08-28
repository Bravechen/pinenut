package org.pinenuts.node
{
	import flash.events.IEventDispatcher;

	/**
	 * 节点对象接口
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/
	public interface INode extends IEventDispatcher
	{
		/**
		 * 父级节点对象
		 **/
		function get parentNode():IContainerNode;
		function set parentNode(value:IContainerNode):void;
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
	}
}