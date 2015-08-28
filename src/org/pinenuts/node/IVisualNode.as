package org.pinenuts.node
{
	import flash.utils.Dictionary;
	
	import org.pinenuts.part.IPart;
	
	/**
	 * 可视化的节点接口。
	 * 
	 * <p>继承此接口的节点都伴随这一个零件（显示对象），涉及显示对象属性的设置，
	 * 最终都反应在零件的属性上。</p>
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/
	public interface IVisualNode
	{
		/**
		 * x轴坐标
		 **/
		function set x(value:Number):void;
		function get x():Number;
		/**
		 * y轴坐标
		 **/
		function set y(value:Number):void;
		function get y():Number;
		/**
		 * z轴坐标
		 **/
		function set z(value:Number):void;
		function get z():Number;
		/**
		 * 宽度
		 * **/
		function set width(value:Number):void;
		function get width():Number;
		/**
		 * 高度
		 * **/
		function set height(value:Number):void;
		function get height():Number;
		
		/**
		 * 透明度
		 **/
		function set alpha(value:Number):void;
		function get alpha():Number;
		/**
		 * 可见性
		 **/
		function set visible(value:Boolean):void;
		function get visible():Boolean;
		/**
		 * X轴缩放量
		 **/
		function set scaleX(value:Number):void;
		function get scaleX():Number;
		/**
		 * Y轴缩放量
		 **/
		function set scaleY(value:Number):void;
		function get scaleY():Number;
		/**
		 * Z轴缩放量
		 **/
		function set scaleZ(value:Number):void;
		function get scaleZ():Number;
		/**
		 * 旋转量
		 **/
		function set rotation(value:Number):void;
		function get rotation():Number;
		/**
		 * 绕X轴旋转
		 **/
		function set rotationX(value:Number):void;
		function get rotationX():Number;
		/**
		 * 绕Y轴旋转
		 **/
		function set rotationY(value:Number):void;
		function get rotationY():Number;
		/**
		 * 绕Z轴旋转
		 **/
		function set rotationZ(value:Number):void;
		function get rotationZ():Number;
		
		/**
		 * 节点皮肤
		 * **/
		function get part():IPart;
		//function set part(value:IPart):void;
		/**
		 * 皮肤类全名
		 * **/
		function get partClassName():String;
		function set partClassName(value:String):void;
		/**
		 * 创建可视化的零件
		 * **/
		function createPart():void;
		/**
		 * 删除此节点伴生的可视化零件
		 * **/
		function deletePart():void;
		/**
		 * 同步属性
		 * **/
		function syncProperties():void;
		/**
		 * 同步零件
		 * @param partDic 需要同步的零件列表
		 * **/
		function syncPart(partDic:Dictionary):void;
	}
}