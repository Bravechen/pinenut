package org.pinenuts.node
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import org.pinenuts.core.GlobalEnmu;
	import org.pinenuts.core.IClearableNode;
	import org.pinenuts.core.IDomNode;
	import org.pinenuts.core.pn_internal;
	import org.pinenuts.manager.ClassFactoryManager;
	import org.pinenuts.manager.IDomNodeManager;
	import org.pinenuts.manager.SingletonManager;
	import org.pinenuts.part.IPart;
	import org.pinenuts.vo.DomNodeVO;
	
	use namespace pn_internal;
	/**
	 * 节点对象
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/
	public class Node extends EventDispatcher implements INode,IVisualNode,IDomNode,IClearableNode
	{		
		pn_internal var partDisplay:DisplayObject;		
		
		pn_internal var domNodeManager:IDomNodeManager;		
		
		//========================properties================================
		private var initialized:Boolean = false;
		
		private var _partClassName:String;

		public function get partClassName():String
		{
			return _partClassName;
		}

		public function set partClassName(value:String):void
		{
			if(_partClassName!=value)
			{
				_partClassName = value;
				if(_part){
					deletePart();
				}
				createPart();
			}			
		}
		
		pn_internal var _part:IPart;

		public function get part():IPart
		{
			return _part;
		}
		
		public function set x(value:Number):void
		{
			if(partDisplay)
				partDisplay.x = value;
		}
		
		public function get x():Number
		{
			return (partDisplay)?partDisplay.x:0;
		}
		
		public function set y(value:Number):void
		{
			if(partDisplay)
				partDisplay.y = value;
		}
		
		public function get y():Number
		{
			return (partDisplay)?partDisplay.y:0;
		}
		
		public function set z(value:Number):void
		{
			if(partDisplay)
				partDisplay.z = value;
		}
		
		public function get z():Number
		{
			return (partDisplay)?partDisplay.z:0;
		}	
		
		public function set width(value:Number):void
		{
			if(partDisplay)
				partDisplay.width = value;
		}
		public function get width():Number
		{
			return (partDisplay)?partDisplay.width:0;
		}
		
		public function set height(value:Number):void
		{
			if(partDisplay)
				partDisplay.height = value;
		}
		public function get height():Number
		{
			return (partDisplay)?partDisplay.height:0;
		}
		
		public function set alpha(value:Number):void
		{
			if(partDisplay)
				partDisplay.alpha = value;
		}
		
		public function get alpha():Number
		{
			return (partDisplay)?partDisplay.alpha:1;
		}
		
		public function set visible(value:Boolean):void
		{
			if(partDisplay)
				partDisplay.visible = value;
		}
		
		public function get visible():Boolean
		{
			return (partDisplay)?partDisplay.visible:true;
		}
		
		public function set scaleX(value:Number):void
		{
			if(partDisplay)
				partDisplay.scaleX = value;
		}
		
		public function get scaleX():Number
		{
			return (partDisplay)?partDisplay.scaleX:1;
		}
		
		public function set scaleY(value:Number):void
		{
			if(partDisplay)
				partDisplay.scaleY = value;
		}
		
		public function get scaleY():Number
		{
			return (partDisplay)?partDisplay.scaleY:1;
		}
		
		public function set scaleZ(value:Number):void
		{
			if(partDisplay)
				partDisplay.scaleZ = value;
		}
		
		public function get scaleZ():Number
		{
			return (partDisplay)?partDisplay.scaleZ:1;
		}
		
		public function set rotation(value:Number):void
		{
			if(partDisplay)
				partDisplay.rotation = value;
		}
		
		public function get rotation():Number
		{
			return (partDisplay)?partDisplay.rotation:0;
		}
		
		private var _rotationX:Number = 0;
		
		public function set rotationX(value:Number):void
		{
			if(partDisplay)
				partDisplay.rotationX = value;
		}
		
		public function get rotationX():Number
		{
			return (partDisplay)?partDisplay.rotationX:0;
		}
		
		private var _rotationY:Number = 0;
		
		public function set rotationY(value:Number):void
		{
			if(partDisplay)
				partDisplay.rotationY = value;
		}
		
		public function get rotationY():Number
		{
			return (partDisplay)?partDisplay.rotationY:0;
		}
		
		private var _rotationZ:Number = 0;
		
		public function set rotationZ(value:Number):void
		{
			if(partDisplay)
				partDisplay.rotationZ = value;
		}
		
		public function get rotationZ():Number
		{
			return (partDisplay)?partDisplay.rotationZ:0;
		}
		
		private var _parentNode:IContainerNode;

		public function set parentNode(value:IContainerNode):void
		{
			if(_parentNode!==value){
				_parentNode = value;
			}
		}
		
		public function get parentNode():IContainerNode
		{
			return _parentNode;
		}
		
		private var _enable:Boolean = true;
		
		public function set enable(value:Boolean):void
		{
			if(_enable!=value){
				_enable = value;
				_part.enable = _enable;
			}
		}
		
		public function get enable():Boolean
		{
			return _enable;
		}
		
		private var _id:String = "";
		
		public function set id(value:String):void
		{
			if(_id!=value){
				_id = value;
				if(_part){
					_part.id = _id+"Part";
					if(partDisplay)
						partDisplay.name = _part.id;
				}
			}
		}		
		
		public function get id():String
		{
			return _id;
		}
		
		pn_internal var _nodeId:uint;

		public function get nodeId():uint
		{
			return _nodeId;
		}

		public function set nodeId(value:uint):void
		{
			if(_nodeId!=value){
				_nodeId = value;
			}
		}

		pn_internal var _domNodeVO:DomNodeVO;

		public function get domNodeVO():DomNodeVO
		{
			return _domNodeVO;
		}
		
		//=========================public=================================
		public function Node()
		{
			
		}
		
		public function initialize():void
		{
			if(initialized)
				return;
			domNodeManager = IDomNodeManager(SingletonManager.getInstance(GlobalEnmu.INTERFACE_LAYOUT_MANAGER));
			if(domNodeManager)
			{
				_domNodeVO = domNodeManager.gainDomNodeVO(nodeId);
				if(!_domNodeVO)
				{
					throw new Error("create error,"+this.toString()+" gain domNodeVO is null");
				}
			}
			createPart();
		}
		
		public function resetNode():void
		{
			//override by subclass
		}
		
		public function clearDone():void
		{
			//override by subclass
		}
		
		public function termiClear():void
		{
			//override by subclass
		}
		
		public function optionDefinedProperties():void
		{
			//override by subclass
		}
		/**
		 * 创建可视化的零件
		 * **/
		public function createPart():void{
			if(_part)
				return;
			var dispaly:DisplayObject = ClassFactoryManager.creatDisplay(_partClassName,_domNodeVO.domain);
			if(dispaly is IPart){
				_part = IPart(dispaly);
				_part.node = this;
				partDisplay = dispaly;
			}
			syncProperties();
			if(this.parentNode&&this.parentNode is IVisualNode){
				var vNode:IVisualNode = IVisualNode(this.parentNode);
				if(vNode.part is DisplayObjectContainer){
					var container:DisplayObjectContainer = DisplayObjectContainer(vNode.part);
					container.addChildAt(partDisplay,displayListindex);
				}
			}
		}
		pn_internal var displayListindex:int = 0;
		/**
		 * 删除此节点伴生的可视化零件
		 * **/
		public function deletePart():void{
			if(!_part)
				return;
			if(partDisplay.parent){
				displayListindex = partDisplay.parent.getChildIndex(partDisplay);
				partDisplay.parent.removeChild(partDisplay);
			}
			_part.node = null;
			if(_part is IClearableNode)
			{
				IClearableNode(_part).termiClear();
			}
			_part = null;
			partDisplay = null;
		}
		/**
		 * 同步零件
		 * **/
		public function syncPart(partDic:Dictionary):void{
			//override by subclass
		}
		
		public function syncProperties():void
		{
			if(!_part)
				return;
			_domNodeVO ||= domNodeManager.gainDomNodeVO(_nodeId);
			if(_domNodeVO){				
				id = _domNodeVO.id;				
				x = _domNodeVO.x;
				y = _domNodeVO.y;
				width = _domNodeVO.width;
				height = _domNodeVO.height;
				alpha = _domNodeVO.alpha;
				visible = _domNodeVO.visible;
				rotation = _domNodeVO.rotation;
				rotationX = _domNodeVO.rotationX;
				rotationY = _domNodeVO.rotationY;
				rotationZ = _domNodeVO.rotationZ;
				scaleX = _domNodeVO.scaleX;
				scaleY = _domNodeVO.scaleY;
				scaleZ = _domNodeVO.scaleZ;
				enable = _domNodeVO.enable;
				_part.syncOtherProperties(_domNodeVO.definedProperties);
				optionDefinedProperties();
			}			
		}
		
		override public function toString():String
		{
			return "[Node"+" "+this.id+"]";
		}
		
		//===================protected==========================
		
	}
}