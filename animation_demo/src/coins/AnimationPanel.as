package coins
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;


	public class AnimationPanel extends Bitmap
	{

		private static const SIZE:Rectangle = new Rectangle(0, 0, 800, 600);

		private var _coins:Vector.<CoinBase>;
		private var _globalTimer:GlobalTimer;

		private var _playing:Boolean;

		private var _counter:TextField;

		private var _date:int;

		public function AnimationPanel()
		{
			super();
		}

		public function init():void
		{
			_coins = new Vector.<CoinBase>();

			_globalTimer = GlobalTimer.getInstance();

			_counter = new TextField();
			_counter.defaultTextFormat = new TextFormat("_sans", 14, 0xff0000, true);
			_counter.autoSize = TextFieldAutoSize.LEFT;

			bitmapData = new BitmapData(SIZE.width, SIZE.height, true, 0xaaaaaa);
			smoothing = true;

			addCoin();
		}

		private function addCoin():void
		{
			var coin:CoinBase = new CoinBase("01");
			coin.addEventListener(Event.COMPLETE, onLoadingComplete);

			coin.init();
			coin.x = int(Math.random() * SIZE.width) - 51;
			coin.y = int(Math.random() * SIZE.height) - 51;
			coin.alpha = coin.scale = (Math.random() * 0.5) + 0.5;
		}

		private function sortByScale(x:CoinBase, y:CoinBase):Number
		{
			return x.scale < y.scale ? -1
					: x.scale > y.scale ? 1
					: 0;
		}

		private function onLoadingComplete(event:Event):void
		{
			_globalTimer.addFrameCallback(onFrame);
			_playing = true;

			_coins.push(event.currentTarget as CoinBase);
		}

		private function onFrame(date:int):void
		{
			if (_coins.length < 1000)
			{
				addCoin();
				_coins.sort(sortByScale);
			}

			bitmapData.lock();
			bitmapData.fillRect(SIZE, 0x00000000);

			for (var i:int = 0 ; i < _coins.length ; i ++)
			{
				var coin:CoinBase = _coins[i];
				coin.nextFrame();
				var m:Matrix = new Matrix();
				m.scale(coin.scale, coin.scale);
				m.translate(coin.x, coin.y);

				var c:ColorTransform = new ColorTransform();
				c.alphaMultiplier = coin.alpha;

				bitmapData.draw(coin.current, m, c, null, null, true);
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
