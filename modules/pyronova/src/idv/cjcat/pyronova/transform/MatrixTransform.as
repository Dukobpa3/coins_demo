package idv.cjcat.pyronova.transform {
	import flash.geom.Matrix;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class MatrixTransform extends PyroTransform {
		
		private var _matrix:Matrix;
		
		public function MatrixTransform(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0) {
			this.matrix = new Matrix(a, b, c, d, tx, ty);
		}
		
		override public function getMatrix():Matrix {
			return _matrix;
		}
		
		public function get matrix():Matrix { return _matrix; }
		public function set matrix(value:Matrix):void {
			if (!value) value = new Matrix();
			_matrix = value;
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "MatrixTransform";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@a = matrix.a;
			xml.@b = matrix.b;
			xml.@c = matrix.c;
			xml.@d = matrix.d;
			xml.@tx = matrix.tx;
			xml.@ty = matrix.ty;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			matrix.a = parseFloat(xml.@a);
			matrix.b = parseFloat(xml.@b);
			matrix.c = parseFloat(xml.@c);
			matrix.d = parseFloat(xml.@d);
			matrix.tx = parseFloat(xml.@tx);
			matrix.ty = parseFloat(xml.@ty);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}