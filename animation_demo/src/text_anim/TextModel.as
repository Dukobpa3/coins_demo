/**
 * Created by oburdun on 1/14/14.
 */
package text_anim
{
	import flash.geom.Point;


	public class TextModel
	{
		public var id:String;
		public var frame:int;
		public var totalFrames:int;

		public var x:int;
		public var y:int;
		public var depth:Number;


		public function TextModel(id:String, totalFrames:int, pos:Point, depth:Number)
		{
			this.id = id;
			this.x = pos.x;
			this.y = pos.y;
			this.depth = depth;
			this.totalFrames = totalFrames;
			this.frame = 0;
		}

		internal function nextFrame():void
		{
			frame += 1;
			if(frame >= totalFrames) frame = 0;
		}
	}
}
