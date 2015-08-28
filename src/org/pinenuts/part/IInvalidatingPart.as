package org.pinenuts.part
{
	/**
	 * 具有无效化阶段的零件接口
	 * */
	public interface IInvalidatingPart
	{		
		/**
		 *  调用这个方法的结果会导致在显示列表渲染之前调用
		 *  <code>validateDisplayList()</code> 方法
		 *
		 *  <p>最终会使组件的<code>updateDisplayList()</code>方法被调用</p>
		 *  
		 *  @productversion workerbee 1.0
		 */
		function invalidateDisplayList():void;
	}
}