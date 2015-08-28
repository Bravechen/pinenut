package org.pinenuts.core
{
	import flash.events.IEventDispatcher;
	
	import org.pinenuts.vo.DomNodeVO;
	
	/**
	 * IDomNode接口定义了作为显示列表中某个节点的配置信息。通过该配置信息可以获取对象作为列表中的一个节点的基本属性。
	 * 该接口仅用于初始化框架系统内部使用
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 */
	public interface IDomNode extends IEventDispatcher
	{
		/**
		 * 节点id
		 * */
		function get nodeId():uint;
		function set nodeId(value:uint):void;
		/**
		 * 节点数据vo
		 * */
		function get domNodeVO():DomNodeVO;
		
		/**
		 * 设置定义的dom节点属性<br />
		 * 
		 * dom中的节点除了有必要的属性之外，还可以自定义节点属性。在所有实现IDomNode接口的类当中，
		 * 需要获取自定义属性值时都可以实现或者重写optionDefinedProperties()方法。<br />
		 * 所有的自定义属性及其值都可以通过DomNodeVO类中的definedProperties(Object)属性<br />
		 * <br />
		 * 由于框架组件会在派发creationComplete事件时，清空组件的domNodeVO，因此调用optionDefinedProperties()会在这之前。
		 * 特别的，当需要多次调用该方法时，请对domNodeVO做非空判断处理。
		 * **/
		function optionDefinedProperties():void;
	}
}