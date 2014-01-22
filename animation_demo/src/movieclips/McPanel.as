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

	import gd.eggs.customanim.AnimationManager;
	import gd.eggs.customanim.AnimationModel;
	import gd.eggs.util.GlobalTimer;

	import movieclips.atlas.Frame;
	import movieclips.atlas.McModel;


	public class McPanel extends Bitmap
	{
		public static const START_CLOSING:String = "closingAnimation";

		private var _coins:Vector.<AnimationModel>;
		private var _text:AnimationModel;

		private var _complete:Boolean;


		public function McPanel()
		{
			_coins = new Vector.<AnimationModel>();

			bitmapData = new BitmapData(Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y, true, 0x00000000);
			smoothing = true;
		}

		public function start():void
		{
			_complete = false;

			var mcModel:McModel = new McModel("big_win", Config.BIG_WIN_FRAMES_NUM, new Point(), 1);
			_text = new AnimationModel(mcModel, false, 1, -1, 24);
			_text.addEventListener(Event.COMPLETE, onTextAnimationComplete);

			AnimationManager.startAnimation(_text, "big_win");

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
			if (!_complete) createCoin();

			// draw coins

			bitmapData.lock();
			bitmapData.fillRect(new Rectangle(0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y), 0x00000000);

			for (var i:int = 0; i < _coins.length; i++)
			{
				renderMc(_coins[i].mc as McModel);
			}

			if (!_complete)
			{
				renderMc(_text.mc as McModel);
			}

			bitmapData.unlock();
		}

		private function onCoinTweenComplete(aninModel:AnimationModel):void
		{
			_coins.splice(_coins.indexOf(aninModel), 1);
			AnimationManager.stopAnimation(aninModel.mc);

			if (!_coins.length) dispatchEvent(new Event(Event.COMPLETE));
		}

		private function createCoin():void
		{
			var pos:Point = new Point(
					Math.random() * Config.SCREEN_SIZE.x * 2 - Config.SCREEN_SIZE.x /2,
					Config.SCREEN_SIZE.y + 102
			);
			var depth:Number = (Math.random() * 0.5) + 0.5;
			var coin:McModel = new McModel("c_01", Config.COINS_FRAMES_NUM, pos, depth);
			coin.gotoAndStop(Math.random() * coin.totalFrames);

			var animModel:AnimationModel = new AnimationModel(coin, true, 1, 0, 24);
			AnimationManager.startAnimation(animModel, coin);

			// eaze
			depth = coin.depth > 0.75 ? 0.5 : 1;

			var x1:int = coin.x < 400 ? coin.x + 200 : coin.x - 200;
			var x2:int = coin.x < 400 ? coin.x + 400 : coin.x - 400;

			var y1:int = -Config.SCREEN_SIZE.y * 1.2;
			var y2:int = Config.SCREEN_SIZE.y + 102;

			_coins.push(animModel);
			_coins.sort(sortByDepth);

			eaze(coin).to(3, { x:[x1, x2], y:[y1, y2], depth:depth }).onComplete(onCoinTweenComplete, animModel);
		}

		private function renderMc(mcModel:McModel):void
		{
			if(mcModel.depth != 1)
			{
				var c:ColorTransform = new ColorTransform();
				var mul:Number = 1 - mcModel.depth;
				c.redMultiplier = c.greenMultiplier = c.blueMultiplier = (1 - mul);
				c.alphaMultiplier = 1;
				c.alphaOffset = 0;

				c.redOffset = Math.round(mul * 0x22);
				c.greenOffset = Math.round(mul * 0x22);
				c.blueOffset = Math.round(mul * 0x22);
			}

			var frame:Frame = mcModel.frame;

			var m:Matrix = new Matrix();
			m.scale(mcModel.depth, mcModel.depth);

			m.translate(
					mcModel.x - (frame.rect.x + frame.frameRect.x) * mcModel.depth,
					mcModel.y - (frame.rect.y + frame.frameRect.y) * mcModel.depth
			);

			var clipRect:Rectangle = new Rectangle(
					mcModel.x - frame.frameRect.x * mcModel.depth,
					mcModel.y - frame.frameRect.y * mcModel.depth,
					frame.rect.width * mcModel.depth,
					frame.rect.height * mcModel.depth
			);

			bitmapData.draw(frame.data, m, c, null, clipRect, true);
		}

		private function onTextAnimationComplete(event:Event):void
		{
			_complete = true;
			dispatchEvent(new Event(START_CLOSING));
		}

		public function get coinsNum():int { return _coins.length; }
	}
}
