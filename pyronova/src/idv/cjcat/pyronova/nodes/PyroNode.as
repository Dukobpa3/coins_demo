package idv.cjcat.pyronova.nodes {
	import flash.display.BitmapData;
	import flash.events.Event;
	import idv.cjcat.pyronova.pyro;
	import idv.cjcat.pyronova.xml.PyroElement;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class PyroNode extends PyroElement {
		
		protected var output:BitmapData;
		
		private var _width:Number;
		private var _height:Number;
		private var _transparent:Boolean;
		private var _fillColor:uint;
		
		public function PyroNode(width:Number = 320, height:Number = 240, transparent:Boolean = true, fillColor:uint = 0) {
			output = new BitmapData(width, height, transparent, fillColor);
			this.transparent = transparent;
			this.fillColor = fillColor;
		}
		
		/** @private */
		pyro final function doRender():void {
			output.lock();
			render();
			output.unlock();
		}
		
		public function getOutput():BitmapData { return output; }
		
		protected final function clear():void {
			if (transparent) output.fillRect(output.rect, 0);
			else output.fillRect(output.rect, uint(0xFF000000) | uint(fillColor));
		}
		
		/**
		 * [AbstracolorTransform]
		 */
		public function render(e:Event = null):void {
			//abstracolorTransform method
		}
		
		public function getInputNodes():Array {
			return [];
		}
		
		//bitmap properties
		//------------------------------------------------------------------------------------------------
		
		public function setSize(width:Number, height:Number):void {
			if ((width != _width) || (height != _height)) {
				output = new BitmapData(width, height, _transparent, _fillColor);
			}
		}
		
		public function get width():Number { return output.width; }
		public function set width(value:Number):void {
			if (value != output.width) {
				output = new BitmapData(int(value), output.height, _transparent, _fillColor);
			}
		}
		
		public function get height():Number { return output.height; }
		public function set height(value:Number):void {
			if (value != output.height) {
				output = new BitmapData(output.width, int(value), _transparent, _fillColor);
			}
		}
		
		public function get transparent():Boolean { return _transparent; }
		public function set transparent(value:Boolean):void {
			if (value != _transparent) {
				_transparent = value;
				output = new BitmapData(output.width, output.height, _transparent, _fillColor);
			}
		}
		
		public function get fillColor():uint { return _fillColor; }
		public function set fillColor(value:uint):void {
			if (value != _fillColor) {
				_fillColor = value;
				output = new BitmapData(output.width, output.height, _transparent, _fillColor);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of bitmap properties
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "PyroNode";
		}
		
		override public function getElementTypeXMLTag():XML {
			return <nodes/>;
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@width = width;
			xml.@height = height;
			xml.@fillColor = fillColor.toString(16);
			xml.@transparent = transparent;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			width = parseFloat(xml.@width);
			height = parseFloat(xml.@height);
			fillColor = parseInt(xml.@fillColor, 16);
			transparent = (xml.@transparent == "true");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}