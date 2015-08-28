package org.pinenuts.manager
{	
	import flash.system.ApplicationDomain;
	
	import org.pinenuts.core.GlobalEnmu;
	import org.pinenuts.core.pn_internal;

	use namespace pn_internal;
	/**
	 * 保存和SystemManager相关的各种配置
	 * 
	 * @productversion	workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2012.12
	 * */
	public final class SystemOptionBase
	{		
		
//===============================================================================================
		
		//保存获取的loaderInfo中的parameters对象
		public var parameters:Object;
		
		//保存系统配置文件数据
		public var configXML:XML;
		
		pn_internal var applicationType:String = GlobalEnmu.WEB;//应用的类型
		
		pn_internal var useSkinPath:String;						//主应用的皮肤资源文件地址
		pn_internal var usePreloader:Boolean = true;			//是否使用预加载器界面
		pn_internal var preloaderIsExternal:Boolean = false;
		pn_internal var preloaderPath:String = null;			//自定义预加载文件地址
		pn_internal var preloaderClassName:String = null;		//自定义预加载器类名
		pn_internal var preloaderX:Number = 0;					//预加载器x坐标
		pn_internal var preloaderY:Number = 0;					//预加载器y坐标
		
		//pn_internal var mainSkinIsExternal:Boolean = true;		
		//pn_internal var mainSkinUseType:String = "rsl";
		pn_internal var mainClassName:String;
		
		pn_internal var hasOtherResource:Boolean = false;		//是否含有其他资源需要加载
		pn_internal var autoOrNotLoadSrc:Boolean = false;		//是否在系统初始化阶段自动加载其他资源
		
		pn_internal var taskSum:uint = 0;						//初始化任务总数
		
		pn_internal var domNodeManager:IDomNodeManager;
		
		//public var securityManager:ISecurityManager;
		//public var skinManager:ISkinManager;
		public var layoutManager:ILayoutManager;
		public var topLevelSystemManagers:Vector.<ISystemManager> = new Vector.<ISystemManager>();//保存各种systemManager，一般情况下根级的SystemManager放在索引0
		
		public var rootDomain:ApplicationDomain;
		public var skinDomain:ApplicationDomain;
		//public var mainSkin:ISkinDocument;
		
		public var otherSrcDomain:ApplicationDomain;
		//public var otherResourceList:ResourceList;
		
		public var playerVersion:uint;
		
		public var rootWidth:Number = 0;
		public var rootHeight:Number = 0;
		
		private const DOCUMENT_NODE_ID:uint = 0x000000;
		private const PLAYER_11:uint = 11;
		
//=============================================================
		private static var instance:SystemOptionBase;
		
		public function SystemOptionBase(prvt:PrivateClass):void
		{
		}
		
		public static function getInstance():SystemOptionBase
		{
			if(!SystemOptionBase.instance)
			{
				SystemOptionBase.instance = new SystemOptionBase(new PrivateClass());
			}
			return SystemOptionBase.instance;
		}
	}
}
class PrivateClass{
	public function PrivateClass():void
	{
	}
}