package idv.cjcat.pyronova.transform {
	import flash.geom.Matrix;
	import idv.cjcat.pyronova.xml.PyroElement;
	
	public class PyroTransform extends PyroElement {
		
		public function getMatrix():Matrix {
			return new Matrix();
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "PyroTransform";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <transforms/>;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}