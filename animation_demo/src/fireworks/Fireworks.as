package fireworks
{
	import flash.geom.Point;

	import org.flintparticles.common.actions.Age;
	import org.flintparticles.common.actions.Fade;
	import org.flintparticles.common.counters.Blast;
	import org.flintparticles.common.displayObjects.Dot;
	import org.flintparticles.common.easing.Quadratic;
	import org.flintparticles.common.initializers.ColorInit;
	import org.flintparticles.common.initializers.Lifetime;
	import org.flintparticles.common.initializers.SharedImage;
	import org.flintparticles.twoD.actions.Accelerate;
	import org.flintparticles.twoD.actions.LinearDrag;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.Velocity;
	import org.flintparticles.twoD.zones.DiscZone;


	public class Fireworks extends Emitter2D
	{
		public function Fireworks(color1:uint = 0xFFFFFF00, color2:uint = 0xFFFF6600, dot:int = 2)
		{
			counter = new Blast( 500 );

			addInitializer( new SharedImage( new Dot( dot ) ) );
			addInitializer( new ColorInit( color1, color2 ) );
			addInitializer( new Velocity( new DiscZone( new Point( 0, 0 ), 200, 120 ) ) );
			addInitializer( new Lifetime( 2 ) );

			addAction( new Age( Quadratic.easeIn ) );
			addAction( new Move() );
			addAction( new Fade() );
			addAction( new Accelerate( 0, 75 ) );
			addAction( new LinearDrag( 0.5 ) );
		}
	}
}