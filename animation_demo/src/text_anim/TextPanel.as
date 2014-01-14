package text_anim
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gd.eggs.util.GlobalTimer;


	public class TextPanel extends Bitmap
	{
		private var _globalTimer:GlobalTimer;
		private var _textModel:TextModel;

		public function TextPanel()
		{
			_globalTimer = GlobalTimer.getInstance();

			bitmapData = new BitmapData(Config.SIZE.x, Config.SIZE.y, true, 0x00000000);
			smoothing = true;
		}

		public function start():void
		{
			var pos:Point = new Point();

			_textModel = new TextModel("big_win", Config.BIG_WIN_FRAMES_NUM, pos, 1);

			_globalTimer.addFrameCallback(onFrame);
		}

		public function clean():void
		{
			_globalTimer.removeFrameCallback(onFrame);

			bitmapData.fillRect(new Rectangle(0, 0, Config.SIZE.x, Config.SIZE.y), 0x00000000);
		}

		private function onFrame(date:int):void
		{
			bitmapData.lock();
			bitmapData.fillRect(new Rectangle(0, 0, Config.SIZE.x, Config.SIZE.y), 0x00000000);

			_textModel.nextFrame();

			var m:Matrix = new Matrix();

			bitmapData.draw(TextFactory.getFrame(_textModel.id, _textModel.frame), m, null, null, null, true);

			bitmapData.unlock();
		}

	}
}
