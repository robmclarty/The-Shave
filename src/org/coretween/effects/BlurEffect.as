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
 * $Id: BlurEffect.as 48 2009-08-10 06:49:36Z lschreur $
 * $Date: 2009-08-10 16:49:36 +1000 (Mon, 10 Aug 2009) $
 */

package org.coretween.effects
{
	import flash.filters.BlurFilter;
	
	import org.coretween.Tween;
	import org.coretween.effects.Effect;
	
	public class BlurEffect extends Effect
	{
		private var _xblur : Number = 0;
		private var _yblur : Number = 0;
		private var _quality : Number = Effect.QUALITY_MEDIUM;
		private var _filter : BlurFilter = null;
		private var _filterIndex : Number = 0;
		
		public function get xblur() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].blurX );
		}
		
		public function set xblur( xblur : Number ) : void
		{
			_xblur = xblur;
		}
		
		public function get yblur() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].blurY );
		}
		
		public function set yblur( yblur : Number ) : void
		{
			_yblur = yblur;
		}
		
		public function get quality() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].quality );
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
					if( _effectTarget.filters[i] is BlurFilter )
					{
						_filterIndex = i;
						break;
					}
				}
			}
			else
			{
				_effectTarget.filters = [ new BlurFilter(0, 0, _quality) ];
			}
		}
		
		override public function set values(values : Object) : void
		{
			_quality = values.quality != undefined ? values.quality : _quality;
			
			values.xblur = values.xblur != undefined ? values.xblur : _xblur;
			values.yblur = values.yblur != undefined ? values.yblur : _yblur;
			
			super.values = { xblur:values.xblur, yblur:values.yblur };
		}
		
		public function BlurEffect(target : Object, values : Object, duration : Number, equations : Object, delay : Number = 0, loop : Boolean = false, type : uint = 0xffff)
		{
			super( target, values, duration, equations, delay, loop, type );
		}
		
		override public function start() : void
		{
			_xblur = this.xblur;
			_yblur = this.yblur;
	
			super.start();
		}
		
		override public function update( currentTime : Number ) : void
		{
			super.update( currentTime );
			
			if( tweening && !paused )
			{		
				var filters : Array;
				
				filters = _effectTarget.filters;
				filters[ _filterIndex ] = new BlurFilter(_xblur, _yblur, _quality);
				
				// Filters only seem to take effect by re-applying the filters array.
				_effectTarget.filters = filters;
			}
		}
	}
}

/*!
 * EOF
 */
