package coins
{
	import flash.display.Sprite;
	import flash.events.Event;


	public class AnimationPanel extends Sprite
	{

		private var _coins:Vector.<CoinBase>;
		private var _globalTimer:GlobalTimer;

		private var _playing:Boolean;

		public function AnimationPanel()
		{
			super();
		}

		public function init():void
		{
			_coins = new <CoinBase>[];

			_globalTimer = GlobalTimer.getInstance();

			var coin:CoinBase = new CoinBase("01");
			coin.addEventListener(Event.COMPLETE, onLoadingComplete);

			coin.init();
			coin.x = int(Math.random() * stage.stageWidth) - 51;
			coin.y = int(Math.random() * stage.stageHeight) - 51;

			_coins.push(coin);
			addChild(coin);
		}

		public function pause():void
		{
			for each(var coin:CoinBase in _coins)
			{
				coin.stop();
			}
		}

		public function resume():void
		{
			for each(var coin:CoinBase in _coins)
			{
				coin.play();
			}
		}

		private function onLoadingComplete(event:Event):void
		{
			_globalTimer.addTimerCallback(onTimer);
			_playing = true;

			(event.currentTarget as CoinBase).play();
		}

		private function onTimer(date:Date):void
		{
			var coin:CoinBase;

			if (_coins.length < 1000)
			{
				coin = new CoinBase("01");
				coin.addEventListener(Event.COMPLETE, onLoadingComplete);

				coin.init();
				coin.x = int(Math.random() * stage.stageWidth) - 51;
				coin.y = int(Math.random() * stage.stageHeight) - 51;

				_coins.push(coin);
				addChild(coin);
			}
		}
	}
}
