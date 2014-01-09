package coins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import gd.eggs.util.GlobalTimer;


	public class AnimationPanel extends Bitmap
	{
		private var _coins:Vector.<CoinModel>;
		private var _globalTimer:GlobalTimer;

		private var _counter:TextField;
		private var _date:int;

		public function AnimationPanel() { }

		public function init():void
		{
			_coins = new Vector.<CoinModel>();

			_globalTimer = GlobalTimer.getInstance();

			_counter = new TextField();
			_counter.defaultTextFormat = new TextFormat("_sans", 14, 0xff0000, true);
			_counter.autoSize = TextFieldAutoSize.LEFT;

			bitmapData = new BitmapData(Config.SIZE.x, Config.SIZE.y, true, 0xaaaaaa);
			smoothing = true;

			addCoins();
		}

		private function addCoins():void
		{
			for (var i:int = 0 ; i < 200 ; i ++)
			{
				var pos:Point = new Point(
						int(Math.random() * Config.SIZE.x) - 51,
						int(Math.random() * Config.SIZE.y) - Config.SIZE.y - 102);

				var depth:Number = (Math.random() * 0.5) + 0.5;

				var id:String = ["01", "02", "03"][int(Math.random() * 3)];

				var coin:CoinModel = new CoinModel(id, Config.FRAMES_BY_ID[id], pos, depth);
				coin.init();

				_coins.push(coin);
			}

			_coins.sort(sortByDepth);

			_globalTimer.addFrameCallback(onFrame);
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

			for (var i:int = 0 ; i < _coins.length ; i ++)
			{
				var coin:CoinModel = _coins[i];
				coin.nextFrame();
				coin.move();

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

			_counter.text =
					"num coins:\t" + String(_coins.length) + "\n" +
					"frame time:\t" + String(date - _date) + "\n" +
					"FPS:\t\t" + Math.round(1000 / (date - _date)).toString();

			_date = date;

			bitmapData.draw(_counter);

			bitmapData.unlock();
		}
	}
}
