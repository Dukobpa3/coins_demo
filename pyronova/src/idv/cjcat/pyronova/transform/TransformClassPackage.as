package idv.cjcat.pyronova.transform {
	import idv.cjcat.pyronova.xml.ClassPackage;
	
	public class TransformClassPackage extends ClassPackage {
		
		private static var _instance:TransformClassPackage;
		
		public static function getInstance():TransformClassPackage {
			if (!_instance) _instance = new TransformClassPackage();
			return _instance;
		}
		
		override protected final function populateClasses():void {
			classes.push(MatrixTransform);
		}
	}
}