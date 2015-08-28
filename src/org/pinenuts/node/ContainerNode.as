package org.pinenuts.node
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.pinenuts.core.pn_internal;
	import org.pinenuts.manager.ClassFactoryManager;
	import org.pinenuts.part.IPart;
	import org.pinenuts.vo.DomNodeVO;

	use namespace pn_internal;
	/**
	 * 容器节点对象
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/
	public class ContainerNode extends Node implements IContainerNode
	{
		//节点列表
		private var nodeList:Vector.<INode>;
		//此节点容器附属的显示对象容器
		pn_internal var partContainer:DisplayObjectContainer;
		
		public function get numNodes():int
		{
			return (nodeList)?nodeList.length:0;
		}		
		
		//========================public======================
		public function ContainerNode()
		{
			super();
			nodeList = new Vector.<INode>();
		}		
		
		public function addNode(node:INode):INode
		{
			if(!node||node===this){
				throw new Error("参数node不能为null,并且不能是容器本身！");
				return null;
			}
			if(node.parentNode){
				var tempNode:IContainerNode = node.parentNode;
				tempNode.removeNode(node);
			}
			if(node){
				nodeList.push(node);
				node.parentNode = this;
				node.initialize();
				if(node is IVisualNode&&partContainer){
					partContainer.addChild(DisplayObject(IVisualNode(node).part));
				}
			}
			return node;
		}
		
		public function addNodeAt(node:INode, index:int):INode
		{
			if(index>nodeList.length||index<0){
				throw new Error("参数index超出节点列表索引！");
				return null;
			}
			if(!node||node===this){
				throw new Error("参数node不能null，并且不是调用者本身！");
				return null;
			}
			if(node is IContainerNode&&IContainerNode(node).contains(this)){
				throw new Error("参数node不能是调用者的父级或更高级！");
				return null;
			}
			if(node.parentNode){
				var tempNode:IContainerNode = node.parentNode;
				tempNode.removeNode(node);
			}
			nodeList.splice(index,0,node);
			node.parentNode = this;
			node.initialize();
			if(node is IVisualNode&&partContainer){
				partContainer.addChildAt(DisplayObject(IVisualNode(node).part),index);
			}
			return node;
		}
		
		public function removeNode(node:INode):INode
		{
			if(!node||nodeList.length==0||nodeList.indexOf(node)<0){
				throw new Error("参数node为null,或者节点列表中并不包含此节点！");
				return null;
			}
			if(partContainer&&node is IVisualNode){
				var vNode:IVisualNode = IVisualNode(node);
				if(vNode.part&&vNode.part is DisplayObject){
					var display:DisplayObject = DisplayObject(vNode.part);
					if(!partContainer.contains(display)){
						throw new Error("参数node中附属的part对象并不是该节点附属DisplayObjectContainer的子级！");
						return null;
					}
					partContainer.removeChild(display);
				}
			}
			nodeList.splice(nodeList.indexOf(node),1);
			node.parentNode = null;
			return node;
		}
		
		public function removeNodeAt(index:int):INode
		{
			if(index>nodeList.length||index<0){
				throw new Error("节点列表中不包含此索引！");
				return null;
			}
			return removeNode(nodeList[index]);
		}
		
		public function removeAllNodes():void
		{
			if(nodeList.length>0){
				nodeList.forEach(removeNode);
			}
		}
		
		public function setNodeIndex(node:INode, index:int):void
		{
			if(index>nodeList.length||index<0){
				throw new Error("节点列表不包含参数index提供的索引！");
				return;
			}
			if(!node||nodeList.indexOf(node)<0){
				throw new Error("节点为null,或者此节点不在节点列表中");
				return;
			}
			var tempNode:INode = nodeList.splice(nodeList.indexOf(node),1)[0];
			nodeList.splice(index,0,tempNode);
		}
		
		public function swapNodes(nodeA:INode, nodeB:INode):void
		{
			if(nodeList.indexOf(nodeA)<0||nodeList.indexOf(nodeB)<0){
				throw new Error("节点列表不包含参数同的节点！");
				return;
			}
			var index1:int = nodeList.indexOf(nodeA);
			var index2:int = nodeList.indexOf(nodeB);
			nodeList.splice(index2,0,nodeA);
			nodeList.splice(index2+1,1);
			nodeList.splice(index1,0,nodeB);
			nodeList.splice(index1+1,1);
			if(nodeA is IVisualNode&&nodeB is IVisualNode){
				var vNodeA:IVisualNode = IVisualNode(nodeA);
				var vNodeB:IVisualNode = IVisualNode(nodeB);
				if(vNodeA.part is DisplayObject&&vNodeB.part is DisplayObject){
					var displayA:DisplayObject = DisplayObject(IVisualNode(nodeA).part);
					var dispalyB:DisplayObject = DisplayObject(IVisualNode(nodeB).part);
					partContainer.swapChildren(displayA,dispalyB);
				}				
			}
		}
		
		public function swapNodesAt(indexA:int, indexB:int):void
		{
			if(inNodeList(indexA)&&inNodeList(indexB)){
				var nodeA:INode = nodeList[indexA];
				var nodeB:INode = nodeList[indexB];
				swapNodes(nodeA,nodeB);
			}
		}
		
		public function getNodeAt(index:int):INode
		{
			return (inNodeList(index))?nodeList[index]:null;
		}
		
		public function getNodeById(id:String):INode
		{
			if(!id){
				throw new Error("参数id为空！");
				return null;
			}
			var node:INode;
			var i:int = numNodes;
			while(i--){
				node = nodeList[i];
				if(node.id==id){
					break;
				}
				node = null;
			}
			return node;
		}
		
		public function getNodeIndex(node:INode):int
		{
			var index:int = nodeList.indexOf(node);
			if(index){
				throw new Error("参数node不在节点列表中！");
			}
			return index;
		}
		
		public function contains(node:INode):Boolean
		{
			if(nodeList.indexOf(node)>0||node===this){
				return true;
			}
			var i:int = numNodes;
			var tempNode:INode;
			while(i--){
				tempNode = nodeList[i];
				if(tempNode is IContainerNode&&IContainerNode(tempNode).contains(node)){
					return true;
				}
			}
			return false;
		}
		
		override public function initialize():void
		{
			super.initialize();
			createNodes();
			nodesCreated();
		}
		
		//==================protected=====================
		/**创建子节点**/
		protected function createNodes():void
		{
			if(_domNodeVO)
			{
				if(_domNodeVO.childNodeIdList&&_domNodeVO.childNodeIdList.length>0)
				{
					var len:int = _domNodeVO.childNodeIdList.length;
					for(var i:int=0;i<len;i++)
					{
						var nodeVO:DomNodeVO = domNodeManager.gainDomNodeVO(_domNodeVO.childNodeIdList[i]);
						var node:INode = ClassFactoryManager.createNode(nodeVO.nodeClassName,nodeVO.domain);						
						if(node)
						{
							this.addNode(node);
						}else{
							throw new Error("part error "+this.toString()+" create the "+nodeVO.nodeClassName+" is error");
							return;
						}
					}
				}
			}
		}
		/**子节点创建完毕**/
		protected function nodesCreated():void
		{
			//override by subClass
		}
		
		override public function createPart():void
		{
			super.createPart();
			if(partDisplay is DisplayObjectContainer){
				partContainer = DisplayObjectContainer(partDisplay);
			}
		}
		
		//=================private==========================
		/**
		 * 节点列表是否包含指定的索引号
		 * @param index 索引号
		 * @return Boolean 是否包含指定索引
		 * **/
		private function inNodeList(index:int):Boolean
		{
			if(index>nodeList.length||index<0){
				throw new Error("节点列表不包含编号为"+index+"的索引！");
				return false;
			}
			return true;
		}
	}
}