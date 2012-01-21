
package org.coretween.easing
{
	public class Back {
		public static function easeIn (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			var s : Number = aa == 0 ? 1.70158 : aa;
			//if (s == undefined) s = 1.70158;
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}
		public static function easeOut (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			var s : Number = aa == 0 ? 1.70158 : aa;
			//if (s == undefined) s = 1.70158;
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number, aa:Number, bb:Number):Number {
			var s : Number = aa == 0 ? 1.70158 : aa;
			//if (s == undefined) s = 1.70158; 
			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}
	}
}
