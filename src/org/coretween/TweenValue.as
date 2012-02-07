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
 * $Id: TweenValue.as 52 2009-08-14 05:26:14Z lschreur $
 * $Date: 2009-08-14 15:26:14 +1000 (Fri, 14 Aug 2009) $
 */

package org.coretween
{
	import org.coretween.TweenEquation;
	
	/**
	 * A TweenValue is used to store the properties that are specific to a tween.
	 */
	public class TweenValue
	{
		public var prop : String = null;
		public var target : Number = 0;
		public var start : Number = 0;
		public var change : Number = 0;
		public var equation : TweenEquation = null;
	
		public function TweenValue(prop : String, target : Number, equation : TweenEquation = null)
		{
			this.prop = prop;
			this.target = target;
			this.equation = equation;
		}
	}
}

/*!
 * EOF
 */
