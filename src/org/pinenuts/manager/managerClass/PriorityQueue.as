package org.pinenuts.manager.managerClass
{
	import org.pinenuts.manager.ILayoutManagerClient;

	/***
	 * PriorityQueue提供了一个队列，用于在布局管理中，当请求产生之后，存入队列进行排队，在合适的时候调用。
	 * 此队列根据零件的nestLevel维护了一个正金字塔似的结构（倒树形），每个层级保存了若干对对象啊。当调用或者删除的时候，
	 * 根据索引先获得层级，再从层级中查找对象，或者对层级中的对象逐个进行操作。
	 * 
	 * @productversion	workerbee 1.0
	 * @author	晨光熹微<br />
	 * date		2012.12
	 * 
	 * */
	public final class PriorityQueue
	{
		/**
		 *  @private
		 * 	保存层级对象数组。 	
		 */
		private var priorityBins:Array = [];
		
		/**
		 *  @private
		 *  最小的层级索引
		 */
		private var minPriority:int = 0;
		
		/**
		 *  @private
		 *  最大层级索引
		 * 	层级，可以含有多个对象。最小和最大层级索引确定了一个层级结构和范围，当最大索引小于最小索引时表明队列中没有层级，当然也就没有对象（空状态）。
		 * 如果最大索引和最小索引相等，那么说明队列中有一个层级，会有一个或若干个对象。最大索引大于最小索引说明队列中有不止一个层级，也就有很多对象在排队。
		 */
		private var maxPriority:int = -1;
		/**
		 * 队列名字
		 **/
		private var queueName:String;
		
		public function PriorityQueue(name:String=null)
		{
			queueName = name;
		}
		/**
		 * 添加一个对象到队列中去
		 * */
		public function addObject(obj:Object,priority:int):void
		{
			if(maxPriority<minPriority)
			{
				minPriority = maxPriority = priority;
			}else{
				if(minPriority>priority)
					minPriority = priority;
				if(maxPriority<priority)
					maxPriority = priority;
			}
			var bin:PriorityBin = priorityBins[priority];
			if(!bin)
			{
				//如果层级列表里没有这个层级，则创建
				bin = new PriorityBin();
				priorityBins[priority] = bin;
				bin.items[obj] = true;
				bin.length++;
			}else{
				//如果层级列表里没有这个对象，则加入
				if(bin.items[obj]==null)
				{
					bin.items[obj]=true;
					bin.length++;
				}
			}
			
		}
		/**
		 * 从最大层级中移除对象
		 * */
		public function removeLargest():Object
		{
			var obj:Object = null;			
			if(minPriority<=maxPriority)
			{
				var bin:PriorityBin = priorityBins[maxPriority];
				//如果最大层级中对象用完了，则查找下一个层级的对象
				while(!bin||bin.length==0)
				{
					maxPriority--;
					if(maxPriority<minPriority)
						return null;
					bin = priorityBins[maxPriority];
				}
				for(var key:Object in bin.items)
				{
					obj = key;
					removeChild(ILayoutManagerClient(key),maxPriority);
					break;
				}
				//清理无用的层级和层级中的空对象
				while(!bin||bin.length==0)
				{
					maxPriority--;
					if(maxPriority<minPriority)
						break;
					bin = priorityBins[maxPriority];
				}
			}			
			return obj;
		}
		/**
		 * 从最小层级中清除对象
		 * */
		public function removeSmallest():Object
		{			
			var obj:Object = null;
			if(minPriority<=maxPriority)
			{
				var bin:PriorityBin = priorityBins[minPriority];
				while(!bin||bin.length==0)
				{
					minPriority++;
					if(minPriority>maxPriority)
						return null;
					bin = priorityBins[minPriority];
				}
				
				for(var key:Object in bin.items)
				{
					obj = key;
					removeChild(ILayoutManagerClient(key),minPriority);
					break;
				}
				//清理为空的层级和层级中的空对象
				while(!bin||bin.length==0)
				{
					minPriority++;
					if(minPriority>maxPriority)
						break;
					bin = priorityBins[minPriority];
				}
			}
			return obj;
		}
		/**
		 * 从一个层级中移除一个对象
		 * @param	client	对象
		 * @param	level	层级 
		 * */
		public function removeChild(client:ILayoutManagerClient,level:int=-1):Object
		{
			var priority:int = (level>=0)?level:client.nestLevel;
			var bin:PriorityBin = priorityBins[priority];
			if(bin&&bin.items[client]!=null)
			{
				delete bin.items[client];
				bin.length--;
				return client;
			}
			return null;
		}
		/**
		 * 队列是否为空
		 * 
		 * */
		public function isEmpty():Boolean
		{
			return minPriority > maxPriority;
		}
		/**
		 * 清空队列
		 * 
		 * */
		private function removeAll():void
		{
			priorityBins.length = 0;
			minPriority = 0;
			maxPriority = -1;
		}
	}
}
import flash.utils.Dictionary;

class PriorityBin 
{
	public var length:int;
	public var items:Dictionary = new Dictionary();	
}