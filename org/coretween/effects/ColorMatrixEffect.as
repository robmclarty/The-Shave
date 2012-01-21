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
 * $Id: ColorMatrixEffect.as 49 2009-08-10 10:29:46Z lschreur $
 * $Date: 2009-08-10 20:29:46 +1000 (Mon, 10 Aug 2009) $
 */
 
package org.coretween.effects
{
	import flash.filters.ColorMatrixFilter;

	import org.coretween.effects.Effect;
	//import org.coretween.effects.EffectUtils;
	
	public class ColorMatrixEffect extends Effect
	{
		/*!
			matrix:
			
			  r g b a o
			r 1 0 0 0 0  rr rg rb ra ro
			g 0 1 0 0 0  gr gg gb ga go
			b 0 0 1 0 0  br bg bb ba bo
			a 0 0 0 1 0  ar ag ab aa ao
			
			(o = offset)	
		 */
		
		public var rr : Number = 1;
		public var rg : Number = 0;
		public var rb : Number = 0;
		public var ra : Number = 0;
		public var ro : Number = 0;
		
		public var gr : Number = 0;
		public var gg : Number = 1;
		public var gb : Number = 0;
		public var ga : Number = 0;
		public var go : Number = 0;
		
		public var br : Number = 0;
		public var bg : Number = 0;
		public var bb : Number = 1;
		public var ba : Number = 0;
		public var bo : Number = 0;	
		
		public var ar : Number = 0;
		public var ag : Number = 0;
		public var ab : Number = 0;
		public var aa : Number = 1;
		public var ao : Number = 0;
		
		private var _filter : ColorMatrixFilter = null;
		private var _filterIndex : Number = 0;
		
		override public function set values(values : Object) : void
		{
			values.rr = values.rr != undefined ? values.rr : rr;
			values.rg = values.rg != undefined ? values.rg : rg;
			values.rb = values.rb != undefined ? values.rb : rb;
			values.ra = values.ra != undefined ? values.ra : ra;
			values.ro = values.ro != undefined ? values.ro : ro;
	
			values.gr = values.gr != undefined ? values.gr : gr;
			values.gg = values.gg != undefined ? values.gg : gg;
			values.gb = values.gb != undefined ? values.gb : gb;
			values.ga = values.ga != undefined ? values.ga : ga;
			values.go = values.go != undefined ? values.go : go;
	
			values.br = values.br != undefined ? values.br : br;
			values.bg = values.bg != undefined ? values.bg : bg;
			values.bb = values.bb != undefined ? values.bb : bb;
			values.ba = values.ba != undefined ? values.ba : ba;
			values.bo = values.bo != undefined ? values.bo : bo;
	
			values.ar = values.ar != undefined ? values.ar : ar;
			values.ag = values.ag != undefined ? values.ag : ag;
			values.ab = values.ab != undefined ? values.ab : ab;
			values.aa = values.aa != undefined ? values.aa : aa;
			values.ao = values.ao != undefined ? values.ao : ao;
	
			super.values = values;
		}
		
		override public function set target(target : Object) : void
		{
			super.target = this;
			
			_effectTarget = target;
			
			_filterIndex = 0;
			
			// Check if there is already a BlurFilter attached to the effect 
			// target. If this is the case then we use the first BlurFilter
			// found as the starting point filter. Otherwise, we create a new 
			// BlurFilter to serve as a starting point.
			if( _effectTarget.filters.length > 0 )
			{
				for(var i : Number = 0; i < _effectTarget.filters.length; i++)
				{
					if( _effectTarget.filters[i] is ColorMatrixFilter )
					{
						_filterIndex = i;
						break;
					}
				}
			}
			else
			{
				_effectTarget.filters = [ new ColorMatrixFilter( [ rr, rg, rb, ra, ro,  
																	gr, gg, gb, ga, go,  
																	br, bg, bb, ba, bo,  
																	ar, ag, ab, aa, ao ] ) ];
			}
		}		
		
		public function ColorMatrixEffect(target : Object, values : Object, duration : Number, equations : Object, delay : Number = 0, loop : Boolean = false, type : uint = 0xffff)
		{
			super( target, values, duration, equations, delay, loop, type );
		}
		
		override public function start() : void
		{
			var matrix : Array;
			
			matrix = _effectTarget.filters[ _filterIndex ].matrix;
	
			rr = matrix[0 * 5 + 0];
			rg = matrix[0 * 5 + 1];
			rb = matrix[0 * 5 + 2];
			ra = matrix[0 * 5 + 3];
			ro = matrix[0 * 5 + 4];
		
			gr = matrix[1 * 5 + 0];
			gg = matrix[1 * 5 + 1];
			gb = matrix[1 * 5 + 2];
			ga = matrix[1 * 5 + 3];
			go = matrix[1 * 5 + 4];
		
			br = matrix[2 * 5 + 0];
			bg = matrix[2 * 5 + 1];
			bb = matrix[2 * 5 + 2];
			ba = matrix[2 * 5 + 3];
			bo = matrix[2 * 5 + 4];	
		
			ar = matrix[3 * 5 + 0];
			ag = matrix[3 * 5 + 1];
			ab = matrix[3 * 5 + 2];
			aa = matrix[3 * 5 + 3];
			ao = matrix[3 * 5 + 4];
	
			super.start();
		}
		
		override public function update( currentTime : Number ) : void
		{
			super.update( currentTime );
			
			if( tweening && !paused )
			{		
				var filters : Array;
				
				filters = _effectTarget.filters;
				filters[ _filterIndex ] = new ColorMatrixFilter( [ rr, rg, rb, ra, ro,  
																					 gr, gg, gb, ga, go,  
																					 br, bg, bb, ba, bo,  
																					 ar, ag, ab, aa, ao ] );
				
				// Filters only seem to take effect by re-applying the filters array.
				_effectTarget.filters = filters;
			}
		}
	}
}

/*!
 * EOF
 */
