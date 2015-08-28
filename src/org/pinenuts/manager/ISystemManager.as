package org.pinenuts.manager
{	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	
	import org.pinenuts.node.IDocumentNode;

	/**
	 * 系统管理类接口<br />
	 * @author	晨光熹微<br />
	 * date		2013.1
	 * @productversion	workerbee 1.0
	 **/
	public interface ISystemManager extends IEventDispatcher
	{
		/**根级舞台对象**/
		function get stageRoot():Stage;
		/**
		 * 根级容器的宽度
		 **/
		function get rootWidth():Number;
		function set rootWidth(value:Number):void;
		/**
		 * 根级容器的高度
		 **/
		function get rootHeight():Number;
		function set rootHeight(value:Number):void;

		function get documentNode():IDocumentNode;
		function get documentDisplay():DisplayObject;

		/**
		 * 添加主文档节点
		 * **/
		function addDocumentNode(node:IDocumentNode):void;
	}
}