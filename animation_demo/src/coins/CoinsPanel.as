package coins
{
	import aze.motion.eaze;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import gd.eggs.util.GlobalTimer;


	public class CoinsPanel extends Bitmap
	{
		private var _coins:Vector.<CoinModel>;
		private var _unsorted:Vector.<CoinModel>;
		private var _currentStart:int;
		private var _globalTimer:GlobalTimer;

		private var _counter:TextField;
		private var _date:int;

		private var _tweenNow:int;

		public function CoinsPanel()
		{
			_coins = new Vector.<CoinModel>();
			_unsorted = new Vector.<CoinModel>();

			_globalTimer = GlobalTimer.getInstance();

			_counter = new TextField();
			_counter.defaultTextFormat = new TextFormat("_sans", 14, 0xff0000, true);
			_counter.autoSize = TextFieldAutoSize.LEFT;

			bitmapData = new BitmapData(Config.SIZE.x, Config.SIZE.y, true, 0x00000000);
			smoothing = true;
		}

		public function start():void
		{
			addCoins();
			_tweenNow = 0;
			_currentStart = 0;

			_globalTimer.addFrameCallback(onFrame);
		}

		public function clean():void
		{
			_globalTimer.removeFrameCallback(onFrame);
			_tweenNow = 0;
			_currentStart = 0;

			bitmapData.fillRect(new Rectangle(0, 0, Config.SIZE.x, Config.SIZE.y), 0x00000000);

			while (_coins.length) _coins.pop();
			while (_unsorted.length) _unsorted.pop();
		}

		private function addCoins():void
		{
			for (var i:int = 0; i < 500; i++)
			{
				var pos:Point = new Point(
					Math.random() * Config.SIZE.x * 2 - Config.SIZE.x /2,
					Config.SIZE.y + 102
				);
				var depth:Number = (Math.random() * 0.5) + 0.5;
				var id:String = ["01", "02", "03"][int(Math.random() * 3)];

				var coin:CoinModel = new CoinModel(id, Config.FRAMES_BY_ID[id], pos, depth);

				_coins.push(coin);
				_unsorted.push(coin);
			}

			_coins.sort(sortByDepth);
		}

		private function sortByDepth(x:CoinModel, y:CoinModel):Number
		{
			return    x.depth < y.depth ? -1
					: x.depth > y.depth ? 1
					: 0;
		}

		private function onFrame(date:int):void
		{
			bitmapData.lock();
			bitmapData.fillRect(new Rectangle(0, 0, Config.SIZE.x, Config.SIZE.y), 0x00000000);

			for (var i:int = 0; i < _coins.length; i++)
			{
				renderCoin(_coins[i]);
			}

			_counter.text =
				"num coins:\t"  + String(_coins.length) + "\n" +
				"frame time:\t" + String(date - _date) + "\n" +
				"FPS:\t\t"      + Math.round(1000 / (date - _date)).toString();

			_date = date;

			bitmapData.draw(_counter);
			bitmapData.unlock();

			_coins.sort(sortByDepth);

			tryToAddCoin();
		}

		private function renderCoin(coin:CoinModel):void
		{
			coin.nextFrame();

			var m:Matrix = new Matrix();
			m.scale(coin.depth, coin.depth);
			m.translate(coin.x, coin.y);

			var c:ColorTransform = new ColorTransform();
			var mul:Number = 1 - coin.depth;
			c.redMultiplier = c.greenMultiplier = c.blueMultiplier = (1 - mul);
			c.alphaMultiplier = 1;
			c.alphaOffset = 0;

			c.redOffset = Math.round(mul * 0x33);
			c.greenOffset = Math.round(mul * 0x33);
			c.blueOffset = Math.round(mul * 0x33);

			bitmapData.draw(CoinsFactory.getFrame(coin.id, coin.frame), m, c, null, null, true);
		}

		private function tryToAddCoin():void
		{
			if (_currentStart >= _coins.length) return;

			var coin:CoinModel = _unsorted[_currentStart ++];
			var depth:Number = coin.depth > 0.75 ? 0.5 : 1;

			var x1:int = coin.x < 400 ? coin.x + 200 : coin.x - 200;
			var x2:int = coin.x < 400 ? coin.x + 400 : coin.x - 400;

			var y1:int = -Config.SIZE.y * 1.2;
			var y2:int = Config.SIZE.y + 102;

			eaze(coin).to(3, { x:[x1, x2], y:[y1, y2], depth:depth }).onComplete(onCoinTweenComplete);
			_tweenNow ++;
		}

		private function onCoinTweenComplete():void
		{
			_tweenNow --;
			if (!_tweenNow) dispatchEvent(new Event(Event.COMPLETE));
		}

	}
}
