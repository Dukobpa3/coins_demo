package
{
	import coins.AnimationPanel;

	import flash.display.Sprite;

	import particles.FireWorksPanel;

	import starling.core.Starling;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;

	import starling.textures.Texture;

	import starling.utils.AssetManager;

	import utils.Config;
	import utils.ProgressBar;


	public class AnimationDemo extends starling.display.Sprite
	{
		private var _startBtn:Button;

		private var _animationPanel:AnimationPanel;
		private var _fireWorksPanel:FireWorksPanel;

		private var _preloader:ProgressBar;

		private var _assets:AssetManager;

		private var _root:flash.display.Sprite;

		public function AnimationDemo()
	    {

	    }

		public function start(root:flash.display.Sprite, assets:AssetManager):void
		{
			_root = root;
			_assets = assets;

			_preloader = new ProgressBar(175, 20);
			_preloader.x = (Config.SIZE.x - 175) * 0.5;
			_preloader.y = (Config.SIZE.y - 20) * 0.5;
			addChild(_preloader);

			assets.loadQueue(function(ratio:Number):void
			{
				_preloader.ratio = ratio;

				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay.

				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						_preloader.removeFromParent(true);
						_preloader = null;
						showUi();
					}, 0.15);
			});
		}

		private function showUi():void
		{
			var buttonTexture:Texture = _assets.getTexture("button_medium");

			_startBtn = new Button(buttonTexture, "Start");

			_startBtn.addEventListener(Event.TRIGGERED, onStartClick);

			_startBtn.x = (stage.stageWidth - _startBtn.width) * 0.5;
			_startBtn.y = (stage.stageHeight - _startBtn.height) * 0.5;

			addChild(_startBtn);
		}

		private function onStartClick(event:Event):void
		{
			_startBtn.visible = false;

			_animationPanel ||= new AnimationPanel(_assets);
			_animationPanel.addEventListener(Event.COMPLETE, onAnimationComplete);

			_fireWorksPanel ||= new FireWorksPanel(_root);

			_animationPanel.init();
			//_fireWorksPanel.start();

			addChild(_animationPanel);
			//addChild(_fireWorksPanel);
		}

		private function onAnimationComplete(event:Event):void
		{
			_animationPanel.clean();
			//_fireWorksPanel.stop();
			_startBtn.visible = true;
		}

	}
}
