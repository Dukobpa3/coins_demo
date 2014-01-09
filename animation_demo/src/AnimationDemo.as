package
{
	import coins.AnimationPanel;

	import fl.controls.Button;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Security;


	[SWF (width=800, height=600, backgroundColor=0xaaaaaa)]
	public class AnimationDemo extends Sprite
	{
		private var _animationPanel:AnimationPanel;

		private var _startBtn:Button;
		private var _pauseBtn:Button;

		private var _playing:Boolean;

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
			_pauseBtn = new Button();

			_startBtn.addEventListener(MouseEvent.CLICK, onStartClick);
			_pauseBtn.addEventListener(MouseEvent.CLICK, onPauseClick);

			_startBtn.label = "Start";
			_startBtn.x = (stage.stageWidth - _startBtn.width) * 0.5;
			_startBtn.y = (stage.stageHeight - _startBtn.height) * 0.5;

			_pauseBtn.label = "Pause";
			_pauseBtn.x = (stage.stageWidth - _pauseBtn.width) * 0.5;
			_pauseBtn.y = (stage.stageHeight - _pauseBtn.height) * 0.5;
			_pauseBtn.visible = false;

			addChild(_startBtn);
			addChild(_pauseBtn);

			GlobalTimer.updateDate(new Date());
		}

		private function onStartClick(event:MouseEvent):void
		{
			_animationPanel = new AnimationPanel();
			addChildAt(_animationPanel, 0);
			_animationPanel.init();

			_startBtn.visible = false;
			_pauseBtn.visible = true;

			_playing = true;
		}

		private function onPauseClick(event:MouseEvent):void
		{
			if (_playing)
			{
				_animationPanel.pause();
				_playing = false;
				_pauseBtn.label = "Resume";
			}
			else
			{
				_animationPanel.resume();
				_playing = true;
				_pauseBtn.label = "Pause";
			}
		}
	}
}
