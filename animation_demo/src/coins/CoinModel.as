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

		internal function nextFrame():void
		{
			frame += 1;
			if(frame >= totalFrames) frame = 0;
		}
	}
}
