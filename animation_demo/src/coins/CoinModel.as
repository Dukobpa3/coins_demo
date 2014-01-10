package coins
{
	import flash.geom.Point;


	public class CoinModel
	{
		public var id:String;
		public var frame:int;
		public var totalFrames:int;

		public var x:int;
		public var y:int;
		public var depth:Number;


		public function CoinModel(id:String, totalFrames:int, pos:Point, depth:Number)
		{
			this.id = id;
			this.totalFrames = totalFrames;

			this.x = pos.x;
			this.y = pos.y;

			this.depth = depth;
		}

		internal function init():void
		{
			frame = Math.random() * totalFrames;
		}

		internal function move():void
		{
			y += 20 * depth;
			if (y >= 600) y = -102;
			nextFrame();
		}

		internal function nextFrame():void
		{
			frame ++;
			if(frame >= totalFrames) frame = 0;
		}
	}
}
