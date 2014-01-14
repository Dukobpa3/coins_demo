package text_anim
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.LoaderContext;

	import gd.eggs.loading.BulkLoader;
	import gd.eggs.loading.BulkProgressEvent;
	import gd.eggs.loading.loadingtypes.LoadingItem;


	public class TextFactory
	{
		private static const LOADER_NAME:String = "textBulkLoader";

		private static var _frames:Object;

		private static var _bulkLoader:BulkLoader;
		private static var _dispatcher:EventDispatcher;

		private static var _queue:int;
		private static var _done:int;

		public static function init():void
		{
			if (_bulkLoader)
			{
				dispatcher.dispatchEvent(new BulkProgressEvent(BulkLoader.COMPLETE));
				return;
			}

			_bulkLoader = BulkLoader.getLoader(LOADER_NAME);
			_bulkLoader.addEventListener(BulkLoader.COMPLETE, dispatcher.dispatchEvent);
			_bulkLoader.addEventListener(BulkLoader.PROGRESS, dispatcher.dispatchEvent);

			_frames = {};
			_frames["big_win"] = new Vector.<BitmapData>(Config.BIG_WIN_FRAMES_NUM);

			for (var id:String in _frames)
			{
				for (var i:int = 0 ; i < Config.BIG_WIN_FRAMES_NUM ; i ++)
				{
					_queue ++;
					var url:String = "txt/" + id + "_" + toFiveDigits(i) + ".png";
					var loaderId:String = id + ":" + i.toString();

					var context:LoaderContext = new LoaderContext();
					var loader:LoadingItem = _bulkLoader.add(url, { id:loaderId, context:context} );
					loader.addEventListener(Event.COMPLETE, onFrameLoadComplete);
					loader.load();
				}
			}
		}

		public static function getFrame(id:String, frame:int):BitmapData
		{
			return _frames[id][frame];
		}

		private static function onFrameLoadComplete(event:Event):void
		{
			_done ++;
			var id:String = event.currentTarget.id;
			var coinId:String = id.split(":")[0];
			var frameId:int = int(id.split(":")[1]);

			_frames[coinId][frameId] = _bulkLoader.getBitmapData(event.currentTarget.id);
		}

		private static function toFiveDigits(num:int):String
		{
			var result:String = "";
			var numStr:String = num.toString();

			for (var i:int = 0 ; i < 5-numStr.length ; i ++) result += "0";

			return result + numStr;
		}

		public static function get dispatcher():EventDispatcher { return _dispatcher ||= new EventDispatcher(); }
		public static function get percentLoaded():Number { return _done / _queue; }
	}
}
