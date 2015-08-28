package org.pinenuts.manager
{	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.pinenuts.core.pn_internal;
	import org.pinenuts.events.PartEvent;
	import org.pinenuts.manager.managerClass.PriorityQueue;

	use namespace pn_internal;

	/**
	 * 布局管理类<br />
	 * 布局管理类实现了延迟计算和渲染，以及和布局相关属性协调分配的功能。
	 * 
	 * @productversion workbee 1.0
	 * @author	晨光熹微<br />
	 * date		2012.12 
	 * */
	public final class LayoutManager extends EventDispatcher implements ILayoutManager
	{		
		private var _systemManager:ISystemManager;
		/**
		 * 根级systemManager对象
		 * */
		public function set systemManager(value:ISystemManager):void
		{
			_systemManager = value;
		}	
		
		private var _usePhasedInstantiation:Boolean = false;
		
		public function get usePhasedInstantiation():Boolean
		{
			return _usePhasedInstantiation;
		}
		public function set usePhasedInstantiation(value:Boolean):void
		{
			//trace("@@@设置usePhasedInstantiation启动,新值为:"+value+"@@@");
			if(_usePhasedInstantiation!=value)
			{
				_usePhasedInstantiation = value;
				try{
					var stage:Stage = _systemManager.stageRoot;
					if(value)
					{
						originalFrameRate = stage.frameRate;
						stage.frameRate = 1000;
					}else{
						stage.frameRate = originalFrameRate;
					}
				}catch(error:Error){
					//SystemErrorManager.traceErrorMsg("run error",this.toString(),error.message);
				}
			}			
		}
		/**
		 * 需要分派updateComplete事件的队列
		 * **/
		private var updateCompleteQueue:PriorityQueue = new PriorityQueue("updateCompleteQueue");
		/**
		 * 延迟显示列表更改标示
		 * */
		private var invalidateDisplayListQueue:PriorityQueue = new PriorityQueue("invalidateDisplayListQueue");
		/** 
		 * 延迟显示列表更改标示
		 * */
		private var invalidateDisplayListFlag:Boolean = false;
		
		/**
		 *  @private
		 * 	延迟帧
		 */
		private var waitedAFrame:Boolean = false;
		
		private var originalFrameRate:Number;
		/**
		 *  @private
		 * 	事件添加标示
		 */
		private var listenersAttached:Boolean = false;
		
		private var currentObject:ILayoutManagerClient;
		
		public function invalidateDisplayList(obj:ILayoutManagerClient ):void
		{
			if(!invalidateDisplayListFlag&&_systemManager)
			{
				invalidateDisplayListFlag = true;
				
				if(!listenersAttached)
				{
					attachListeners(_systemManager);	
				}
			}
			invalidateDisplayListQueue.addObject(obj,obj.nestLevel);
		}

		public function isInvalid():Boolean
		{
			return invalidateDisplayListFlag;
		}
		/**
		 * 为systemManager添加事件
		 * */
		private function attachListeners(systemManager:ISystemManager):void
		{			
			if(!waitedAFrame)
			{
				//trace("@@@添加了waitedAFrame@@@");
				systemManager.addEventListener(Event.ENTER_FRAME,waitAFrameHandler);
			}else{
				systemManager.addEventListener(Event.ENTER_FRAME,doPhasedInstantiationCallback);
				if(!usePhasedInstantiation)
				{
					if(systemManager&&systemManager.stageRoot)
					{
						//trace("@@@为systemManager添加帧事件，监听渲染事件@@@");
						systemManager.addEventListener(Event.RENDER,doPhasedInstantiationCallback);
						systemManager.stageRoot.invalidate();
					}
				}
			}
			listenersAttached = true;
		}
		/**
		 * 延迟一帧处理
		 * **/
		private function waitAFrameHandler(e:Event):void
		{
			//trace("@@@需要等待一帧@@@");
			_systemManager.removeEventListener(Event.ENTER_FRAME,waitAFrameHandler);
			_systemManager.addEventListener(Event.ENTER_FRAME,doPhasedInstantiationCallback);
			waitedAFrame = true;
		}
		/**
		 * 启动三阶段处理
		 * **/
		private function doPhasedInstantiationCallback(e:Event):void
		{
			//trace("@@@监听到渲染事件，即将开始三阶段计算@@@");
			_systemManager.removeEventListener(Event.ENTER_FRAME,doPhasedInstantiationCallback);
			_systemManager.removeEventListener(Event.RENDER,doPhasedInstantiationCallback);
			try{
				doPhasedInstantiation();
			}catch(error:Error){
				//SystemErrorManager.throwError("running error",this.toString(),"layoutManager调用doPhasedInstantiation()报错"+error.message);
			}
		}
		/**
		 * 三阶段处理
		 * **/
		private function doPhasedInstantiation():void
		{
			//trace("@@@layoutManager三阶段处理@@@");
			if(usePhasedInstantiation)
			{
				if(invalidateDisplayListFlag){
					//trace("@@@layoutManager即将启动validateDisplayList@@@");
					validateDisplayList();
					//dispatch event
					_systemManager.documentDisplay.dispatchEvent(new PartEvent(PartEvent.VALIDATEDISPLAYLIST_COMPLETE));
				}
			}else{
				//trace("@@@一次性调用三阶段验证方法@@@");
				if(invalidateDisplayListFlag)
					validateDisplayList();
			}
			
			if(invalidateDisplayListFlag)
			{
				//trace("@@@三个阶段如果还有没进行完的，在下一帧进行设置@@@");
				attachListeners(_systemManager);//三个阶段如果还有没进行完的，在下一帧进行设置
			}else{
				usePhasedInstantiation = false;
				listenersAttached = false;
				var obj:ILayoutManagerClient = ILayoutManagerClient(updateCompleteQueue.removeLargest());
				while(obj)
				{
					if(!obj.initialized)
						obj.initialized = true;
					if(obj.hasEventListener(PartEvent.UPDATE_COMPLETE))
						obj.dispatchEvent(new PartEvent(PartEvent.UPDATE_COMPLETE));
					obj.updateCompletePendingFlag = false;
					obj = ILayoutManagerClient(updateCompleteQueue.removeLargest());
				}
				//trace("@@@三阶段处理完毕派发UPDATE_COMPLETE@@@");
				dispatchEvent(new PartEvent(PartEvent.UPDATE_COMPLETE));
			}
		}
		/**
		 * 使显示列表尺寸位置生效
		 * **/
		private function validateDisplayList():void
		{
			//trace("@@@layoutManager中的validateDisplayList()启动@@@");
			var obj:ILayoutManagerClient = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
			while(obj)
			{
				if(obj.nestLevel)
				{
					currentObject = obj;
					//trace("@@@layoutManager调用"+obj+"的validateDisplayList()@@@");
					obj.validateDisplayList();
					if(!obj.updateCompletePendingFlag)
					{
						updateCompleteQueue.addObject(obj,obj.nestLevel);
						obj.updateCompletePendingFlag = true;
					}
				}
				obj = ILayoutManagerClient(invalidateDisplayListQueue.removeSmallest());
			}
			//trace("@@@检查invalidateDisplayListQueue是否以为空@@@");
			if(invalidateDisplayListQueue.isEmpty())
			{				
				invalidateDisplayListFlag = false;
				//trace("@@@检查invalidateDisplayListQueue已经是空,invalidateDisplayListFlag值为:@@@",invalidateDisplayListFlag);
			}
		}
//===============================================================================
		private static var instance:LayoutManager;
		/**
		 * 获取实例
		 * **/
		public static function getInstance():LayoutManager
		{
			if(LayoutManager.instance==null)
			{
				LayoutManager.instance = new LayoutManager(new PrivateClass());	
			}
			return instance;
		}
		
		public function LayoutManager(pvt:PrivateClass)
		{
		}
	}
}
class PrivateClass
{
	public function PrivateClass():void
	{		
	}
}