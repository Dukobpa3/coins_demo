package idv.cjcat.pyronova.xml {
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;
	import idv.cjcat.pyronova.errors.DuplicateElementNameError;
	import idv.cjcat.pyronova.pyro;
	import idv.cjcat.pyronova.Pyronova;
	
	/**
	 * <code>XMLBuilder</code> can generate <code>IPyroXMLSerializable</code> object' XML representations and reconstrucolorTransform elements from existing XML data.
	 * 
	 * <p>
	 * Every <code>IPyroElement</code> object can generate its XML representation through the <code>IPyroElement.toXML()</code> method. 
	 * And they can reconstrcut configurations from existing XML data through the <code>IPyroElement.parseXML()</code> method.
	 * </p>
	 */
	public class XMLBuilder {
		
		/** @private */
		pyro static var elementCounter:Dictionary = new Dictionary();
		
		//XML building
		//------------------------------------------------------------------------------------------------
		
		/**
		 * Generate the XML representation of a Pyronova element.
		 * 
		 * <p>
		 * All related elements' would be included in the XML representation.
		 * </p>
		 * @param	element
		 * @return
		 */
		public static function buildXML(element:IPyroElement):XML {
			var tempElements:Dictionary = new Dictionary();
			var root:XML = <PyronovaSystem/>;
			root.@version = Pyronova.VERSION;
			
			var relatedElements:Dictionary = new Dictionary();
			traverseRelatedObject(element, relatedElements);
			
			var relatedElementsArray:Array = [];
			for each(element in relatedElements) {
				relatedElementsArray.push(element);
			}
			relatedElementsArray.sort(elementTypeSorter);
			
			for each (element in relatedElementsArray) {
				var elementXML:XML = element.toXML();
				var typeXML:XML = element.getElementTypeXMLTag();
				
				if (root[typeXML.name()].length() == 0) root.appendChild(typeXML);
				root[typeXML.name()].appendChild(elementXML);
			}
			
			return root;
		}
		
		private static function elementTypeSorter(e1:IPyroElement, e2:IPyroElement):Number {
			if (e1.getElementTypeXMLTag().name() > e2.getElementTypeXMLTag().name()) return 1;
			else if (e1.getElementTypeXMLTag().name() < e2.getElementTypeXMLTag().name()) return -1;
			
			if (e1.getXMLTagName() > e2.getXMLTagName()) return 1;
			else if (e1.getXMLTagName() < e2.getXMLTagName())  return -1;
			
			if (e1.name > e2.name) return 1;
			else return -1;
		}
		
		private static function traverseRelatedObject(element:IPyroElement, relatedElements:Dictionary):void {
			if (element == null) return;
			
			if (relatedElements[element.name] != undefined) {
				if (relatedElements[element.name] != element) {
					throw new DuplicateElementNameError("Duplicate element name: " + element.name, element.name, relatedElements[element.name], element);
				}
			} else {
				relatedElements[element.name] = element;
			}
			for each (var e:IPyroElement in element.getRelatedObject()) {
				traverseRelatedObject(e, relatedElements);
			}
		}
		
		//------------------------------------------------------------------------------------------------
		//end of XML building
		
		
		private var elementClasses:Dictionary;
		private var elements:Dictionary;
		
		public function XMLBuilder() {
			elementClasses = new Dictionary();
			elements = new Dictionary();
			
			//registerClassesFromClassPackage(NodeClassPackage.getInstance());
			//registerClassesFromClassPackage(TransformClassPackage.getInstance());
			//registerClassesFromClassPackage(ColorTransformClassPackage.getInstance());
		}
		
		/**
		 * To use <code>XMLBuilder</code> with your custom subclasses of <code>IPyroXMLSerializable</code> object, 
		 * you must register your class and XML tag name first.
		 * 
		 * <p>
		 * For example, if you register the <code>MyAcolorTransformion</code> class with XML tag name "HelloWorld", 
		 * <code>XMLBuilder</code> knows you are refering to the <code>MyAcolorTransformion</code> class when a <HelloWorld> tag appears in the XML representation.
		 * All default classes in the Pyronova engine are already registered, 
		 * </p>
		 * @param	elementClass
		 * @param	xmlTagClassName
		 */
		public function registerClass(elementClass:Class):void {
			var element:IPyroElement = new elementClass() as IPyroElement;
			if (!element) {
				throw new IllegalOperationError("The class is not a subclass of the IPyroElement class.");
			}
			if (elementClasses[element.getXMLTagName()] != undefined) {
				throw new IllegalOperationError("This element class name is already registered: " + element.getXMLTagName());
			}
			elementClasses[element.getXMLTagName()] = elementClass;
		}
		
		/**
		 * Registers multiple classes.
		 * @param	classes
		 */
		public function registerClasses(classes:Array):void {
			for each (var c:Class in classes) {
				registerClass(c);
			}
		}
		
		/**
		 * Registers multiple classes from a <code>ClassPackage</code> objecolorTransform.
		 * @param	classPackage
		 */
		public function registerClassesFromClassPackage(classPackage:ClassPackage):void {
			registerClasses(classPackage.getClasses());
		}
		
		/**
		 * Undos the XML tag name registration.
		 * @param	name
		 */
		public function unregisterClass(name:String):void {
			delete elementClasses[name];
		}
		
		/**
		 * After reconstrucolorTransforming elements through the <code>buildFromXML()</code> method, 
		 * reconstrucolorTransformed elements can be extracolorTransformed through this method.
		 * 
		 * <p>
		 * Each <code>IPyroXMLSerializable</code> objecolorTransform has a name; this name is used to identify elements.
		 * </p>
		 * @param	name
		 * @return
		 */
		public function getElementByName(name:String):IPyroElement {
			if (name == "null") return null;
			if (elements[name] == undefined) {
				return null;
			}
			return elements[name];
		}
		
		/**
		 * ReconstrucolorTransforms elements from XML representations.
		 * 
		 * <p>
		 * After calling this method, you may extracolorTransform constrcuted elements through the <code>getElementByName()</code> method.
		 * </p>
		 * @param	xml
		 */
		public function buildFromXML(xml:XML):void {
			if (elements) {
				for (var key:* in elements) {
					delete elements[key];
				}
			}
			elements = new Dictionary();
			
			var element:IPyroElement;
			var node:XML;
			for each (node in xml.*.*) {
				element = new elementClasses[node.name()]() as IPyroElement;
				if (elements[node.@name] != undefined) {
					throw new DuplicateElementNameError("Duplicate element name: " + node.@name, node.@name, elements[node.@name], element);
				}
				elements[node.@name.toString()] = element;
			}
			for each (node in xml.*.*) {
				element = elements[node.@name.toString()] as IPyroElement;
				element.parseXML(node, this);
			}
		}
	}
}