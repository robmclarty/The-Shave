
package org.coretween.easing
{
	public class Linear {
		public static function easeNone (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			return c*t/d + b;
		}
		public static function easeIn (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			return c*t/d + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			return c*t/d + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			return c*t/d + b;
		}
	}
}
