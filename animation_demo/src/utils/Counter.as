/**
 * Created by oburdun on 1/14/14.
 */
package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;


	public class Counter extends Bitmap
	{
		public function Counter()
		{
			super();
			bitmapData = new BitmapData(300, 200, true, 0x00000000);
		}
	}
}
