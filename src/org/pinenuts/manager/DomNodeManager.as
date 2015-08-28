package org.pinenuts.manager
{	
	import flash.events.EventDispatcher;
	import flash.system.System;
	
	import org.pinenuts.core.IClearableNode;
	import org.pinenuts.core.pn_internal;
	import org.pinenuts.events.SystemImplementEvent;
	import org.pinenuts.vo.DomNodeVO;
	
	use namespace pn_internal;
	
	/**
	 * dom节点管理类
	 * dom节点管理会将配置文件进行解析，分别按照节点id(nodeId)进行保存。节点信息用于组件创建子组件以及配置自身属性。
	 * 
	 * @productversion workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2013.10
	 * **/
	public final class DomNodeManager extends EventDispatcher implements IDomNodeManager,IClearableNode
	{
		private const MUST_PROPERTIES:Vector.<String> = Vector.<String>(["id","nodeId","partClassName",
																		"width","height",
																		"x","y","z",
																		"scaleX","scaleY","scaleZ",
																		"alpha","visible",
																		"rotation","rotationX","rotationY","rotationZ",
																		"srcId","domain",""]);
		
		private var optionBase:SystemOptionBase;

		private var nodeList:Vector.<Vector.<DomNodeVO>>;	//dom节点数据列表,是一个二维数组
		
		/**dom节点数据列表**/
		pn_internal function get nodeVOList():Vector.<Vector.<DomNodeVO>>
		{
			return nodeList;
		}
		
		public function resetNode():void
		{
			//override by subclass
		}
		
		/**
		 * 获取DomNodeVO
		 * DomNodeVO是用于ui配置的数据对象
		 * @param	nodeId 节点id
		 * @return	DomNodeVO 节点配置对象
		 **/
		public function gainDomNodeVO(nodeId:uint):DomNodeVO
		{
			if(nodeId==0)
				return null;
			try{
				var layerIndex:int = nodeId>>16;
				var nodeIndex:int = nodeId>>8 & 0xff;
				return nodeList[layerIndex][nodeIndex];
			}catch(error:Error){
				throw new Error("param error "+"[DomNodeManager] gain DomNodeVO is error");
				return null;
			}
			return null;
		}
		/**
		 * 删除DomNodeVO
		 * @param	nodeId 节点id
		 * **/
		public function deleteDomNodeVO(nodeId:uint):void
		{
			if(nodeId==0)
				return;
			var layerIndex:int = nodeId>>16;
			var nodeIndex:int = nodeId>>8 & 0xff;
			var domNodeVO:DomNodeVO = nodeList[layerIndex][nodeIndex];
			if(domNodeVO)
			{
				domNodeVO.termiClear();
				nodeList[layerIndex][nodeIndex] = null;
			}
		}
		/**
		 * 清除节点列表<br />
		 * 清空节点列表，将属性置为null，同时删除列表中的所有DomNodeVO
		 * **/
		public function clearDomNodeVOList():void
		{
			var len:int = nodeList.length;
			if(len>0){
				while(len--){
					var list:Vector.<DomNodeVO> = nodeList[len];
					var len2:int=list.length;
					if(len2>0){
						while(len2--){
							var domNodeVO:DomNodeVO = list[len];
							if(domNodeVO)
								domNodeVO.termiClear();
							list[len] = null;
						}
					}
				}
			}
			nodeList = null;
		}		
		/**
		 * 处理节点信息 
		 * @param	domXML dom配置xml
		 * @param	resultHandler 结果回调函数
		 **/
		public function tidyDomNode(domXML:XML,resultFn:Function):void
		{
			if(domXML)
			{
				try{
					nodeList = new Vector.<Vector.<DomNodeVO>>();
					var loopList:Vector.<XML> = new Vector.<XML>();		//参与循环列表
					var nextList:Vector.<XML> = new Vector.<XML>();		//下一层级列表
					loopList[0] = domXML;
					var layerIndex:int = 0;		//层级索引
					var nodeXml:XML = null;
					var childrenList:XMLList = null;
					var childrenNum:int = 0;
					var tempList:Vector.<XML>;
					
					while(loopList.length>0){
						nodeList[layerIndex] = new Vector.<DomNodeVO>();		//每一层级新建一个节点数组				
						for(var i:int=0,len:int = loopList.length;i<len;i++){
							nodeXml = loopList[i];
							childrenList = nodeXml.children()
							childrenNum = childrenList.length();
							loopList[i].@nodeId = ((layerIndex>9)?"0x":"0x0")+(layerIndex<<16 | i<<8 | childrenNum).toString(16);
							createNodeVO(nodeXml,layerIndex,i);	//处理节点属性	
							
							if(childrenNum>0){						
								tempList = xmlListToVector(nodeXml.children(),loopList[i].@nodeId);
								if(!tempList)
									continue;
								for(var j:int = 0;j<childrenNum;j++){
									nextList.push(tempList[j]);
								}
							}
						}
						loopList = nextList;
						nextList = new Vector.<XML>();
						layerIndex++;				
					}
					
					if(resultFn!=null)
					{
						resultFn();
					}else{
						this.dispatchEvent(new SystemImplementEvent(SystemImplementEvent.DOM_TIDY_DONE));
					}					
				}catch(error:Error){
					error.message += "param error "+this.toString()+" tidyDomNode()";
					throw error;
					return;
				}
				System.disposeXML(domXML);
			}else{
				throw new Error("param error "+this.toString()+" tidyDomNode() domXML is null");
			}
		}
		
		public function termiClear():void
		{
			clearDomNodeVOList();
		}
		
		public function clearDone():void
		{
			
		}
		
		/**
		 * 创建dom配置对象
		 * @param	nodeXML 节点xml
		 **/
		private function createNodeVO(nodeXML:XML,layerIndex:int,nodeIndex:int):void
		{		
			var domNodeVO:DomNodeVO = new DomNodeVO();
			domNodeVO.nodeId = (nodeXML.@nodeId)?uint(nodeXML.@nodeId):0;
			domNodeVO.id = (nodeXML.@id)?nodeXML.@id:"";
			var className:String = nodeXML.name();
			domNodeVO.nodeClassName = (className)?className:"";
			domNodeVO.partClassName = (nodeXML.@partClassName)?nodeXML.@partClassName:"";
			
			domNodeVO.width = (nodeXML.@width)?Number(nodeXML.@width):0;
			domNodeVO.height = (nodeXML.@height)?Number(nodeXML.@height):0;
			
			domNodeVO.x = (nodeXML.@x)?Number(nodeXML.@x):0;
			domNodeVO.y = (nodeXML.@y)?Number(nodeXML.@y):0;
			domNodeVO.z = (nodeXML.@z)?Number(nodeXML.@z):0;
			
			domNodeVO.scaleX = (!isNaN(nodeXML.@scaleX[0]))?Number(nodeXML.@scaleX):1;
			domNodeVO.scaleY = (!isNaN(nodeXML.@scaleY[0]))?Number(nodeXML.@scaleY):1;
			domNodeVO.scaleZ = (!isNaN(nodeXML.@scaleZ[0]))?Number(nodeXML.@scaleZ):1;
			
			domNodeVO.alpha = (!isNaN(nodeXML.@alpha[0]))?Number(nodeXML.@alpha):1;
			domNodeVO.visible = (nodeXML.@visible==="true")?true:false;
			domNodeVO.enable = (nodeXML.@enable==="true")?true:false;
			
			domNodeVO.rotation = (!isNaN(nodeXML.@rotation[0]))?Number(nodeXML.@rotation):0;
			domNodeVO.rotationX = (!isNaN(nodeXML.@rotationX[0]))?Number(nodeXML.@rotationX):0;
			domNodeVO.rotationY = (!isNaN(nodeXML.@rotationY[0]))?Number(nodeXML.@rotationY):0;
			domNodeVO.rotationZ = (!isNaN(nodeXML.@rotationZ[0]))?Number(nodeXML.@rotationZ):0;

			domNodeVO.domain =(nodeXML.@domain==="skin")?optionBase.skinDomain:optionBase.rootDomain;
			domNodeVO.srcId = (nodeXML.@srcId)?uint(nodeXML.@srcId):0;
			
			domNodeVO.childIndex = nodeXML.childIndex();
			domNodeVO.definedProperties = handleDefinedProperties(nodeXML);
			//将自己的nodeId存入父节点的vo中
			var parentNodeVO:DomNodeVO = gainDomNodeVO(uint(nodeXML.@parentNodeId));			
			if(parentNodeVO){
				parentNodeVO.childNodeIdList ||= new Vector.<uint>();
				parentNodeVO.childNodeIdList.push(domNodeVO.nodeId);
			}			
			
			//domNodeVO.xml = nodeXML;	//test
			
			var list:Vector.<DomNodeVO> = nodeList[layerIndex];
			if(list){
				list[nodeIndex] = domNodeVO;
			}
		}
		/**
		 * 处理自定义属性
		 * 将组件特有的属性保存在关联数组中
		 * @param 节点xml
		 * @return	保存特有属性的关联数组或者null(没有特有属性) 
		 * **/
		private function handleDefinedProperties(nodeXML:XML):Object
		{
			var ppList:XMLList = nodeXML.attributes();
			var len:int = ppList.length();
			if(len==0)
				return null;
			var obj:Object = {};
			for(var i:int=0;i<len;i++)
			{
				var value:XML = ppList[i];
				var key:String = value.localName();
				if(MUST_PROPERTIES.indexOf(key)>-1)
				{
					continue;
				}else{
					obj[key] = value;
				}
			}
			return obj;
		}		
		/**
		 * 将XMLList数组转换成Vector.<XML>数组
		 * @param	xmlList XMLList数组
		 * @return	Vector.<XML>
		 * **/
		private function xmlListToVector(xmlList:XMLList,parentNodeId:String):Vector.<XML>
		{
			var list:Vector.<XML> = new Vector.<XML>();
			var xml:XML;
			for(var i:int=0,len:int = xmlList.length();i<len;i++){
				xml = xmlList[i];
				list[i] = XML(xml.toXMLString());
				list[i].@parentNodeId = parentNodeId;
			}
			return (list.length>0)?list:null;
		}
		
		private function sortNodeId(nodeXML:XML):uint
		{			
			return 0;
		}
		
//========================================================
		private static var instance:DomNodeManager;		
		
		public function DomNodeManager(pvt:PrivateClass)
		{
			optionBase = SystemOptionBase.getInstance();
		}
		
		public static function getInstance():DomNodeManager
		{
			if(!instance)
			{
				instance = new DomNodeManager(new PrivateClass());
			}
			return instance;
		}
	}
}
class PrivateClass
{
	public function PrivateClass():void
	{		
	}
}