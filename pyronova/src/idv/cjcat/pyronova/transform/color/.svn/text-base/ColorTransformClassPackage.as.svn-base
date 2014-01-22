package idv.cjcat.pyronova.transform.color {
	import idv.cjcat.pyronova.xml.ClassPackage;
	
	public class ColorTransformClassPackage extends ClassPackage {
		
		private static var _instance:ColorTransformClassPackage;
		
		public static function getInstance():ColorTransformClassPackage {
			if (!_instance) _instance = new ColorTransformClassPackage();
			return _instance;
		}
		
		override protected final function populateClasses():void {
			classes.push(BasicColorTransform);
			classes.push(ExposureTransform);
			classes.push(TintTransform);
		}
	}
}