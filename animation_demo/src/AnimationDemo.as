package
{
	import fireworks.FireworksPanel;

	import fl.controls.Button;

	import flash.display.BlendMode;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;

	import gd.eggs.loading.BulkProgressEvent;

	import movieclips.McFactory;
	import movieclips.McPanel;


	[SWF (width=800, height=600, backgroundColor=0xaaaaaa, frameRate=40)]
	public class AnimationDemo extends Sprite
	{
		private var _coinsPanel:McPanel;
		private var _fireworksPanel:FireworksPanel;

		private var _startBtn:Button;


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
		}

		private function onStartClick(event:MouseEvent):void
		{
			removeChild(_startBtn);

			_coinsPanel ||= new McPanel();
			_coinsPanel.addEventListener(Event.COMPLETE, onAnimationComplete);
			_coinsPanel.addEventListener(McPanel.START_CLOSING, onAnimationClosing);
			_coinsPanel.cacheAsBitmap = true;

			_fireworksPanel ||= new FireworksPanel();
			_fireworksPanel.blendMode = BlendMode.ADD;
			_fireworksPanel.cacheAsBitmap = true;


			McFactory.dispatcher.addEventListener(Event.COMPLETE, onAllLoaded);
			McFactory.dispatcher.addEventListener(ProgressEvent.PROGRESS, onProgress);
			McFactory.init();
		}



		private function onProgress(event:BulkProgressEvent):void
		{
			var rect:Rectangle = new Rectangle(200, 290, 400, 20);
			this.graphics.clear();
			this.graphics.lineStyle(2);
			this.graphics.drawRoundRect(rect.x, rect.y, rect.width, rect.height, 3);

			this.graphics.lineStyle();
			this.graphics.beginFill(0x00ff00);
			this.graphics.drawRoundRect(rect.x + 1, rect.y + 1, rect.width * McFactory.percentLoaded, 18, 3);
			this.graphics.endFill();
		}

		private function onAllLoaded(event:BulkProgressEvent):void
		{
			this.graphics.clear();

			_coinsPanel.start();
			_fireworksPanel.start();

			addChild(_coinsPanel);
			addChild(_fireworksPanel);
		}

		private function onAnimationClosing(event:Event):void
		{
			_fireworksPanel.stop();
		}

		private function onAnimationComplete(event:Event):void
		{
			_coinsPanel.clean();

			removeChild(_coinsPanel);
			removeChild(_fireworksPanel);

			addChild(_startBtn);
		}
	}
}
