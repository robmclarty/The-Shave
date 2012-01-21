/*!
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA 
 */

/*!
 * $Id: ColorTransformEffect.as 20 2009-08-01 03:26:27Z lschreur $
 * $Date: 2009-08-01 13:26:27 +1000 (Sat, 01 Aug 2009) $
 */

package org.coretween.effects
{
	import flash.geom.ColorTransform;
	
	import org.coretween.effects.Effect;
	import org.coretween.effects.EffectUtils;
	
	public class ColorTransformEffect extends Effect
	{
		private var _r : Number = 0;
		private var _g : Number = 0;
		private var _b : Number = 0;
		private var _a : Number = 1.0;
		
		public function get r() : Number
		{
			return( _effectTarget.transform.colorTransform.redOffset );
		}
		
		public function set r(r : Number) : void
		{
			_r = r;
		}
		
		public function get g() : Number
		{
			return( _effectTarget.transform.colorTransform.greenOffset );
		}
		
		public function set g(g : Number) : void
		{
			_g = g;
		}
		
		public function get b() : Number
		{
			return( _effectTarget.transform.colorTransform.blueOffset );
		}
		
		public function set b(b : Number) : void
		{
			_b = b;
		}
		
		public function get a() : Number
		{
			return( _effectTarget.transform.colorTransform.alphaOffset );
		}
		
		public function set a(a : Number) : void
		{
			_a = a;
		}
		
		override public function set target(target : Object) : void
		{
			super.target = target;
			
			_effectTarget = target;
		}
		
		override public function get values() : Object
		{
			return( { color:EffectUtils.makeARGB(_a, _r, _g, _b) } );
		}
		
		override public function set values(values : Object) : void
		{
			values.color = values.color != undefined ? values.color : 0xffffffff;
			
			super.values = { r:EffectUtils.getRed( values.color ), 
							 g:EffectUtils.getGreen( values.color ), 
							 b:EffectUtils.getBlue( values.color ), 
							 a:EffectUtils.getAlpha( values.color ) };
		}
		
		public function ColorTransformEffect(target : Object, values : Object, duration : Number, equations : Object, delay : Number = 0, loop : Boolean = false, type : uint = 0xffff)
		{
			super( target, values, duration, equations, delay, loop, type );
		}
		
		override public function start() : void
		{
			_r = this.r;
			_g = this.g;
			_b = this.b;
			_a = this.a;
			
			super.start();		
		}
	
		override public function update( currentTime : Number ) : void
		{
			super.update( currentTime );
			
			if( tweening && !paused )
			{
				trace(_r+","+_g+","+_b+","+_a);
				_effectTarget.transform.colorTransform = new ColorTransform(0, 0, 0, 1, _r, _g, _b, _a);
			}
		}
	}
}

/*!
 * EOF
 */
