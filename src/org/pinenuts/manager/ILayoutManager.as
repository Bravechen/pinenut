package org.pinenuts.manager
{
	public interface ILayoutManager
	{
		function set systemManager(value:ISystemManager):void;
		
		/**
		 * 一个标志，用于指示 LayoutManager 是否允许在各个阶段之间更新屏幕。<br />
		 * <br />
		 * 如果为 true，则在各阶段都会进行度量和布局，每个阶段结束后都会更新一次屏幕。<br />
		 * <br />
		 * 所有组件都将调用其 validateProperties() 和 commitProperties() 方法，直到验证完各自的所有属性。
		 * 屏幕将随之更新。<br />
		 * 然后，所有组件都将调用其 validateSize() 和 measure() 方法，直到测量完所有组件，屏幕也将再次更新。<br />
		 * 最后，所有组件都将调用其 validateDisplayList() 和 updateDisplayList() 方法，直到验证完所有组件，屏幕也将再次更新。<br />
		 * <br />
		 * 如果正在验证某个阶段，并且前面的阶段失效，则会重新启动 LayoutManager。当创建和初始化大量组件时，此方法更为高效。框架负责设置此属性。<br />
		 * <br />
		 * 如果为 false，则会在更新屏幕之前完成所有这三个阶段。
		 */
		function get usePhasedInstantiation():Boolean;
		
		/**
		 *  @private
		 */
		function set usePhasedInstantiation(value:Boolean):void;
		
		//--------------------------------------------------------------------------
		//
		//  Methods: Invalidation
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 当组件发生的更改导致其布局和/或视觉效果需要更改时调用。
		 * 在这种情况下，即使没有更改过组件的大小，也必须运行组件的布局算法。
		 * 例如，当添加了新的子组件时、样式属性发生更改时或组件的父项为组件赋予了新尺寸时。
		 *
		 *  @param obj 更改过的对象。
		 */
		function invalidateDisplayList(obj:ILayoutManagerClient ):void;
		
		/**
		 * 如果存在需要验证的组件，则返回 true；如果已经验证所有组件，则返回 false。
		 *  
		 * @return Returns 如果存在需要验证的组件，则返回 true；如果已经验证所有组件，则返回 false。
		 *  
		 */
		function isInvalid():Boolean;
	}
}