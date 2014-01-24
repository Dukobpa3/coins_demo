package
{
	import flash.display.Sprite;
	import flash.system.Capabilities;

	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import utils.EmbeddedAssets;


	// If you set this class as your 'default application', it will run without a preloader.
	// To use a preloader, see 'Demo_Web_Preloader.as'.

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#222222")]
	public class Animation_fireworks_s3d extends Sprite
	{
		private var mStarling:Starling;

		public function Animation_demo_s3d()
		{
			if (stage) start();
			else addEventListener(Event.ADDED_TO_STAGE, start);
		}

		private function start(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, start);

			Starling.multitouchEnabled = true; // for Multitouch Scene
			Starling.handleLostContext = true; // required on Windows, needs more memory

			mStarling = new Starling(AnimationFireworksDemo, stage);
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			mStarling.start();

			// this event is dispatched when stage3D is set up
			mStarling.addEventListener(Event.ROOT_CREATED, onRootCreated);
		}

		private function onRootCreated(event:Event, game:AnimationFireworksDemo):void
		{
			// set framerate to 30 in software mode
			if (mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				mStarling.nativeStage.frameRate = 30;

			// define which resources to load
			var assets:AssetManager = new AssetManager();
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(EmbeddedAssets);

			// game will first load resources, then start menu
			game.start(this, assets);
		}
	}
}