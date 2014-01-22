package idv.cjcat.pyronova.nodes {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import idv.cjcat.pyronova.transform.color.PyroColorTransform;
	import idv.cjcat.pyronova.transform.PyroTransform;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class BitmapDataNode extends PyroNode {
		
		//inputs
		//------------------------------------------------------------------------------------------------
		
		public var input:BitmapData;
		public var inputTransform:PyroTransform;
		public var inputColorTransform:PyroColorTransform;
		
		//------------------------------------------------------------------------------------------------
		//end of inputs
		
		
		public function BitmapDataNode(input:BitmapData) {
			this.input = input;
		}
		
		override public function render(e:Event = null):void {
			clear();
			if (input) {
				var matrix:Matrix = (inputTransform)?(inputTransform.getMatrix()):(null);
				var color:ColorTransform = (inputColorTransform)?(inputColorTransform.getColorTransform()):(null);
				output.draw(input, matrix, color);
			}
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getRelatedObject():Array {
			return [inputTransform, inputColorTransform];
		}
		
		override public function getXMLTagName():String {
			return "BitmapDataNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@inputTransform = (inputTransform)?(inputTransform.name):(null);
			xml.@inputColorTransform = (inputColorTransform)?(inputColorTransform.name):(null);
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			inputTransform = builder.getElementByName(xml.@inputTransform) as PyroTransform;
			inputColorTransform = builder.getElementByName(xml.@inputColorTransform) as PyroColorTransform;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}