package coins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.system.LoaderContext;

	import gd.eggs.loading.BulkLoader;
	import gd.eggs.loading.loadingtypes.LoadingItem;


	public class CoinBase extends Bitmap
	{
		private static const TOTAL_FRAMES:int = 71;

		private var _loader:BulkLoader;

		protected var _frames:Vector.<BitmapData>;
		protected var _current:int = 0;

		private var _currentUrl:String;
		private var _id:String;

		private var _globalTimer:GlobalTimer;

		public function CoinBase(id:String)
		{
			_id = id;

			_globalTimer = GlobalTimer.getInstance();

			_frames = new <BitmapData>[];
			_loader = BulkLoader.getLoader("coinsLoader");
			_loader.addEventListener(BulkLoader.ERROR, onError);
		}

		public function init():void
		{
			loadNext();
		}

		public function play():void
		{
			_globalTimer.addFrameCallback(onEnterFrame);
		}

		public function stop():void
		{
			_globalTimer.removeFrameCallback(onEnterFrame);
		}

		public function nextFrame():void
		{
			if(!_frames.length || _frames.length < TOTAL_FRAMES) return;

			_current ++;
			if(_current >= _frames.length) _current = 0;

			this.bitmapData = _frames[_current];
		}

		private function loadNext():void
		{
			if(_frames.length > TOTAL_FRAMES)
			{
				_current = int(Math.random() * TOTAL_FRAMES);
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}

			_currentUrl = "assets/Coinzz/c_" + _id + "/c_" + _id + "_" + toFiveDigits(_frames.length) + ".png";

			var context:LoaderContext = new LoaderContext();

			var loader:LoadingItem = _loader.add(_currentUrl, { id:_currentUrl, context:context} );
			if (loader.isLoaded)
			{
				onLoadComplete(null);
			}
			else
			{
				loader.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.load();
			}
		}

		private function onEnterFrame(time:int):void
		{
			nextFrame();
		}

		private function onLoadComplete(event:Event):void
		{
			_frames.push(_loader.getBitmapData(_currentUrl));

			loadNext();
		}

		private function onError(event:BulkLoader):void
		{
			trace("load error", event);
		}

		private function toFiveDigits(num:int):String
		{
			var result:String = "";
			var numStr:String = num.toString();

			for (var i:int = 0 ; i < 5-numStr.length ; i ++) result += "0";

			return result + numStr;
		}
	}
}