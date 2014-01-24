package idv.cjcat.pyronova.transform.color {
	import flash.geom.ColorTransform;
	
	public class TintTransform extends PyroColorTransform {
		
		private var _colorTransform:ColorTransform;
		
		public function TintTransform(red:Number = 0, green:Number = 0, blue:Number = 0) {
			_colorTransform = new ColorTransform();
			_colorTransform.redOffset = red;
			_colorTransform.greenOffset = green;
			_colorTransform.blueOffset = blue;
		}
		
		override public function getColorTransform():ColorTransform {
			return _colorTransform;
		}
		
		public function get red():Number { return _colorTransform.redOffset; }
		public function set red(value:Number):void {
			_colorTransform.redOffset = value;
		}
		
		public function get green():Number { return _colorTransform.greenOffset; }
		public function set green(value:Number):void {
			_colorTransform.greenOffset = value;
		}
		
		public function get blue():Number { return _colorTransform.blueOffset; }
		public function set blue(value:Number):void {
			_colorTransform.blueOffset = value;
		}
	}
}