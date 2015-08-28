package org.pinenuts.node
{
	/**
	 * 容器节点对象接口
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/
	public interface IContainerNode
	{
		/**
		 * 返回此对象的子项数目。
		 * **/
		function get numNodes():int;
		/**
		 * 将一个INode子实例添加到该 IContainerNode实例中。
		 * @param node INode对象实例
		 * 
		 * @return INode对象实例
		 * **/
		function addNode(node:INode):INode;
		/**
		 * 将一个INode子实例添加到该 IContainerNode实例中。该子项将被添加到指定的索引位置。
		 * @param	node INode对象实例
		 * 
		 * @return INode对象实例
		 * **/
		function addNodeAt(node:INode,index:int):INode;
		/**
		 * 将一个INode子实例从该 IContainerNode实例中移除。
		 * @param node INode对象实例
		 * 
		 * @return INode对象实例
		 * **/
		function removeNode(node:INode):INode;
		/**
		 * 将一个INode子实例从该 IContainerNode实例中移除。该子项将从指定的索引位置移除。
		 * @param	index 索引号
		 * 
		 * @return INode对象实例
		 * **/
		function removeNodeAt(index:int):INode;
		/**
		 * 将该 IContainerNode实例中包含的所有INode实例移除。
		 * **/
		function removeAllNodes():void;
		/**
		 * 更改现有子项在显示对象容器中的位置。
		 * @param node INode对象实例
		 * @param index 目标索引
		 * **/
		function setNodeIndex(node:INode,index:int):void;
		/**
		 * 交换两个指定子INode对象在node列表中的顺序。
		 * @param nodeA INode对象实例
		 * @param nodeB INode对象实例
		 * **/
		function swapNodes(nodeA:INode,nodeB:INode):void;
		/**
		 * 在node列表中两个指定的索引位置，交换子对象的顺序。
		 * @param indexA INode对象实例在列表中的索引
		 * @param indexB INode对象实例在列表中的索引
		 * **/
		function swapNodesAt(indexA:int,indexB:int):void;
		/**
		 * 在指定的索引位置获取INode对象。
		 * @param index INode对象实例在列表中的索引
		 * @return INode对象实例
		 * **/
		function getNodeAt(index:int):INode;
		/**
		 * 返回具有指定id名称的INode。
		 * @param id INode的id对象
		 * @return INode对象实例
		 * **/
		function getNodeById(id:String):INode;
		/**
		 * 返回具有指定INode对象实例的索引。
		 * @param node INode对象实例
		 * @return INode对象实例的索引
		 * **/
		function getNodeIndex(node:INode):int;
		/**
		 * 确定指定显示对象是 INode实例的子项还是该实例本身。
		 * @param node INode对象实例
		 * @return 如果node对象是 IContainerNode的子项或容器本身，则为 true；否则为 false。
		 * **/
		function contains(node:INode):Boolean;
	}
}