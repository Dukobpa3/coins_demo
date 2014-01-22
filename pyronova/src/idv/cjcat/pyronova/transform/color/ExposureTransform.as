package idv.cjcat.pyronova.transform.color {
	import flash.geom.ColorTransform;
	
	public class ExposureTransform extends PyroColorTransform {
		
		private var _colorTransform:ColorTransform;
		
		public function ExposureTransform(multiplier:Number = 1) {
			_colorTransform = new ColorTransform();
			this.multiplier = multiplier;
		}
		
		override public function getColorTransform():ColorTransform {
			return _colorTransform;
		}
		
		public function get multiplier():Number { return _colorTransform.redMultiplier; }
		public function set multiplier(value:Number):void {
			_colorTransform.redMultiplier = 
			_colorTransform.greenMultiplier = 
			_colorTransform.blueMultiplier = 
			_colorTransform.alphaMultiplier = value;
		}
	}
}