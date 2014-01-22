package idv.cjcat.pyronova.display {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import idv.cjcat.pyronova.display.PyroLayer;
	import idv.cjcat.pyronova.nodes.PyroNode;
	import idv.cjcat.pyronova.pyro;
	import idv.cjcat.pyronova.xml.IPyroElement;
	import idv.cjcat.pyronova.xml.XMLBuilder;
	
	public class PyroCanvas extends Sprite implements IPyroElement {
		
		private var _name:String;
		override public function get name():String { return _name; }
		override public function set name(value:String):void { super.name = _name = value; }
		
		public var renderList:Array;
		
		private var _transparent:Boolean;
		private var _fillColor:Boolean;
		
		public function PyroCanvas() {
			var str:String = getXMLTagName();
			if (XMLBuilder.pyro::elementCounter[str] == undefined) XMLBuilder.pyro::elementCounter[str] = 0;
			else XMLBuilder.pyro::elementCounter[str]++;
			this.name = str + "_" + XMLBuilder.pyro::elementCounter[str];
		}
		
		public function render(e:Event = null):void {
			var i:int;
			var len:int = numChildren;
			
			if (renderList) {
				for each (var node:PyroNode in renderList) {
					node.pyro::doRender();
				}
			} else {
				for (var key:* in _visited) delete _visited[key];
				for (i = 0; i < len; i++) {
					renderChildren(PyroLayer(getChildAt(i)).rootNode);
				}
			}
			for (i = 0; i < len; i++) {
				PyroLayer(getChildAt(i)).render();
			}
		}
		
		private var _visited:Dictionary = new Dictionary();
		private function renderChildren(parentNode:PyroNode):void {
			if (parentNode) {
				if (_visited[parentNode]) return;
				
				parentNode.pyro::doRender();
				_visited[parentNode] = true;
				for each (var node:PyroNode in parentNode.getInputNodes()) {
					if (node) {
						node.pyro::doRender();
						renderChildren(node);
					}
				}
			}
		}
		
		
		//children handling
		//------------------------------------------------------------------------------------------------
		
		public function addLayer(layer:PyroLayer):PyroLayer {
			return super.addChild(layer) as PyroLayer;
		}
		
		public function addLayerAt(layer:PyroLayer, index:int):PyroLayer {
			return super.addChildAt(layer, index) as PyroLayer;
		}
		
		public function removeLayer(layer:PyroLayer):PyroLayer {
			return super.removeChild(layer) as PyroLayer;
		}
		
		public function removeLayerAt(index:int):PyroLayer {
			return super.removeChildAt(index) as PyroLayer;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			throw new Error("This method is disabled for this class.");
			return super.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			throw new Error("This method is disabled for this class.");
			return super.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			throw new Error("This method is disabled for this class.");
			return super.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			throw new Error("This method is disabled for this class.");
			return super.removeChildAt(index);
		}
		
		//------------------------------------------------------------------------------------------------
		//end of children handling
		
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		public function getRelatedObject():Array {
			var len:int = numChildren;
			var array:Array = new Array(len);
			for (var i:int = 0; i < len; i++) {
				var layer:PyroLayer = getChildAt(i) as PyroLayer;
				array[i] = layer.rootNode;
			}
			return array;
		}
		
		public function getElementTypeXMLTag():XML {
			return <display/>;
		}
		
		public function getXMLTagName():String {
			return "PyroCanvas";
		}
		
		public final function getXMLTag():XML {
			var xml:XML = XML("<" + getXMLTagName() + "/>");
			xml.@name = name;
			return xml;
		}
		
		public function toXML():XML {
			var xml:XML = getXMLTag();
			
			var len:int = numChildren;
			for (var i:int = 0; i < len; i++) {
				var layer:PyroLayer = getChildAt(i) as PyroLayer;
				var node:XML = <PyroLayer/>;
				node.@rootNode = layer.rootNode.name;
				xml.appendChild(node);
			}
			
			return xml;
		}
		
		public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			name = xml.@name;
			
			while (numChildren > 0) removeChildAt(0);
			
			for each (var node:XML in xml.*) {
				var layer:PyroLayer = new PyroLayer();
				layer.rootNode = builder.getElementByName(node.@rootNode) as PyroNode;
				addLayer(layer);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}
}