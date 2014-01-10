package
{
	import coins.AnimationPanel;
	import coins.CoinsFactory;

	import fl.controls.Button;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.system.Security;

	import gd.eggs.loading.BulkProgressEvent;

	import gd.eggs.util.GlobalTimer;

	import org.flintparticles.common.events.EmitterEvent;

	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.renderers.BitmapRenderer;

	import particles.Firework;


	[SWF (width=800, height=600, backgroundColor=0xaaaaaa, frameRate=40)]
	public class AnimationDemo extends Sprite
	{
		private var _animationPanel:AnimationPanel;
		private var _startBtn:Button;

		private var _emitter:Emitter2D


		public function AnimationDemo()
	    {
		    Security.allowDomain("*");

		    if (stage) init();
		    else addEventListener(Event.ADDED_TO_STAGE, init);
	    }

		private function init(event:Event = null):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			_startBtn = new Button();

			_startBtn.addEventListener(MouseEvent.CLICK, onStartClick);

			_startBtn.label = "Start";
			_startBtn.x = (stage.stageWidth - _startBtn.width) * 0.5;
			_startBtn.y = (stage.stageHeight - _startBtn.height) * 0.5;

			addChild(_startBtn);

			GlobalTimer.updateDate(new Date());
		}

		private function onStartClick(event:MouseEvent):void
		{
			_startBtn.visible = false;

			CoinsFactory.dispatcher.addEventListener(Event.COMPLETE, onAllLoaded);
			CoinsFactory.dispatcher.addEventListener(ProgressEvent.PROGRESS, onProgress);
			CoinsFactory.init();
		}

		private function onProgress(event:BulkProgressEvent):void
		{
			var rect:Rectangle = new Rectangle(200, 290, 400, 20);
			this.graphics.clear();
			this.graphics.lineStyle(2);
			this.graphics.drawRoundRect(rect.x, rect.y, rect.width, rect.height, 3);

			this.graphics.lineStyle();
			this.graphics.beginFill(0x00ff00);
			this.graphics.drawRoundRect(rect.x + 1, rect.y + 1, rect.width * CoinsFactory.percentLoaded, 18, 3);
			this.graphics.endFill();
		}

		private function onAllLoaded(event:BulkProgressEvent):void
		{
			this.graphics.clear();

			_animationPanel = new AnimationPanel();
			addChildAt(_animationPanel, 0);
			_animationPanel.init();

			_emitter = new Firework();
			_emitter.addEventListener( EmitterEvent.EMITTER_EMPTY, launchFirework, false, 0, true );

			var renderer:BitmapRenderer = new BitmapRenderer( new Rectangle( 0, 0, Config.SIZE.x, Config.SIZE.y ) );
			renderer.addFilter( new BlurFilter( 2, 2, 1 ) );
			renderer.addFilter( new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.95,0 ] ) );
			renderer.addEmitter( _emitter );
			addChild( renderer );

			launchFirework(null);
		}

		private function launchFirework(event:EmitterEvent):void
		{
			_emitter.x = Math.random() * 400 + 200;
			_emitter.y = Math.random() * 300 + 150;

			_emitter.start();
		}
	}
}
