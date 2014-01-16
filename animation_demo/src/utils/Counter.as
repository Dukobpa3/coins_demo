/**
 * Created by oburdun on 1/14/14.
 */
package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import gd.eggs.util.GlobalTimer;


	public class Counter extends Bitmap
	{
		private var _counter:TextField;
		private var _date:int;

		public var coins:int;
		public var emitters:int;

		public function Counter()
		{
			cacheAsBitmap = true;
			_counter = new TextField();
			_counter.defaultTextFormat = new TextFormat("_sans", 14, 0xff0000, true);
			_counter.autoSize = TextFieldAutoSize.LEFT;

			bitmapData = new BitmapData(300, 200, true, 0x00000000);

			GlobalTimer.addFrameCallback(onFrame);
		}

		private function onFrame(date:int):void
		{
			bitmapData.lock();

			bitmapData.fillRect(new Rectangle(0, 0, 300, 200), 0x00000000);

			_counter.text =
					"coins:\t\t"    + String(coins) + "\n" +
					"emitters:\t"   + String(emitters) + "\n" +
					"frame time:\t" + String(date - _date) + "\n" +
					"FPS:\t\t"      + Math.round(1000 / (date - _date)).toString() + "\n" +
					"Memory\t"      + String(System.totalMemory / 1024);

			_date = date;

			bitmapData.draw(_counter);

			bitmapData.unlock();
		}

	}
}
