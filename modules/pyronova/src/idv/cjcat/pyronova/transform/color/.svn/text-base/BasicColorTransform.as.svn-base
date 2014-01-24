package idv.cjcat.pyronova.transform.color {
	import flash.geom.ColorTransform;
	
	public class BasicColorTransform extends PyroColorTransform {
		
		private var _colorTransform:ColorTransform;
		
		public function BasicColorTransform(colorTransform:ColorTransform = null) {
			this.colorTransform = colorTransform;
		}
		
		override public function getColorTransform():ColorTransform {
			return _colorTransform;
		}
		
		public function get colorTransform():ColorTransform { return _colorTransform; }
		public function set colorTransform(value:ColorTransform):void {
			if (value == null) value = new ColorTransform();
			_colorTransform = value;
		}
	}
}