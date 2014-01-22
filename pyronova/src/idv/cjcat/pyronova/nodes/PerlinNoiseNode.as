package idv.cjcat.pyronova.nodes {
	import flash.events.Event;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class PerlinNoiseNode extends PyroNode {
		
		public var baseX:Number;
		public var baseY:Number;
		public var numOctaves:uint;
		public var randomSeed:int;
		public var stitch:Boolean;
		public var fractalNoise:Boolean;
		public var channelOptions:uint;
		public var grayscale:Boolean;
		public var offsets:Array;
		
		public function PerlinNoiseNode(baseX:Number = 40, baseY:Number = 40, numOctaves:uint = 1, randomSeed:int = 0, stitch:Boolean = true, fractalNoise:Boolean = true, channelOptions:uint = 7, grayscale:Boolean = false, offsets:Array = null) {
			this.baseX = baseX;
			this.baseY = baseY;
			this.numOctaves = numOctaves;
			this.randomSeed = randomSeed;
			this.stitch = stitch;
			this.fractalNoise = fractalNoise;
			this.channelOptions = channelOptions;
			this.grayscale = grayscale;
			this.offsets = offsets;
		}
		
		override public function render(e:Event = null):void {
			output.perlinNoise(baseX, baseY, numOctaves, randomSeed, stitch, fractalNoise, channelOptions, grayscale, offsets);
		}
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		override public function getXMLTagName():String {
			return "NoiseNode";
		}
		
		override public function toXML():XML {
			var xml:XML = super.toXML();
			
			xml.@baseX = baseX;
			xml.@baseY = baseY;
			xml.@channelOptions = channelOptions;
			xml.@fractalNoise = fractalNoise;
			xml.@grayscale = grayscale;
			xml.@randomSeed = randomSeed;
			xml.@stitch = stitch;
			
			return xml;
		}
		
		override public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			super.parseXML(xml, builder);
			
			baseX = parseFloat(xml.@baseX);
			baseY = parseFloat(xml.@baseY);
			channelOptions = parseInt(xml.@channelOptions);
			fractalNoise = (xml.@fractalNoise == "true");
			grayscale = (xml.@grayscale == "true");
			randomSeed = parseInt(xml.@randomSeed);
			stitch = (xml.@stitch == "true");
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}