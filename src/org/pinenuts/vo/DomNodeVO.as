package org.pinenuts.vo
{
	import flash.system.ApplicationDomain;	
	
	import org.pinenuts.core.pn_internal;
	
	use namespace pn_internal;

	/**
	 * dom节点配置类
	 * dom节点配置保存了配置文件中设置各项组件信息。
	 * 
	 * @productversion workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2013.10
	 * **/
	public final class DomNodeVO
	{
		pn_internal var nodeId:uint;					//节点id序号
		pn_internal var id:String;						//节点id名称
		pn_internal var nodeClassName:String;			//节点的类全名
		pn_internal var partClassName:String;			//零件类全名
		
		pn_internal var width:Number = 0;				//宽
		pn_internal var height:Number = 0;				//高
		
		pn_internal var x:Number = 0;					//x轴坐标
		pn_internal var y:Number = 0;					//y轴坐标
		pn_internal var z:Number = 0;					//z轴坐标
		
		pn_internal var scaleX:Number = 1;				//x轴缩放量
		pn_internal var scaleY:Number = 1;				//y轴缩放量
		pn_internal var scaleZ:Number = 1;				//z轴缩放量
		
		pn_internal var alpha:Number = 1;				//透明度
		pn_internal var visible:Boolean = true;			//可见性
		pn_internal var enable:Boolean = true;			//可用性
		
		pn_internal var rotation:Number = 0;			//旋转角度
		pn_internal var rotationX:Number = 0;			//x旋转轴角度
		pn_internal var rotationY:Number = 0;			//y旋转轴角度
		pn_internal var rotationZ:Number = 0;			//z旋转轴角度

		pn_internal var domain:ApplicationDomain = null;//隶属的域
		pn_internal var srcId:uint = 0;					//使用的资源id
		
		pn_internal var definedProperties:Object;		//组件特有属性集合
		
		pn_internal var childIndex:uint = 0;			//节点的层级id
		pn_internal var childNodeIdList:Vector.<uint>;	//子组件nodeId集合
		
		public function DomNodeVO()
		{
		}

		public function termiClear():void
		{
			if(definedProperties)
			{
				for(var key:String in definedProperties)
				{
					delete definedProperties[key];
				}
				definedProperties = null;
			}
			if(childNodeIdList)
			{
				var len:int = childNodeIdList.length;
				for(var i:int=len;i>=0;i--)
				{
					childNodeIdList[i]=null;
				}
				childNodeIdList = null;
			}
		}

		public function clearDone():void
		{
		}
		
		public function resetNode():void
		{
			//override by subclass
		}
		
		/**输出节点信息**/
		public function output():String
		{
			return "nodeId:"+nodeId+"|"+
				"id:"+id+"|"+
				"partClassName:"+partClassName+"|"+
				"width:"+width+"|"+
				"height:"+height+"|"+
				"x:"+x+"|"+
				"y:"+y+"|"+
				"z:"+z+"|"+
				"scaleX:"+scaleX+"|"+
				"scaleY:"+scaleY+"|"+
				"scaleZ:"+scaleZ+"|"+
				"alpha:"+alpha+"|"+
				"rotation:"+rotation+"|"+
				"domain:"+domain+"|"+
				"srcId:"+srcId+"|"+
				"childIndex:"+childIndex+"|"+
				"definedProperties:"+definedProperties+"|"+
				"childNodeIdList:"+childNodeIdList;
		}
	}
}