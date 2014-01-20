package fireworks
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;

	import gd.eggs.util.GlobalTimer;

	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;


	public class FireworksPanel extends Sprite
	{
		private var _renderer:BitmapRenderer;

		private var _emitterCounter:int;

		public function FireworksPanel()
		{
			_renderer = new BitmapRenderer( new Rectangle( 0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y ) );
			//_renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			//_renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
		}

		public function start():void
		{
			_emitterCounter = 2;
			GlobalTimer.addTimerCallback(launchFirework);
			addChild(_renderer);
		}

		public function stop():void
		{
			GlobalTimer.removeTimerCallback(launchFirework);
		}

		public function clean():void
		{
			for each (var emitter:Emitter2D in _renderer.emitters)
				_renderer.removeEmitter(emitter);
		}

		private function launchFirework(date:Date):void
		{
			if (_emitterCounter --) return;
			else _emitterCounter = 2;

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
			if(_renderer.emitters.length > 1) _renderer.removeEmitter(emitter);
		}

		public function get emittersNum():int { return _renderer.emitters.length; }
	}
}
