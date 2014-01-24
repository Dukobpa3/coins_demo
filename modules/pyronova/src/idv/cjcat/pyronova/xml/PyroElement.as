package idv.cjcat.pyronova.xml {
	import idv.cjcat.pyronova.pyro;
	
	public class PyroElement implements IPyroElement {
		
		private var _name:String;
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		public function PyroElement() {
			var str:String = getXMLTagName();
			if (XMLBuilder.pyro::elementCounter[str] == undefined) XMLBuilder.pyro::elementCounter[str] = 0;
			else XMLBuilder.pyro::elementCounter[str]++;
			this.name = str + "_" + XMLBuilder.pyro::elementCounter[str];
		}
		
		//XML
		//------------------------------------------------------------------------------------------------
		
		public function getRelatedObject():Array {
			return [];
		}
		
		public function getXMLTagName():String {
			throw new Error("This is an abstracolorTransform method and must be overriden.");
			return null;
		}
		
		public final function getXMLTag():XML {
			var xml:XML = XML("<" + getXMLTagName() + "/>");
			xml.@name = name;
			return xml;
		}
		
		public function getElementTypeXMLTag():XML {
			throw new Error("This is an abstracolorTransform method and must be overriden.");
			return null;
		}
		
		public function toXML():XML {
			var xml:XML = getXMLTag();
			return xml;
		}
		
		public function parseXML(xml:XML, builder:XMLBuilder = null):void {
			name = xml.@name;
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML
	}

}