package idv.cjcat.pyronova.xml {
	
	public interface IPyroXMLSerializable {
		function get name():String;
		function set name(value:String):void;
		function getRelatedObject():Array;
		function getXMLTagName():String;
		function getXMLTag():XML;
		function getElementTypeXMLTag():XML;
		function toXML():XML;
		function parseXML(xml:XML, builder:XMLBuilder = null):void;
	}
}