package idv.cjcat.pyronova.nodes {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import idv.cjcat.pyronova.transform.color.PyroColorTransform;
	import idv.cjcat.pyronova.transform.PyroTransform;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class BlurNode extends PyroNode {
		
		//inputs
		//------------------------------------------------------------------------------------------------
		
		public var inputTransform:PyroTransform;
		public var inputColorTransform:PyroColorTransform;
		private var _input:PyroNode;
		public function get input():PyroNode { return _input; }
		public function set input(value:PyroNode):void {
			_input = value;
		}
		
		override public function getInputNodes():Array {
			return [input];
		}
		
		//------------------------------------------------------------------------------------------------
		//end of inputs
		
		
		private var _filter:BlurFilter = new BlurFilter();
		
		private var _blurX:Number;
		private var _blurY:Number;
		private var _quality:int;
		
		public function BlurNode(input:PyroNode = null, blurX:Number = 4, blurY:Number = 4, quality:int = 1) {
			this.input = input;
			_blurX = blurX;
			_blurY = blurY;
			_quality = quality;
			updateFilter();
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
		

		//filter
		//------------------------------------------------------------------------------------------------
		
		private function updateFilter():void {
			_filter = new BlurFilter(_blurX, _blurY, _quality);
		}
		
		public function get blurX():Number { return _blurX; }
		public function set blurX(value:Number):void {
			_blurX = value;
			updateFilter();
		}
		
		public function get blurY():Number { return _blurY; }
		public function set blurY(value:Number):void {
			_blurY = value;
			updateFilter();
		}
		
		public function get quality():int { return _quality; }
		public function set quality(value:int):void {
			_quality = value;
			updateFilter();
		}
		
		//------------------------------------------------------------------------------------------------
		//end of filter
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObject():Array {
			return [input, inputTransform, inputColorTransform];
		}
		
		override public function getXMLTagName():String {
			return "BlurNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@input = input.name;
			xml.@inputTransform = (inputTransform)?(inputTransform.name):(null);
			xml.@inputColorTransform = (inputColorTransform)?(inputColorTransform.name):(null);
			xml.@blurX = blurX;
			xml.@blurY = blurY;
			xml.@quality = quality;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			input = builder.getElementByName(xml.@input) as PyroNode;
			inputTransform = builder.getElementByName(xml.@inputTransform) as PyroTransform;
			inputColorTransform = builder.getElementByName(xml.@inputColorTransform) as PyroColorTransform;
			blurX = parseFloat(xml.@blurX);
			blurY = parseFloat(xml.@blurY);
			quality = parseInt(xml.@quality);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}