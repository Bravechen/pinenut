package org.pinenuts.core
{
	/**
	 * 清理链条节点接口<br />
	 * 定义了一个清理节点对象应具有的接口。<br />
	 * 可以依据对象的耦合设计一条清理链条，当对象在完成一定任务，或者即将被消除时，可以调用一下清理节点的方法。
	 * 
	 * @productversion workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2013.5
	 **/
	public interface IClearableNode
	{
		/**
		 * 在初始化完成或程序运行中段进行的清理释放。
		 * 一些初始化所用到的资源以及程序运行一段以后产生的不用资源。
		 * 可以通过此方法进行集中清理。
		 **/
		function clearDone():void;
		/**
		 * 在对象释放前进行最后的清理
		 * <p>termiClear()用于尽量将对象内容和事件删除卸载(取决于具体的扩展)，因此应当在确定不使用对象的时候运行其方法。
		 * 运行后可以将对象置为null。可以自行设计由termiClear()引起的清理链条。
		 * </p>
		 * **/
		function termiClear():void;
		/**
		 * 用于重新设置节点的各项属性
		 * 
		 * 对于一些可复用的对象，设计重新设置，将属性归于默认状态。可以供下次使用。 
		 * **/
		function resetNode():void;
	}
}
