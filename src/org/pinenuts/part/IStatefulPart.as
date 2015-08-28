package org.pinenuts.part
{
	public interface IStatefulPart
	{
		/**
		 * 状态列表
		 ***/
		//function get statusList():Vector.<String>;
		//function set statusList(value:Vector.<String>):void;
		/**
		 * 当前状态
		 * */
		function get currentState():String;
		function set currentState(value:String):void;
		
	}
}