package idv.cjcat.pyronova.nodes {
	import flash.events.Event;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class NoiseNode extends PyroNode {
		
		public var randomSeed:int;
		public var low:uint;
		public var high:uint;
		public var channelOptions:uint;
		public var grayscale:Boolean;
		
		public function NoiseNode(randomSeed:int = 0, low:uint = 0, high:uint = 255, channelOptions:uint = 7, grayscale:Boolean = false) {
			this.randomSeed = randomSeed;
			this.low = low;
			this.high = high;
			this.channelOptions = channelOptions;
			this.grayscale = grayscale;
		}
		
		override public function render(e:Event = null):void {
			output.noise(randomSeed, low, high, channelOptions, grayscale);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "NoiseNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@randomSeed = randomSeed;
			xml.@low = low;
			xml.@high = high;
			xml.@channelOptions = channelOptions;
			xml.@grayscale = grayscale;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			randomSeed = parseInt(xml.@randomSeed);
			low = parseInt(xml.@low);
			high = parseInt(xml.@high);
			channelOptions = parseInt(xml.@channelOptions);
			grayscale = (xml.@grayscale == "true");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}