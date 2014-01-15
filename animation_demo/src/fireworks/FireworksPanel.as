package fireworks
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;

	import gd.eggs.util.GlobalTimer;

	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.renderers.Renderer;
	import org.flintparticles.common.renderers.RendererBase;

	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapLineRenderer;

	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import org.flintparticles.twoD.renderers.PixelRenderer;
	import org.flintparticles.twoD.renderers.VectorLineRenderer;


	public class FireworksPanel extends Sprite
	{
		private var _renderer:BitmapRenderer;

		public function FireworksPanel()
		{
			_renderer = new BitmapLineRenderer( new Rectangle( 0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y ) );
			_renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			_renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
		}

		public function start():void
		{
			GlobalTimer.addTimerCallback(launchFirework);
			addChild(_renderer);
		}

		public function stop():void
		{
			GlobalTimer.removeTimerCallback(launchFirework);
			//removeChild(_renderer);
		}

		private function launchFirework(date:Date):void
		{
			var color1:uint = Math.random() * 0xffffffff;
			var color2:uint = Math.random() * 0xffffffff;
			var dot:int = 2;//(Math.random() * 100) > 50 ? 2 : 1;
			var emitter:Emitter2D = new Fireworks(color1, color2, dot);
			emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, removeFirework, false, 0, true );

			emitter.x = Math.random() * Config.SCREEN_SIZE.x;
			emitter.y = Math.random() * Config.SCREEN_SIZE.y;

			_renderer.addEmitter( emitter );

			emitter.start();
		}

		private function removeFirework(event:EmitterEvent):void
		{
			var emitter:Emitter2D = event.currentTarget as Emitter2D;
			emitter.removeEventListener(EmitterEvent.EMITTER_EMPTY, removeFirework);
			emitter.killAllParticles();
			//_renderer.removeEmitter(emitter);
		}
	}
}
