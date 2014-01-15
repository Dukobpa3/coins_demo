/**
 * Created by Dukobpa3 on 1/15/14.
 */
package movieclips.atlas
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;


	public class Frame
	{
		private var _bmd:BitmapData;
		private var _rect:Rectangle;
		private var _frameRect:Rectangle;

		public function Frame(bmd:BitmapData, rect:Rectangle, frameRect:Rectangle)
		{
			_bmd = bmd;
			_rect = rect;
			_frameRect = frameRect;
		}

		public static function fromXml(xml:XML, bmd:BitmapData):Frame
		{
			var rect:Rectangle = new Rectangle();
			rect.x = int(xml.@x);
			rect.y = int(xml.@y);
			rect.width = int(xml.@width);
			rect.height = int(xml.@height);

			var frameRect:Rectangle = new Rectangle();
			frameRect.x = int(xml.@frameX);
			frameRect.y = int(xml.@frameY);
			frameRect.width = int(xml.@frameWidth);
			frameRect.height = int(xml.@frameHeight);

			return new Frame(bmd, rect, frameRect);
		}

		/** Битмапдата фрейма */
		public function get data():BitmapData { return _bmd; }

		/** прямоугольник картинки на общем листе */
		public function get rect():Rectangle { return _rect; }

		/** Прямоугольник фрейма анимации по отношению к прямоугольнику картинки */
		public function get frameRect():Rectangle { return _frameRect; }
	}
}
