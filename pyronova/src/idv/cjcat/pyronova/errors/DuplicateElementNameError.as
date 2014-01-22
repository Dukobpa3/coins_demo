package idv.cjcat.pyronova.errors {
	import idv.cjcat.pyronova.xml.IPyroElement;
	
	/**
	 * This error is thrown when an <code>XMLBuilder</code> objecolorTransform encounters more than one elements having the same name.
	 */
	public class DuplicateElementNameError extends Error {
		
		private var _obj1:IPyroElement;
		private var _obj2:IPyroElement;
		private var _name:String;
		
		public function DuplicateElementNameError(message:*, elementName:String, obj1:IPyroElement, obj2:IPyroElement) {
			super(message);
			_obj1 = obj1;
			_obj2 = obj2;
			_name = elementName;
		}
		
		public function get obj1():IPyroElement { return _obj1; }
		public function get obj2():IPyroElement { return _obj2; }
		public function get elementName():String { return _name; }
	}
}