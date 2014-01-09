package coins
{
	import flash.geom.Point;


	public class CoinModel
	{
		private var _id:String;
		private var _frame:int;
		private var _totalFrames:int;

		private var _x:int;
		private var _y:int;
		private var _depth:Number;


		public function CoinModel(id:String, totalFrames:int, pos:Point, depth:Number)
		{
			_id = id;
			_totalFrames = totalFrames;

			_x = pos.x;
			_y = pos.y;

			_depth = depth;
		}

		public function init():void
		{
			_frame = Math.random() * _totalFrames;
		}

		public function move():void
		{
			_y += 20 * _depth;
			if (_y >= 600) _y = -102;
		}

		public function nextFrame():void
		{
			_frame ++;
			if(_frame >= _totalFrames) _frame = 0;
		}

		public function get id():String { return _id; }
		public function get frame():int { return _frame; }

		public function get x():int { return _x; }
		public function get y():int { return _y; }

		public function get depth():Number { return _depth; }
	}
}
