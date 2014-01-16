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
	import flash.system.Security;

	import gd.eggs.customanim.AnimationManager;
	import gd.eggs.util.GlobalTimer;

	import movieclips.McPanel;
	import movieclips.atlas.AtlasFactory;

	import utils.Counter;


	[SWF (width=800, height=600, backgroundColor=0xaaaaaa, frameRate=40)]
	public class AnimationDemo extends Sprite
	{
		private var _counter:Counter;
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

			_counter = new Counter();
			addChild(_counter);

			_startBtn = new Button();

			_startBtn.addEventListener(MouseEvent.CLICK, onStartClick);

			_startBtn.label = "Start";
			_startBtn.x = (Config.SCREEN_SIZE.x - _startBtn.width) * 0.5;
			_startBtn.y = (Config.SCREEN_SIZE.y - _startBtn.height) * 0.5;

			addChild(_startBtn);

			AtlasFactory.init();

			GlobalTimer.addFrameCallback(onFrame);
		}

		private function onFrame(date:int):void
		{
			_counter.coins = _coinsPanel ? _coinsPanel.coinsNum : 0;
			_counter.emitters = _fireworksPanel ? _fireworksPanel.emittersNum : 0;
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
			_fireworksPanel.clean();

			removeChild(_coinsPanel);
			removeChild(_fireworksPanel);

			AnimationManager.clean();

			addChild(_startBtn);
		}

	}
}
