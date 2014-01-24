package idv.cjcat.pyronova.nodes {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import idv.cjcat.pyronova.transform.color.PyroColorTransform;
	import idv.cjcat.pyronova.transform.PyroTransform;
	import idv.cjcat.pyronova.utils.ColorMatrix;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class ContrastNode extends PyroNode {
		
		//inputs
		//------------------------------------------------------------------------------------------------
		
		public var inputTransform:PyroTransform;
		public var inputColorTransform:PyroColorTransform;
		private var _input:PyroNode;
		public function get input():PyroNode { return _input; }
		public function set input(value:PyroNode):void {
			_input = value;
		}
		
		public function get level():Number { return _level; }
		public function set level(value:Number):void {
			_level = value;
			_filter.matrix = ColorMatrix.contrast(level);
		}
		
		override public function getInputNodes():Array {
			return [input];
		}
		
		//------------------------------------------------------------------------------------------------
		//end of inputs
		
		
		private var _level:Number;
		private var _filter:ColorMatrixFilter;
		
		public function ContrastNode(input:PyroNode = null, level:Number = 1 / 11) {
			_filter = new ColorMatrixFilter();
			this.level = level;
			this.input = input;
		}
		
		private var _point:Point = new Point(0, 0);
		override public function render(e:Event = null):void {
			clear();
			if (_input) {
				var matrix:Matrix = (inputTransform)?(inputTransform.getMatrix()):(null);
				var color:ColorTransform = (inputColorTransform)?(inputColorTransform.getColorTransform()):(null);
				var source:BitmapData;
				if (matrix || color) {
					output.draw(_input.getOutput(), matrix, color);
					source = output;
				} else {
					source = _input.getOutput();
				}
				output.applyFilter(source, output.rect, _point, _filter);
			}
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObject():Array {
			return [input, inputTransform, inputColorTransform];
		}
		
		override public function getXMLTagName():String {
			return "ContrastNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@input = input.name;
			xml.@inputTransform = (inputTransform)?(inputTransform.name):(null);
			xml.@inputColorTransform = (inputColorTransform)?(inputColorTransform.name):(null);
			xml.@level = level;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			input = builder.getElementByName(xml.@input) as PyroNode;
			inputTransform = builder.getElementByName(xml.@inputTransform) as PyroTransform;
			inputColorTransform = builder.getElementByName(xml.@inputColorTransform) as PyroColorTransform;
			level = parseFloat(xml.@level);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}