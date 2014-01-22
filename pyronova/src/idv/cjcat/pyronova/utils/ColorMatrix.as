package idv.cjcat.pyronova.utils {
	
	/**
	 * This class is intended to be used with the flash.filters.ColorMatrixFilter class
	 */
	public class ColorMatrix {
		
		private static var LUMINANCE_R:Number = 0.3086;
		private static var LUMINANCE_G:Number = 0.6094;
		private static var LUMINANCE_B:Number = 0.0820;
		
		//updated in version 1.0.1 (changed from public static getter to public static constant)
		/**
		 * Identity matrix.
		 */
		public static const IDENTITY:Array = [1, 0, 0, 0, 0,
		                                      0, 1, 0, 0, 0,
											  0, 0, 1, 0, 0,
											  0, 0, 0, 1, 0];
		
		/**
		 * Digital-negative matrix.
		 */
		public static const DIGITAL_NEGATIVE:Array = [-1,  0,  0,  0, 255,
											           0, -1,  0,  0, 255,
													   0,  0, -1,  0, 255,
													   0,  0,  0,  1,   0];

		/**
		 * Grayscale matrix.
		 */
		public static const GRAYSCALE:Array = [LUMINANCE_R, LUMINANCE_G, LUMINANCE_B, 0, 0,
											   LUMINANCE_R, LUMINANCE_G, LUMINANCE_B, 0, 0,
											   LUMINANCE_R, LUMINANCE_G, LUMINANCE_B, 0, 0,
											    0,  0,  0, 1, 0];
		
		/**
		 * Returns a saturation matrix.
		 * @param	level Zero gives a grayscale matrix; one gives a fully-saturated matrix; one over three (1/3) gives an identity matrix.
		 * @return The saturation matrix.
		 */
		public static function saturation(level:Number = 1 / 3):Array {
			if (!((level >= 0) && (level <= 1))) {
				if (level > 1) {
					level = 1;
				} else {
					level = 0;
				}
			}
			var level2:Number = level * 3;
			var level3:Number = 1 - level2;
			
			return [level3 * LUMINANCE_R + level2,           level3 * LUMINANCE_G,           level3 * LUMINANCE_B, 0, 0,
			                 level3 * LUMINANCE_R,  level3 * LUMINANCE_G + level2,           level3 * LUMINANCE_B, 0, 0,
					         level3 * LUMINANCE_R,           level3 * LUMINANCE_G,  level3 * LUMINANCE_B + level2, 0, 0,
				               	       0,                     0,                     0, 1, 0];
		}
		
		/**
		 * Returns a tint matrix.
		 * @param	redTint    One gives complete red; negative one gives no red at all; zero makes no change.
		 * @param	greenTint  One gives complete green; negative one gives no green at all; zero makes no change.
		 * @param	blueTint   One gives complete blue; negative one gives no blue at all; zero makes no change.
		 * @return The tint matrix.
		 */
		public static function tint(redTint:Number = 0, greenTint:Number = 0, blueTint:Number = 0):Array {
			if (!((redTint >= -1) && (redTint <= 1))) {
				if (redTint > 1) {
					redTint = 1;
				} else {
					redTint = -1;
				}
			}
			if (!((greenTint >= -1) && (greenTint <= 1))) {
				if (greenTint > 1) {
					greenTint = 1;
				} else {
					greenTint = -1;
				}
			}
			if (!((blueTint >= -1) && (blueTint <= 1))) {
				if (blueTint > 1) {
					blueTint = 1;
				} else {
					blueTint = -1;
				}
			}
			
			return [1, 0, 0, 0,   redTint * 255,
			        0, 1, 0, 0, greenTint * 255,
					0, 0, 1, 0,  blueTint * 255,
					0, 0, 0, 1,               0];
		}
		
		/**
		 * Returns a brightness matrix.
		 * @param	level One gives complete white; negative one gives complete black; zero gives an identity matrix.
		 * @return The brightness matrix.
		 */
		public static function brightness(level:Number = 0):Array {
			if (!((level >= -1) && (level <= 1))) {
				if (level > 1) {
					level = 1;
				} else {
					level = -1;
				}
			}
			var level2:Number = level * 255;
			
			return [1, 0, 0, 0, level2,
			        0, 1, 0, 0, level2,
					0, 0, 1, 0, level2,
					0, 0, 0, 1,      0];
		}
		
		/**
		 * Returns a constrast matrix.
		 * @param	level One gives the highest contrast; zero gives zero contrast; one over eleven (1/11) gives an identity matrix.
		 * @return The contrast matrix.
		 */
		public static function contrast(level:Number = 1 / 11):Array {
			if (!((level >= 0) && (level <= 1))) {
				if (level > 1) {
					level = 1;
				} else {
					level = 0;
				}
			}
			var scale:Number = level * 11;
			var offset:Number = 63.5 - (level * 698.5);
			
			return [scale,     0,     0, 0, offset,
			            0, scale,     0, 0, offset,
					    0,     0, scale, 0, offset,
					    0,     0,     0, 1,      0];
		}
		
		/**
		 * Returns a hue-shift matrix.
		 * @param	level	The hue shift in radians.
		 */
		public static function hue(level:Number = 0):Array {
			var cos:Number = Math.cos(level);
			var sin:Number = Math.sin(level);
			var LUMINANCE_R:Number = 0.213;
			var LUMINANCE_G:Number = 0.715;
			var LUMINANCE_B:Number = 0.072;
			return [LUMINANCE_R+cos*(1-LUMINANCE_R)+sin*(-LUMINANCE_R),LUMINANCE_G+cos*(-LUMINANCE_G)+sin*(-LUMINANCE_G),LUMINANCE_B+cos*(-LUMINANCE_B)+sin*(1-LUMINANCE_B),0,0,
					LUMINANCE_R+cos*(-LUMINANCE_R)+sin*(0.143),LUMINANCE_G+cos*(1-LUMINANCE_G)+sin*(0.140),LUMINANCE_B+cos*(-LUMINANCE_B)+sin*(-0.283),0,0,
					LUMINANCE_R+cos*(-LUMINANCE_R)+sin*(-(1-LUMINANCE_R)),LUMINANCE_G+cos*(-LUMINANCE_G)+sin*(LUMINANCE_G),LUMINANCE_B+cos*(1-LUMINANCE_B)+sin*(LUMINANCE_B),0,0,
					0,0,0,1,0];
		}
	}
}