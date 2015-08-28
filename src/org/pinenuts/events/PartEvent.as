package org.pinenuts.events
{
	import flash.events.Event;
	
	/**
	 * 框架组件事件
	 * @productversion workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2013.5
	 **/
	public class PartEvent extends Event
	{
		public static const PREV_INITIALIZE:String = "prevInitialize";
		public static const INITIALIZE:String = "initialize";
		public static const CREATION_COMPLETE:String = "creationComplete";
		public static const UPDATE_COMPLETE:String = "updateComplete";
		public static const VALIDATEPROPERTIES_COMPLETTE:String = "validatePropertiesComplete";
		public static const VALIDATESIZE_COMPLETE:String = "validateSizeComplete";
		public static const VALIDATEDISPLAYLIST_COMPLETE:String = "validateDisplayListComplete";
		public static const STATE_CHANGE:String = "stateChange";
		
		
		public function PartEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public var id:String;

		override public function clone():Event
		{
			var partEvent:PartEvent = new PartEvent(type,bubbles,cancelable);
			partEvent.id = id;
			return partEvent;
		}
	}
}