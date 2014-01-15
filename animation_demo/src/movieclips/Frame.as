/**
 * Created by Dukobpa3 on 1/15/14.
 */
package movieclips
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;


	public class Frame
	{
		private var _bmd:BitmapData;
		private var _rect:Rectangle;

		public function Frame(bmd:BitmapData, rect:Rectangle)
		{
			_bmd = bmd;
			_rect = rect;
		}

		public function destroy():void
		{
			_bmd.dispose();
		}

		/** Битмапдата фрейма */
		public function get data():BitmapData { return _bmd; }

		/** прямоугольник на общем листе */
		public function get rect():Rectangle { return _rect; }
	}
}
