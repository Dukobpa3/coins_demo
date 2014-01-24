package idv.cjcat.pyronova.nodes {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import idv.cjcat.pyronova.transform.color.PyroColorTransform;
	import idv.cjcat.pyronova.transform.PyroTransform;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class DisplacementNode extends PyroNode {
		
		//inputs
		//------------------------------------------------------------------------------------------------
		
		public var inputTransform:PyroTransform;
		public var inputColorTransform:PyroColorTransform;
		private var _input:PyroNode;
		public function get input():PyroNode { return _input; }
		public function set input(value:PyroNode):void {
			_input = value;
		}
		
		public var mapTransform:PyroTransform;
		public var mapColorTransform:PyroColorTransform;
		private var _map:PyroNode;
		public function get map():PyroNode { return _map; }
		public function set map(value:PyroNode):void {
			_map = value;
		}
		
		override public function getInputNodes():Array {
			return [input, map];
		}
		
		//------------------------------------------------------------------------------------------------
		//end of inputs
		
		
		private var _componentX:uint;
		private var _componentY:uint;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _mode:String;
		
		public function DisplacementNode(input:PyroNode = null, map:PyroNode = null, componentX:uint = 1, componentY:uint = 2, scaleX:Number = 20, scaleY:Number = 20, mode:String = "wrap") {
			this.input = input;
			this.map = map;
			
			_componentX = componentX;
			_componentY = componentY;
			_scaleX = scaleX;
			_scaleY = scaleY;
			_mode = mode;
			
			updateFilter();
		}
		
		private var _filter:DisplacementMapFilter = new DisplacementMapFilter();
		private var _point:Point = new Point(0, 0);
		override public function render(e:Event = null):void {
			clear();
			if (_input && _map) {
				var mapMatrix:Matrix = (mapTransform)?(mapTransform.getMatrix()):(null);
				var mapColor:ColorTransform = (mapColorTransform)?(mapColorTransform.getColorTransform()):(null);
				if (mapMatrix || mapColor) {
					var temp:BitmapData = new BitmapData(width, height, _map.getOutput().transparent, 0x808080);
					temp.draw(_map.getOutput(), mapMatrix, mapColor);
					_filter.mapBitmap = temp;
				} else {
					_filter.mapBitmap = _map.getOutput();
				}
				
				var inputMatrix:Matrix = (inputTransform)?(inputTransform.getMatrix()):(null);
				var inputColor:ColorTransform = (inputColorTransform)?(inputColorTransform.getColorTransform()):(null);
				output.draw(input.getOutput(), inputMatrix, inputColor);
				output.applyFilter(output, output.rect, _point, _filter);
			}
		}
		
		
		//filter
		//------------------------------------------------------------------------------------------------
		
		private function updateFilter():void {
			_filter.componentX = _componentX;
			_filter.componentY = _componentY;
			_filter.scaleX = _scaleX;
			_filter.scaleY = _scaleY;
			_filter.mode = _mode;
		}
		
		public function get componentX():uint { return _componentX; }
		public function set componentX(value:uint):void {
			_componentX = value;
			updateFilter();
		}
		
		public function get componentY():uint { return _componentY; }
		public function set componentY(value:uint):void {
			_componentY = value;
			updateFilter();
		}
		
		public function get scaleX():Number { return _scaleX; }
		public function set scaleX(value:Number):void {
			_scaleX = value;
			updateFilter();
		}
		
		public function get scaleY():Number { return _scaleY; }
		public function set scaleY(value:Number):void {
			_scaleY = value;
			updateFilter();
		}
		
		public function get mode():String { return _mode; }
		public function set mode(value:String):void {
			_mode = value;
			updateFilter();
		}
		
		//------------------------------------------------------------------------------------------------
		//end of filter
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObject():Array {
			return [input, inputTransform, inputColorTransform, map, mapTransform, mapColorTransform];
		}
		
		override public function getXMLTagName():String {
			return "DisplacementNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@input = input.name;
			xml.@inputTransform = (inputTransform)?(inputTransform.name):(null);
			xml.@inputColorTransform = (inputColorTransform)?(inputColorTransform.name):(null);
			xml.@map = map.name;
			xml.@mapTransform = (mapTransform)?(mapTransform.name):(null);
			xml.@mapColorTransform = (mapColorTransform)?(mapColorTransform.name):(null);
			
			xml.@componentX = componentX;
			xml.@componentY = componentY;
			xml.@scaleX = scaleX;
			xml.@scaleY = scaleY;
			xml.@mode = mode;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			input = builder.getElementByName(xml.@input) as PyroNode;
			inputTransform = builder.getElementByName(xml.@inputTransform) as PyroTransform;
			inputColorTransform = builder.getElementByName(xml.@inputColorTransform) as PyroColorTransform;
			map = builder.getElementByName(xml.@map) as PyroNode;
			mapTransform = builder.getElementByName(xml.@mapTransform) as PyroTransform;
			mapColorTransform = builder.getElementByName(xml.@mapColorTransform) as PyroColorTransform;
			
			componentX = parseInt(xml.@componentX);
			componentY = parseInt(xml.@componentY);
			scaleX = parseInt(xml.@scaleX);
			scaleY = parseInt(xml.@scaleY);
			mode = xml.@mode;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}