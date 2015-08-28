package org.pinenuts.manager
{
	import flash.events.IEventDispatcher;

	/**
	 * 可进行布局管理的接口
	 * 
	 * */
	public interface ILayoutManagerClient extends IEventDispatcher
	{
		/**
		 * LayoutManager实例
		 **/
		function get layoutManager():ILayoutManager;
		/**
		 * 对象是否经历了全部3个布局验证阶段的标志。
		 * 此标志由LayoutManager进行修改。
		 */
		function get initialized():Boolean;
		
		/**
		 *  @private
		 */
		function set initialized(value:Boolean):void;
		
		/**
		 * <p>顶层的SystemManager的nestLevel为1.
		 * 它的直接子级(包括顶级的document和各种pop-up窗口)的nestLevel为2.
		 * 直接子级的子级 ，nestLevel为3,以此类推。</p>
		 *
		 * <p>nestLevel被用于对ILayoutManagerClients在度量和布局阶段进行排序。<br />
		 * 在提交阶段(commitproperties)按照递增的顺序调用对象进行自我配置（自浅而深、自外而内）。<br />
		 * 在度量阶段(measure)按照递减的顺序进行度量操作（自深而浅、自内而外）。<br />
		 * 在布局阶段(updateDisplayList)按照递增的顺序进行操作（自浅而深，自外而内）。</p>
		 *  
		 */
		function get nestLevel():int;
		
		/**
		 *  @private
		 */
		function set nestLevel(value:int):void;
		
		/**
		 * 表明一个对象是否在等待派发updateComplete事件。
		 * 这个标志只能由LayoutManager进行修改。
		 */
		function get updateCompletePendingFlag():Boolean;
		
		/**
		 *  @private
		 */
		function set updateCompletePendingFlag(value:Boolean):void;
		
		//==============Method=========		
		/**
		 * 验证子项的位置和大小，并绘制其他可视内容。
		 * <p>如果使用此 ILayoutManagerClient 调用 LayoutManager.invalidateDisplayList() 方法，
		 * 则当更新显示列表时会调用 validateDisplayList() 方法。</p>
		 *  
		 */
		function validateDisplayList():void;
	}
}