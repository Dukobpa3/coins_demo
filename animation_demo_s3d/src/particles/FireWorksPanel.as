/**
 * Created by oburdun on 1/13/14.
 */
package particles
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;

	import gd.eggs.util.GlobalTimer;

	import org.flintparticles.common.events.EmitterEvent;

	import org.flintparticles.twoD.emitters.Emitter2D;

	import org.flintparticles.twoD.renderers.BitmapRenderer;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import utils.Config;


	public class FireWorksPanel extends Sprite
	{
		private var _renderer:BitmapRenderer;

		private var _image:Image;


		public function FireWorksPanel(root:flash.display.Sprite)
		{
			_renderer = new BitmapRenderer( new Rectangle( 0, 0, Config.SIZE.x, Config.SIZE.y ) );
			_renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			_renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );

			root.addChild(_renderer);
		}

		public function start():void
		{
			GlobalTimer.addTimerCallback(launchFirework);
			GlobalTimer.addFrameCallback(onFrame);
		}

		public function stop():void
		{
			GlobalTimer.removeTimerCallback(launchFirework);
			GlobalTimer.removeFrameCallback(onFrame);
		}

		private function launchFirework(date:Date):void
		{
			var color1:uint = Math.random() * 0xffffffff;
			var color2:uint = Math.random() * 0xffffffff;
			var dot:int = (Math.random() * 100) > 50 ? 2 : 1;
			var emitter:Emitter2D = new Firework(color1, color2, dot);
			emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, removeFirework, false, 0, true );

			emitter.x = Math.random() * Config.SIZE.x;
			emitter.y = Math.random() * Config.SIZE.y;

			_renderer.addEmitter( emitter );

			emitter.start();
		}

		private function onFrame(time:int):void
		{
			removeChild(_image);

			if(_image)
			{
				_image.texture.dispose();
				_image.dispose();
			}

			var shape:Shape = new Shape();
			shape.graphics.lineStyle(2, 0xff0000);
			shape.graphics.drawCircle(400, 300, 200);

			var bmpd:BitmapData = new BitmapData(Config.SIZE.x, Config.SIZE.y, true, 0x00000000);
			bmpd.draw(_renderer, null, null, null, null, true);

			_image = new Image(Texture.fromBitmapData(bmpd));

			addChild(_image);
		}

		private function removeFirework(event:EmitterEvent):void
		{
			var emitter:Emitter2D = event.currentTarget as Emitter2D;
			emitter.removeEventListener(EmitterEvent.EMITTER_EMPTY, removeFirework);
			_renderer.removeEmitter(emitter);
		}
	}
}
