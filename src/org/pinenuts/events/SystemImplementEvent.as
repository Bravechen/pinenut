package org.pinenuts.events
{
	import flash.events.Event;

	/**
	 * 系统实现事件
	 * @productversion workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2013.5
	 **/
	public class SystemImplementEvent extends Event
	{
		public static const INIT_SYSTEM:String = "initSystem";
		public static const INIT_PRELOADER_UI:String = "initPreloaderUI";
		public static const PRELOADER_PREPARED:String = "preloaderPreared";
		public static const MAIN_SKIN_READY:String = "mainSkinReady";
		public static const OTHER_RESOURCE_READY:String = "otherResourceReady";
		public static const ALL_INIT_RESOURCE_COMPLETE:String = "allInitResourceComplete";
		public static const PRELOADER_DONE:String = "preloaderDone";
		public static const INIT_TOP_WINDOW:String = "initTopWindow";
		public static const DOM_TIDY_DONE:String = "domTidyDone";
		public static const SKIN_RESOURCE_TIDY_DONE:String = "skinResourceTidyDone";
		public static const NO_SKIN_RESOURCE:String = "noSkinResource";

		public function SystemImplementEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event{
			var systemImplementEvent:SystemImplementEvent = new SystemImplementEvent(type,bubbles,cancelable);
			
			return systemImplementEvent;
		}
	}
}