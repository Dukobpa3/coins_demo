package idv.cjcat.pyronova.xml {
	
	/**
	 * An <code>XMLBuilder</code> objecolorTransform needs to know the mapping between an XML tag's name and an acolorTransformual class. 
	 * This class encapsulates multiple classes for the <code>XMLBuilder.registerClassesFromClassPackage()</code> method 
	 * to register multiple classes (i.e. build the mapping relations).
	 */
	public class ClassPackage {
		
		private static var _instance:ClassPackage;
		
		protected var classes:Array;
		
		public static function getInstance():ClassPackage {
			if (_instance) _instance = new ClassPackage();
			return _instance;
		}
		
		public function ClassPackage() {
			classes = [];
			populateClasses();
		}
		
		/**
		 * Returns an array of classes.
		 * @return
		 */
		public final function getClasses():Array { return classes.concat(); }
		
		/**
		 * [AbstracolorTransform Method] Populates classes.
		 */
		protected function populateClasses():void {
			
		}
	}
}