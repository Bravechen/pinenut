package org.pinenuts.manager
{
	import flash.events.IEventDispatcher;

	public interface ISystemManagerClient extends IEventDispatcher
	{
		/**
		 * 零件所在列表中对应的ISystemManager对象 
		 **/
		function get systemManager():ISystemManager;
		function set systemManager(value:ISystemManager):void;
	}
}