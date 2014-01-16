package movieclips.atlas
{
	import flash.geom.Point;

	import gd.eggs.customanim.IAnimatable;


	public class McModel implements IAnimatable
	{
		private var _id:String;
		private var _currentFrame:int;
		private var _totalFrames:int;

		public var x:int;
		public var y:int;
		public var depth:Number;

		public function McModel(id:String, totalFrames:int, pos:Point, depth:Number)
		{
			_id = id;
			_totalFrames = totalFrames;
			_currentFrame = 0;

			this.x = pos.x;
			this.y = pos.y;
			this.depth = depth;
		}

		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			_currentFrame = int(frame) - 1;
			if (_currentFrame >= _totalFrames || _currentFrame < 0) _currentFrame = 0;
		}

		public function nextFrame():void
		{
			_currentFrame += 1;
			if(_currentFrame >= _totalFrames) _currentFrame = 0;
		}

		public function stop():void
		{
		}

		public function get id():String { return _id; }

		public function get visible():Boolean { return false; }
		public function set visible(visible:Boolean):void { }

		public function get currentFrame():int { return _currentFrame + 1; }
		public function get frame():Frame { return AtlasFactory.getFrame(_id, _currentFrame); }

		public function get totalFrames():int { return _totalFrames; }
	}
}
