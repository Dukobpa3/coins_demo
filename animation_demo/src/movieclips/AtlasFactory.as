/**
 * Created by Dukobpa3 on 1/15/14.
 */
package movieclips
{
	public class AtlasFactory
	{
		[Embed(source="../../../assets/images/textures/coin.xml", mimeType="application/octet-stream")]
		public static const coin_xml:Class;
		[Embed(source="../../../assets/images/textures/coin.png")]
		public static const coin:Class;

		[Embed(source="../../../assets/images/textures/big_win_0.xml", mimeType="application/octet-stream")]
		public static const big_win_0_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_0.png")]
		public static const big_win_0:Class;

		[Embed(source="../../../assets/images/textures/big_win_1.xml", mimeType="application/octet-stream")]
		public static const big_win_1_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_1.png")]
		public static const big_win_1:Class;

		[Embed(source="../../../assets/images/textures/big_win_2.xml", mimeType="application/octet-stream")]
		public static const big_win_2_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_2.png")]
		public static const big_win_2:Class;

		[Embed(source="../../../assets/images/textures/big_win_3.xml", mimeType="application/octet-stream")]
		public static const big_win_3_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_3.png")]
		public static const big_win_3:Class;

		[Embed(source="../../../assets/images/textures/big_win_4.xml", mimeType="application/octet-stream")]
		public static const big_win_4_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_4.png")]
		public static const big_win_4:Class;

		[Embed(source="../../../assets/images/textures/big_win_5.xml", mimeType="application/octet-stream")]
		public static const big_win_5_xml:Class;
		[Embed(source="../../../assets/images/textures/big_win_5.png")]
		public static const big_win_5:Class;

		private static var _frames:Object;

		public function AtlasFactory()
		{
		}

		public static function init():void
		{

		}

		public static function getFrame(id:String, frame:int = 0):Frame
		{
			return _frames[id][frame];
		}
	}
}
