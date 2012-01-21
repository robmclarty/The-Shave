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
 * $Id: Effect.as 20 2009-08-01 03:26:27Z lschreur $
 * $Date: 2009-08-01 13:26:27 +1000 (Sat, 01 Aug 2009) $
 */

package org.coretween.effects
{
	import org.coretween.Tween;
	
	public class Effect extends Tween
	{
		public static var QUALITY_LOW : uint = 1;
		public static var QUALITY_MEDIUM : uint = 2;
		public static var QUALITY_HIGH : uint = 3;
		
		protected var _effectTarget : Object = null;
		
		override public function get target() : Object
		{
			return( _effectTarget );
		}
		
		public function Effect(target : Object, values : Object, duration : Number, equations : Object, delay : Number = 0, loop : Boolean = false, type : uint = 0xffff)
		{
			super(target, values, duration, equations, delay, loop, type);
		}
	}
}

/*!
 * EOF
 */
