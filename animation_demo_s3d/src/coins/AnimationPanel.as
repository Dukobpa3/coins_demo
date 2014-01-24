package coins
{
	import aze.motion.eaze;

	import gd.eggs.util.GlobalTimer;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	import utils.Config;


	public class AnimationPanel extends Sprite
	{
		private static const WANT_TO_LAUNCH:int = 1000;
		private static const LAUNCH_AT_TIME:int = 1;

		private var _frames:Array;

		private var _coins:Vector.<MovieClip>;
		private var _unsorted:Vector.<MovieClip>;

		private var _counter:TextField;
		private var _date:int;

		private var _launched:int;
		private var _complete:int;

		public function AnimationPanel(assets)
		{
			_frames = [
				assets.getTextures("c_01"),
				assets.getTextures("c_02"),
				assets.getTextures("c_03")
			];
		}

		public function init():void
		{
			_coins ||= new Vector.<MovieClip>();
			_unsorted ||= new Vector.<MovieClip>();

			_counter ||= new TextField(170, 80, "", "Ubuntu", 14);
			_counter.bold = true;
			_counter.hAlign = HAlign.LEFT;
			_counter.vAlign = VAlign.TOP;
			_counter.border = true;
			_counter.color = 0x993333;

			_launched = 0;
			_complete = 0;

			GlobalTimer.addFrameCallback(onFrame);
		}

		private function sortByDepth(x:MovieClip, y:MovieClip):Number
		{
			return    x.scaleX < y.scaleX ? -1
					: x.scaleX > y.scaleX ? 1
					: 0;
		}

		private function onFrame(date:int):void
		{
			if (_launched < WANT_TO_LAUNCH)
			{
				for (var i:int = 0 ; i < LAUNCH_AT_TIME ; i ++)
				{
					var coin:MovieClip = new MovieClip(_frames[0], 24);
					coin.scaleX = coin.scaleY = (Math.random() * 0.5) + 0.5;
					coin.x = Math.random() * Config.SIZE.x * 2 - Config.SIZE.x /2;
					coin.y = Config.SIZE.y + 102;

					coin.currentFrame = Math.random() * coin.numFrames;

					_coins.push(coin);
					_unsorted.push(coin);

					_coins.sort(sortByDepth);

					var depth:Number = coin.scaleX > 0.75 ? 0.5 : 1;

					var x1:int = coin.x < 400 ? coin.x + 200 : coin.x - 200;
					var x2:int = coin.x < 400 ? coin.x + 400 : coin.x - 400;

					var y1:int = -Config.SIZE.y * 1.2;
					var y2:int = Config.SIZE.y + 102;

					eaze(coin).to(3, { x:[x1, x2], y:[y1, y2], scale:depth }).onComplete(onCoinTweenComplete, coin);
					Starling.juggler.add(coin);

					_launched ++;
				}
			}

			for (i = 0; i < _coins.length; i++) addChild(_coins[i]);

			_counter.text = "launched coins:\t" + String(_launched) + "\n" +
							"display coins:\t" + String(_coins.length) + "\n" +
							"frame time:\t" + String(date - _date) + "\n" +
							"FPS:\t\t\t" + Math.round(1000 / (date - _date)).toString();

			addChild(_counter);

			_date = date;
		}

		private function onCoinTweenComplete(coin:MovieClip):void
		{
			removeChild(coin);
			Starling.juggler.remove(coin);

			_coins.splice(_coins.indexOf(coin), 1);
			_unsorted.splice(_unsorted.indexOf(coin), 1);

			_complete ++;
			if (_complete >= WANT_TO_LAUNCH) dispatchEvent(new Event(Event.COMPLETE));
		}

		public function clean():void
		{
			GlobalTimer.removeFrameCallback(onFrame);
			_launched = 0;
			_complete = 0;

			while (_coins.length) removeChild(_coins.pop());
			while (_unsorted.length) removeChild(_unsorted.pop());

			removeChild(_counter);
		}
	}
}
