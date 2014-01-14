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
        
        [Embed(source="/atlas.xml", mimeType="application/octet-stream")]
        public static const atlas_xml:Class;

        [Embed(source="/atlas.png")]
        public static const atlas:Class;

	    [Embed(source="/coin.xml", mimeType="application/octet-stream")]
	    public static const coin_xml:Class;

	    [Embed(source="/coin.png")]
	    public static const coin:Class;
    }
}