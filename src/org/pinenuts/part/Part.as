package org.pinenuts.part
{	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import org.pinenuts.core.GlobalEnmu;
	import org.pinenuts.core.IClearableNode;
	import org.pinenuts.core.pn_internal;
	import org.pinenuts.events.PartEvent;
	import org.pinenuts.manager.ILayoutManager;
	import org.pinenuts.manager.ILayoutManagerClient;
	import org.pinenuts.manager.ISystemManager;
	import org.pinenuts.manager.ISystemManagerClient;
	import org.pinenuts.manager.SingletonManager;
	import org.pinenuts.manager.SystemOptionBase;
	import org.pinenuts.node.IVisualNode;

	use namespace pn_internal;

	/**
	 * 零件类 <br />
	 * 零件类是所有组件和容器的根类 <br />
	 * 继承：Part>>Sprite <br />
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8.15
	 * */
	public class Part extends Sprite implements IPart,IClearableNode,ILayoutManagerClient,ISystemManagerClient
	{
//=====================properties==============================================
		pn_internal var invalidateDisplayListFlag:Boolean = false;	//是否调用此组件的updateDisplayList()方法
		
		
		private var _node:IVisualNode;

		public function get node():IVisualNode
		{
			return _node;
		}

		public function set node(value:IVisualNode):void
		{
			_node = value;
		}
		
		/**是否在舞台的显示列表中**/
		public function get inDisplayList():Boolean
		{
			return (stage)?true:false;
		}
		
		protected var _layoutManager:ILayoutManager;
		public function get layoutManager():ILayoutManager
		{
			if(!_layoutManager)
			{
				if(SingletonManager.isRegistered(GlobalEnmu.INTERFACE_LAYOUT_MANAGER)){
					_layoutManager = ILayoutManager(SingletonManager.getInstance(GlobalEnmu.INTERFACE_LAYOUT_MANAGER));
				}
			}
			return _layoutManager;
		}
		
		//是否等待分配updateComplete事件
		protected var _updateCompletePendingFlag:Boolean = false;
		
		public function get updateCompletePendingFlag():Boolean
		{
			return _updateCompletePendingFlag;
		}

		public function set updateCompletePendingFlag(value:Boolean):void
		{
			_updateCompletePendingFlag = value;
		}
		
		protected var _initialized:Boolean = false;

		public function get initialized():Boolean
		{
			return _initialized;
		}

		public function set initialized(value:Boolean):void
		{
			_initialized = value;
			if(value)
			{
				this.visible = value;
				//trace("===Part发出CREATION_COMPLETE事件，界面可见===",this.toString(),width,height,assignWidth,assignHeight);
				var partEvent:PartEvent = new PartEvent(PartEvent.CREATION_COMPLETE);
				partEvent.id = id;
				this.dispatchEvent(partEvent);
			}
		}
		
		protected var _nestLevel:int = 0;

		public function get nestLevel():int
		{
			return _nestLevel;
		}

		public function set nestLevel(value:int):void
		{
			_nestLevel = value;
		}	
		
		protected var _systemManager:ISystemManager;
		
		public function get systemManager():ISystemManager
		{
			return _systemManager;
		}
		
		public function set systemManager(value:ISystemManager):void
		{
			_systemManager = value;
		}	
		
		protected var _id:String = "";
		public function get id():String
		{
			return _id;
		}
		public function set id(value:String):void
		{
			if(_id!=value)
			{
				_id = value;
				if(_id!=name){
					name = _id;
				}
			}
		}	
		
		private var _enable:Boolean = true;
		
		public function get enable():Boolean
		{
			return _enable;
		}
		
		public function set enable(value:Boolean):void
		{
			if(_enable!=value)
			{
				_enable = value;
				super.mouseChildren = value;
				super.mouseEnabled = value;
			}
		}
		
//=======================override properties======================================
		protected var xyzChanged:Boolean = false;
		protected var _x:Number = 0;
		override public function set x(value:Number):void
		{
			if(_x!=value){
				xyzChanged = true;
				_x = value;
				invalidateDisplayList();
			}
		}
		
		override public function get x():Number{
			return (xyzChanged)?_x:super.x;
		}

		protected var _y:Number = 0;
		override public function set y(value:Number):void
		{
			if(_y!=value){
				xyzChanged = true;
				_y = value;
				invalidateDisplayList();
			}
		}

		override public function get y():Number{
			return (xyzChanged)?_y:super.y;
		}

		protected var _z:Number = 0;
		override public function set z(value:Number):void
		{
			if(_z!=value){
				xyzChanged = true;
				_z = value;
				invalidateDisplayList();
			}
		}

		override public function get z():Number{
			return (xyzChanged)?_z:super.z;
		}

		protected var sizeChanged:Boolean = false;
		protected var _width:Number = 0;

		override public function set width(value:Number):void
		{
			if(_width!=value){
				sizeChanged = true;
				_width = value;
				//要加上派发resize事件？
				invalidateDisplayList();
			}
		}

		override public function get width():Number
		{
			return (sizeChanged)?_width:super.width;
		}

		protected var _height:Number = 0;

		override public function set height(value:Number):void
		{
			if(_height!=value){
				sizeChanged = true;
				_height = value;
				//要加上派发resize事件？
				invalidateDisplayList();
			}
		}

		override public function get height():Number
		{
			return (sizeChanged)?_height:super.height;
		}

		protected var rotationChanged:Boolean = false;
		protected var _rotation:Number = 0;
		override public function get rotation():Number
		{
			return (rotationChanged)?_rotation:super.rotation;
		}

		override public function set rotation(value:Number):void
		{
			if(_rotation!=value){
				_rotation = value;
				rotationChanged = true;
				invalidateDisplayList();
			}
		}

		protected var rotation3DChanged:Boolean = false;
		protected var _rotationX:Number = 0;

		override public function get rotationX():Number
		{
			return (rotation3DChanged)?_rotationX:super.rotationX;
		}

		override public function set rotationX(value:Number):void
		{
			if(_rotationX!=value){
				rotation3DChanged = true;
				_rotationX = value;
				invalidateDisplayList();
			}
		}

		protected var _rotationY:Number = 0;

		override public function get rotationY():Number
		{
			return (rotation3DChanged)?_rotationY:super.rotationY;
		}

		override public function set rotationY(value:Number):void
		{
			if(_rotationY!=value){
				rotation3DChanged = true;
				_rotationY = value;
				invalidateDisplayList();
			}
		}

		protected var _rotationZ:Number = 0;

		override public function get rotationZ():Number
		{
			return (rotation3DChanged)?_rotationZ:super.rotationZ;
		}

		override public function set rotationZ(value:Number):void
		{
			if(_rotationZ!=value){
				rotation3DChanged = true;
				_rotationZ = value;
				invalidateDisplayList();
			}
		}

		protected var alphaChanged:Boolean = false;
		protected var _alpha:Number = 1;
		override public function set alpha(value:Number):void
		{
			if(_alpha!=value){
				_alpha = value;
				alphaChanged = true;
				invalidateDisplayList();
			}
		}
		override public function get alpha():Number
		{
			return (alphaChanged)?_alpha:super.alpha;
		}

		protected var visibleChanged:Boolean = false;
		protected var _visible:Boolean = true;
		override public function set visible(value:Boolean):void
		{
			if(_visible!=value){
				_visible = value;
				visibleChanged = true;
				invalidateDisplayList();
			}
		}

		override public function get visible():Boolean
		{
			return (visibleChanged)?_visible:super.visible;
		}
		
		protected var scaleChanged:Boolean = false;
		protected var _scaleY:Number = 1;
		override public function set scaleY(value:Number):void
		{
			if(_scaleY!=value){
				scaleChanged = true;
				_scaleY = value;
				invalidateDisplayList();
			}
		}

		override public function get scaleY():Number
		{
			return (scaleChanged)?_scaleY:super.scaleY;
		}

		protected var _scaleZ:Number = 1;
		override public function set scaleZ(value:Number):void
		{
			if(_scaleZ!=value){
				scaleChanged = true;
				_scaleZ = value;
				invalidateDisplayList();
			}
		}

		override public function get scaleZ():Number
		{
			return (scaleChanged)?_scaleZ:super.scaleX;
		}

		protected var _scaleX:Number = 1;
		override public function set scaleX(value:Number):void
		{
			if(_scaleX!=value){
				scaleChanged = true;
				_scaleX = value;
				invalidateDisplayList();
			}
		}

		override public function get scaleX():Number
		{
			return (scaleChanged)?_scaleX:super.scaleX;
		}

//=====================public function============================================	
		public function Part()
		{
			super();
			this.visible = false;
		}

		public function initialize():void
		{
			if(initialized)
				return;
			dispatchEvent(new PartEvent(PartEvent.PREV_INITIALIZE));
			
			//根据配置文件设置各项属性
			if(node){
				node.syncProperties();
			}

			createChildren();
			childrenCreated();
		}

		public function invalidateDisplayList():void
		{
			if(!invalidateDisplayListFlag)
			{
				invalidateDisplayListFlag = true;
				if(nestLevel&&layoutManager)
				{
					//trace("===启动layoutManager的invalidateDisplayList===",this.toString());
					layoutManager.invalidateDisplayList(this);
				}
			}
		}

		public function validateDisplayList():void
		{
			//trace("===validateDisplayList启动===",this.toString());
			if(invalidateDisplayListFlag)
			{
				updateDisplayList();
				invalidateDisplayListFlag = false;
			}
		}	

		public function termiClear():void
		{
			if(_systemManager)
				_systemManager = null;
			if(_layoutManager)
				_layoutManager = null;
			if(numChildren>0)
				clearAllElements();
		}

		public function resetNode():void
		{
			//override by subclass
		}
		
		public function clearDone():void
		{
			//override by subclass
		}

		public function clearAllElements():void
		{
			if(!numChildren>0)
				return;
			var systemManagerGlobals:SystemOptionBase = SystemOptionBase.getInstance();
			if(systemManagerGlobals.playerVersion<11)
			{
				while(numChildren>0)
				{
					removeChildAt(0);
				}
			}else{
				removeChildren();
			}
		}
		
		public function syncOtherProperties(properties:Object):void
		{

		}
		
//===========================override public==========================================
		override public function addChild(child:DisplayObject):DisplayObject
		{
			addingChild(child);
			super.addChild(child);
			childadded(child);
			return child;
		}
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			addingChild(child);
			super.addChildAt(child,index);
			childadded(child);
			return child;
		}
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			removingChild(child);
			super.removeChild(child);
			childRemoved(child);
			return child;
		}
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			removingChild(child);
			super.removeChildAt(index);
			childRemoved(child);
			return child;
		}

//============================pn_internal Method======================================
		/**
		 * 添加子对象之前处理
		 **/
		pn_internal function addingChild(child:DisplayObject):void
		{
			//first set document property
			//document=?
			if(child is ILayoutManagerClient)
				ILayoutManagerClient(child).nestLevel = nestLevel+1;
		}
		/**
		 * 添加子对象之后处理
		 **/
		pn_internal function childadded(child:DisplayObject):void
		{
			try
			{
				if(child is Part)
				{
					if(!Part(child).initialized)
						Part(child).initialize();
				}else if(child is IPart){
					IPart(child).initialize();
				}
			}catch(error:Error){
				error.message+= " initialize Error"+this.toString()+"call initialize error";
				throw error;
			}
		}
		/**
		 * 删除子对象之前处理
		 **/
		pn_internal function removingChild(child:DisplayObject):void
		{
		}
		/**
		 * 删除子对象之后处理
		 **/
		pn_internal function childRemoved(child:DisplayObject):void
		{
			//delete child's document
			//call parent this part's parent changed
		}
//=====================================================================
		protected function createChildren():void
		{
			//override by subclass
		}
		protected function childrenCreated():void
		{
			this.addEventListener(PartEvent.STATE_CHANGE,onStateChangeHandler);
			gainChildReference();
			if(node){
				var partDic:Dictionary = new Dictionary(true);
				node.syncPart(partDic);
			}
			invalidateDisplayList();
		}
		/**
		 * 状态改变事件
		 * **/
		protected function onStateChangeHandler(e:PartEvent):void
		{
			//override by subclass
		}
		/**
		 * 获取子对象的引用
		 * **/
		protected function gainChildReference():void
		{
			//instance override
		}		
		
		/**
		 * 更新显示状态
		 * **/
		protected function updateDisplayList():void
		{
			if(xyzChanged){
				xyzChanged = false;
				super.x = _x;
				super.y = _y;
				super.z = _z;
			}
			
			if(rotationChanged){
				rotationChanged = false;
				super.rotation = _rotation;
			}
			
			if(rotation3DChanged){
				rotation3DChanged = false;
				super.rotationX = _rotationX;
				super.rotationY = _rotationY;
				super.rotationZ = _rotationZ;
			}
			
			if(sizeChanged){
				sizeChanged = false;
				//加入对resize处理
				super.width = _width;
				super.height = _height;
				drawBg();
			}
			
			if(alphaChanged){
				alphaChanged = false;
				super.alpha = _alpha;
			}
			
			if(visibleChanged){
				visibleChanged = true;
				super.visible = _visible;
			}
		}
		
		protected function drawBg():void
		{
			graphics.beginFill(0x000000,0);
			graphics.drawRect(0,0,_width,_height);
			graphics.endFill();
		}
	}
}