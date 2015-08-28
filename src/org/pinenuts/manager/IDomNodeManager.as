package org.pinenuts.manager
{	
	import flash.events.IEventDispatcher;
	
	import org.pinenuts.vo.DomNodeVO;
	
	/**
	 * 节点配置管理对象接口
	 * <p>节点配置管理对象用来处理和分析节点xml文档，并创建节点配置vo保存在列表。
	 * 在节点初始化，更换皮肤等需要获取配置属性操作时，由此提供相应的服务</p>
	 * 
	 * @productversion pinenuts 2.0
	 * @author	晨光熹微<br />
	 * date		2014.8
	 * **/	
	public interface IDomNodeManager extends IEventDispatcher
	{
		/**
		 * 节点配置vo列表
		 * 
		 * @param Dictionary 节点列表
		 * **/
		//function get nodeVOList():Dictionary;
		/**
		 * 获取节点配置vo
		 * @param nodeId 节点id号
		 * **/
		function gainDomNodeVO(nodeId:uint):DomNodeVO;
		/**
		 * 删除节点配置vo
		 * @param	nodeId 节点id号
		 * **/
		function deleteDomNodeVO(nodeId:uint):void;
		/**
		 * 清理节点配置vo列表
		 * **/
		function clearDomNodeVOList():void;
		/**
		 * 整理节点文档
		 * 
		 * <p>节点xml文档经过整理，将生成节点配置vo列表，每一个vo对应一个nodeId。</p>
		 * 
		 * @param domXML 节点xml文档
		 * @param resultHandler 结果处理器回调
		 * **/
		function tidyDomNode(domXML:XML,resultHandler:Function):void;
	}
}