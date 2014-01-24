package idv.cjcat.pyronova.nodes {
	import idv.cjcat.pyronova.xml.ClassPackage;
	
	public class NodeClassPackage extends ClassPackage {
		
		private static var _instance:NodeClassPackage;
		
		public static function getInstance():NodeClassPackage {
			if (!_instance) _instance = new NodeClassPackage();
			return _instance;
		}
		
		override protected final function populateClasses():void {
			classes.push(BitmapDataNode);
			classes.push(BitmapFilterNode);
			classes.push(BlurNode);
			classes.push(ContrastNode);
			classes.push(DisplacementNode);
			classes.push(DisplayObjectNode);
			classes.push(GrayscaleNode);
			classes.push(HueNode);
			classes.push(NegativeNode);
			classes.push(NoiseNode);
			classes.push(PerlinNoiseNode);
			classes.push(RedrawNode);
			classes.push(SaturationNode);
		}
	}
}