package idv.cjcat.pyronova.display {
	import flash.display.Bitmap;
	import idv.cjcat.pyronova.nodes.PyroNode;
	import idv.cjcat.pyronova.pyro;
	
	public class PyroLayer extends Bitmap {
		
		public var rootNode:PyroNode;
		
		public function PyroLayer(rootNode:PyroNode = null) {
			this.rootNode = rootNode;
		}
		
		/** @private */
		internal function render():void {
			if (rootNode) bitmapData = rootNode.getOutput();
			else bitmapData = null;
		}
	}
}