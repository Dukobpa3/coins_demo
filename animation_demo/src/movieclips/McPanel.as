package movieclips
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

	import gd.eggs.customanim.AnimationManager;

	import gd.eggs.customanim.AnimationModel;

	import gd.eggs.util.GlobalTimer;


	public class McPanel extends Bitmap
	{
		public static const START_CLOSING:String = "closingAnimation";

		private var _coins:Vector.<AnimationModel>;
		private var _text:AnimationModel;

		private var _counter:TextField;
		private var _date:int;

		private var _complete:Boolean;


		public function McPanel()
		{
			_coins = new Vector.<AnimationModel>();

			_counter = new TextField();
			_counter.defaultTextFormat = new TextFormat("_sans", 14, 0xff0000, true);
			_counter.autoSize = TextFieldAutoSize.LEFT;

			bitmapData = new BitmapData(Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y, true, 0x00000000);
			smoothing = true;
		}

		public function start():void
		{
			_complete = false;

			_text = new AnimationModel(new McModel("big_win", Config.BIG_WIN_FRAMES_NUM, new Point(), 1), false, 1, -1, 24);
			_text.addEventListener(Event.COMPLETE, onTextAnimationComplete);

			AnimationManager.startAnimation(_text, "text");

			GlobalTimer.addFrameCallback(onFrame);
		}

		public function clean():void
		{
			GlobalTimer.removeFrameCallback(onFrame);

			bitmapData.fillRect(new Rectangle(0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y), 0x00000000);

			while (_coins.length) _coins.pop();
		}

		private function sortByDepth(x:AnimationModel, y:AnimationModel):Number
		{
			return    (x.mc as McModel).depth < (y.mc as McModel).depth ? -1
					: (x.mc as McModel).depth > (y.mc as McModel).depth ? 1
					: 0;
		}

		private function onFrame(date:int):void
		{
			// add coin
			if (!_complete)
			{
				var pos:Point = new Point(
						Math.random() * Config.SCREEN_SIZE.x * 2 - Config.SCREEN_SIZE.x /2,
						Config.SCREEN_SIZE.y + 102
				);
				var depth:Number = (Math.random() * 0.5) + 0.5;
				var id:String = ["01", "02", "03"][int(Math.random() * 3)];

				var coin:McModel = new McModel(id, Config.COINS_FRAMES_BY_ID[id], pos, depth);
				coin.gotoAndStop(Math.random() * coin.totalFrames);

				var animModel:AnimationModel = new AnimationModel(coin, true, 1, 0, 24);
				AnimationManager.startAnimation(animModel, coin);

				// eaze
				depth = coin.depth > 0.75 ? 0.5 : 1;

				var x1:int = coin.x < 400 ? coin.x + 200 : coin.x - 200;
				var x2:int = coin.x < 400 ? coin.x + 400 : coin.x - 400;

				var y1:int = -Config.SCREEN_SIZE.y * 1.2;
				var y2:int = Config.SCREEN_SIZE.y + 102;

				eaze(coin).to(3, { x:[x1, x2], y:[y1, y2], depth:depth }).onComplete(onCoinTweenComplete, animModel);

				_coins.push(animModel);
				_coins.sort(sortByDepth);
			}
			// draw coins

			bitmapData.lock();
			bitmapData.fillRect(new Rectangle(0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y), 0x00000000);

			for (var i:int = 0; i < _coins.length; i++)
			{
				renderCoin(_coins[i].mc as McModel);
			}

			if (!_complete)
			{
				var m:Matrix = new Matrix();
				bitmapData.draw((_text.mc as McModel).frame, m, null, null, null, true);
			}

			_counter.text =
				"num coins:\t"  + String(_coins.length) + "\n" +
				"frame time:\t" + String(date - _date) + "\n" +
				"FPS:\t\t"      + Math.round(1000 / (date - _date)).toString() + "\n" +
				"text_FPS:\t"   + String(_text.frameRate);

			_date = date;

			bitmapData.draw(_counter);
			bitmapData.unlock();
		}

		private function onCoinTweenComplete(aninModel:AnimationModel):void
		{
			var id:int = _coins.indexOf(aninModel);
			_coins.splice(id, 1);
			AnimationManager.stopAnimation(aninModel.mc);

			if (!_coins.length) dispatchEvent(new Event(Event.COMPLETE));
		}

		private function renderCoin(coin:McModel):void
		{
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

			bitmapData.draw(coin.frame, m, c, null, null, true);
		}

		private function onTextAnimationComplete(event:Event):void
		{
			_complete = true;
			dispatchEvent(new Event(START_CLOSING));
		}
	}
}
