/**
 * Created by oburdun on 1/14/14.
 */
package letters
{
	import aze.motion.easing.Cubic;
	import aze.motion.eaze;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import gd.eggs.util.GlobalTimer;


	public class LettersPanel extends Bitmap
	{
		[Embed(source="/trexture.png")]
		public static const texture:Class;

		private var _globalTimer:GlobalTimer;

		private var _letters:Vector.<Vector.<LetterModel>>;

		private var _text:TextField;
		private var _texture:Bitmap;
		private var _cont:Sprite;
		private var _cont2:Sprite;

		private var _texts3d:Vector.<TextField>;


		public function LettersPanel()
		{
			_globalTimer = GlobalTimer.getInstance();

			_text = new TextField();
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.cacheAsBitmap = true;
			_text.antiAliasType = AntiAliasType.ADVANCED;


			_cont = new Sprite();
			_cont.cacheAsBitmap = true;
			_cont.addChild(_text);
			_cont.filters = [new DropShadowFilter(1, 0, 0, 0.8, 1, 1)];

			_texts3d = new Vector.<TextField>();
			for (var i:int = 0 ; i < 30 ; i ++)
			{
				var tf:TextField = new TextField();
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.cacheAsBitmap = true;
				tf.antiAliasType = AntiAliasType.ADVANCED;

				tf.z = i + 1;

				_texts3d.push(tf);

				_cont.addChild(tf);
			}

			_texture = new texture() as Bitmap;
			_cont.addChild(_texture);
			_texture.mask = _text;

			_cont2 = new Sprite();
			_cont2.addChild(_cont);

			bitmapData = new BitmapData(Config.SIZE.x, Config.SIZE.y, true, 0x00000000);
			smoothing = true;
		}

		public function start(str:String, size:int, time:Number):void
		{
			_texture.scaleX = _texture.scaleY = _texture.width / size;
			_texture.x = -_texture.width * 0.5;
			_texture.y = -_texture.height * 0.5;

			_text.defaultTextFormat = new TextFormat("_sans", size, 0xff0000, true);

			for each (var tf:TextField in _texts3d)
			{
				tf.defaultTextFormat = new TextFormat("_sans", size, 0xff0000, true);
			}

			var splitted:Vector.<String> = Vector.<String>(str.split('\n'));

			// TODO занулить адекватно
			_letters = new Vector.<Vector.<LetterModel>>(splitted.length);

			for (var s:int = 0 ; s < splitted.length ; s ++)
			{
				_letters[s] = new Vector.<LetterModel>(splitted[s].length);

				for (var l:int = 0 ; l < splitted[s].length ; l ++ )
				{
					var letter:LetterModel = new LetterModel();

					letter.sign = splitted[s].charAt(l);
					letter.x = Config.SIZE.x * 0.5;
					letter.y = Config.SIZE.y * 0.5;
					letter.z = 10000;

					//letter.scale = 0;

					letter.rotationX = Math.random() * 360 * 3;
					letter.rotationY = Math.random() * 360 * 3;
					letter.rotationZ = Math.random() * 360 * 3;

					_letters[s][l] = letter;

					var x1:int = letter.x - size + size * l;
					var y1:int = letter.y - size * 0.5 + size * s;

					eaze(letter).to(time, {rotationX:0, rotationY:0, rotationZ:0, x:x1, y:y1, z:0, scale:1}).easing(Cubic.easeInOut);
				}
			}

			_globalTimer.addFrameCallback(onFrame);
			_globalTimer.addTimerCallback(onTimer);
		}

		private function onFrame(timer:int):void
		{
			bitmapData.lock();
			bitmapData.fillRect(new Rectangle(0, 0, Config.SIZE.x, Config.SIZE.y), 0x00000000);

			for (var s:int = 0 ; s < _letters.length ; s ++)
			{
				for (var l:int = 0 ; l < _letters[s].length ; l ++ )
				{
					var lt:LetterModel = _letters[s][l];
					_text.text = lt.sign;
					_text.x = -_text.width * 0.5;
					_text.y = -_text.height * 0.5;
					_texture.x = _text.x;
					_texture.y = _text.y;

					for each (var tf:TextField in _texts3d)
					{
						tf.text = lt.sign;
						tf.x = -tf.width * 0.5;
						tf.y = -tf.height * 0.5;
					}

					_cont.x = lt.x;
					_cont.y = lt.y;
					_cont.z = lt.z;

					_cont.rotationX = lt.rotationX;
					_cont.rotationY = lt.rotationY;
					_cont.rotationZ = lt.rotationZ;

					var m:Matrix = new Matrix();
					m.translate(lt.x, lt.y);

					bitmapData.draw(_cont2, m);
				}
			}

			bitmapData.unlock();
		}

		private function onTimer(date:Date):void
		{

		}
	}
}
