package utils
{
    public class EmbeddedAssets
    {
        /** ATTENTION: Naming conventions!
         *  
         *  - Classes for embedded IMAGES should have the exact same name as the file,
         *    without extension. This is required so that references from XMLs (atlas, bitmap font)
         *    won't break.
         *    
         *  - Atlas and Font XML files can have an arbitrary name, since they are never
         *    referenced by file name.
         * 
         */
        
        // Texture Atlas
        
        [Embed(source="../../../assets/images/textures/atlas.xml", mimeType="application/octet-stream")]
        public static const atlas_xml:Class;

        [Embed(source="../../../assets/images/textures/atlas.png")]
        public static const atlas:Class;

	    [Embed(source="../../../assets/images/textures/coin.xml", mimeType="application/octet-stream")]
	    public static const coin_xml:Class;

	    [Embed(source="../../../assets/images/textures/coin.png")]
	    public static const coin:Class;
    }
}