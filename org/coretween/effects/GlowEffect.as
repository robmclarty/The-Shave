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
 * $Id: GlowEffect.as 20 2009-08-01 03:26:27Z lschreur $
 * $Date: 2009-08-01 13:26:27 +1000 (Sat, 01 Aug 2009) $
 */

package org.coretween.effects
{
	import flash.filters.GlowFilter;
	
	import org.coretween.Tween;
	import org.coretween.effects.Effect;
	import org.coretween.effects.EffectUtils;
	
	public class GlowEffect extends Effect
	{
		private var _r : Number = 0;
		private var _g : Number = 0;
		private var _b : Number = 0;
		private var _alpha : Number = 100;
		private var _xblur : Number = 0;
		private var _yblur : Number = 0;
		private var _color : Number = 0xffffff;
		private var _inner : Boolean = false;
		private var _knockout : Boolean = false;
		private var _quality : Number = Effect.QUALITY_MEDIUM;
		private var _strength : Number = 1.0;
		private var _filter : GlowFilter = null;
		private var _filterIndex : Number = 0;
		
		public function get r() : Number
		{
			return( EffectUtils.getRed( _color ) );
		}
		
		public function set r(r : Number) : void
		{
			_r = r;
		}
		
		public function get g() : Number
		{
			return( EffectUtils.getGreen( _color ) );
		}
		
		public function set g(g : Number) : void
		{
			_g = g;
		}
		
		public function get b() : Number
		{
			return( EffectUtils.getBlue( _color ) );
		}
		
		public function set b(b : Number) : void
		{
			_b = b;
		}
		
		public function get alpha() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].alpha * 100 );
		}
		
		public function set alpha(alpha : Number) : void
		{
			_alpha = alpha;
		}
		
		public function get xblur() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].blurX );
		}
		
		public function set xblur(xblur : Number) : void
		{
			_xblur = xblur;
		}
		
		public function get yblur() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].blurY );
		}
		
		public function set yblur(yblur : Number) : void
		{
			_yblur = yblur;
		}
		
		public function get strength() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].strength );
		}
		
		public function set strength(strength : Number) : void
		{
			_strength = strength;
		}
		
		public function get color() : Number
		{
			return( _effectTarget.filters[ _filterIndex ].color );
		}
		
		public function set color(color : Number) : void
		{
			_color = color;
		}
		
		override public function set target(target : Object) : void
		{
			super.target = this;
			
			_effectTarget = target;
		
			_filterIndex = 0;
			
			if( _effectTarget.filters.length > 0 )
			{
				for( var i : Number = 0; i < _effectTarget.filters.length; i++)
				{
					if( _effectTarget.filters[i] is GlowFilter )
					{
						_filterIndex = i;
						break;
					}
				}
			}
			else
			{
				// create a filter with the default settings.
				_effectTarget.filters = [ new GlowFilter(_color, _alpha / 100, _xblur, _yblur, _strength, _quality, _inner, _knockout) ];
			}
		}
		
		override public function set values(values : Object) : void
		{
			_inner = values.inner != undefined ? values.inner : _inner;
			_knockout = values.knockout != undefined ? values.knockout : _knockout;
			_quality = values.quality != undefined ? values.quality : _quality;
			
			values.color = values.color != undefined ? values.color : _color;
			values.xblur = values.xblur != undefined ? values.xblur : _xblur;
			values.yblur = values.yblur != undefined ? values.yblur : _yblur;
			values.alpha = values.alpha != undefined ? values.alpha : _alpha;
			values.strength = values.strength != undefined ? values.strength : _strength;
			
			super.values = { r:EffectUtils.getRed( values.color ), 
							 g:EffectUtils.getGreen( values.color ), 
							 b:EffectUtils.getBlue( values.color ), 
							 xblur:values.xblur, 
							 yblur:values.yblur, 
							 alpha:values.alpha, 
							 strength:values.strength };
		}
		
		public function GlowEffect(target : Object, values : Object, duration : Number, equations : Object, delay : Number = 0, loop : Boolean = false, type : uint = 0xffff)
		{
			super( target, values, duration, equations, delay, loop, type );
		}
	
		override public function start() : void
		{
			_color = this.color;
			_alpha = this.alpha;
			_xblur = this.xblur;
			_yblur = this.yblur;
			_strength = this.strength;
			
			_r = this.r;
			_g = this.g;
			_b = this.b;
	
			super.start();	
		}
		
		override public function update( currentTime : Number ) : void
		{
			var filters : Array;
			
			if( tweening && !paused )
			{		
				super.update( currentTime );
			
				filters = _effectTarget.filters;
				filters[ _filterIndex ] = new GlowFilter(EffectUtils.makeRGB( _r, _g, _b ), _alpha / 100, _xblur, _yblur, _strength, _quality, _inner, _knockout);
			
				_effectTarget.filters = filters;
			}
		}
	}
}

/*!
 * EOF
 */
