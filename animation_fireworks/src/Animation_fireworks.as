package {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.Fade;

	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.easing.Quadratic;

	import org.flintparticles.common.events.EmitterEvent;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.LinearDrag;
	import org.flintparticles.twoD.actions.Move;

	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Velocity;

	import org.flintparticles.twoD.renderers.BitmapRenderer;
	import org.flintparticles.twoD.zones.DiscZone;


	[SWF (width=800, height=600, backgroundColor=0x000000, frameRate=60)]
	public class Animation_fireworks extends Sprite
	{
		private var _renderer:BitmapRenderer;

		public function Animation_fireworks()
	    {
		    _renderer = new BitmapRenderer( new Rectangle( 0, 0, Config.SCREEN_SIZE.x, Config.SCREEN_SIZE.y ) );
		    _renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
		    _renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );

		    addChild(_renderer);

		    stage.addEventListener(MouseEvent.CLICK, launchFirework);
	    }

		private function launchFirework(event:MouseEvent):void
		{
			var color1:uint = 0xFFFFFF00; //Math.random() * 0xffffffff;
			var color2:uint = 0xFFFF6600; //Math.random() * 0xffffffff;
			var dot:int = 2;

			// fireworks config
			var emitter:Emitter2D = new Emitter2D();
			emitter.counter = new Blast( 500 );

			emitter.addInitializer( new SharedImage( new Dot( dot ) ) );
			emitter.addInitializer( new ColorInit( color1, color2 ) );
			emitter.addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 200, 120 ) ) );
			emitter.addInitializer( new Lifetime( 1 ) );

			emitter.addAction( new Age( Quadratic.easeIn ) );
			emitter.addAction( new Move() );
			emitter.addAction( new Fade() );
			emitter.addAction( new Accelerate( 0, 75) );
			emitter.addAction( new LinearDrag( 0.5 ) );
			//---------------------

			emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, removeFirework, false, 0, true );

			emitter.x = event.stageX;
			emitter.y = event.stageY;

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
	}
}
