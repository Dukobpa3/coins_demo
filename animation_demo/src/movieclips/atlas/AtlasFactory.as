/**
 * Created by Dukobpa3 on 1/15/14.
 */
package movieclips.atlas
{
	import flash.display.BitmapData;

	import utils.EmbeddedResources;


	public class AtlasFactory
	{
		private static var _frames:Object = {};

		public static function init():void
		{
			processAtlas("coin");
			processAtlas("big_win_0");
			processAtlas("big_win_1");
			processAtlas("big_win_2");
			processAtlas("big_win_3");
			processAtlas("big_win_4");
			processAtlas("big_win_5");
		}

		public static function getFrame(id:String, frame:int = 0):Frame
		{
			return _frames[id + "_" + toFiveDigits(frame)];
		}

		private static function processAtlas(name:String):void
		{
			var bmp:BitmapData = new EmbeddedResources[name]().bitmapData;
			var xml:XML = XML(new EmbeddedResources[name + "_xml"]());

			for each (var node:XML in xml.SubTexture)
			{
				_frames[node.@name] = Frame.fromXml(node, bmp);
			}
		}

		private static function toFiveDigits(num:int):String
		{
			var result:String = "";
			var numStr:String = num.toString();

			for (var i:int = 0 ; i < 5-numStr.length ; i ++) result += "0";

			return result + numStr;
		}

	}

}
