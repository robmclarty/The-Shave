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
 * $Id: TweenEvent.as 52 2009-08-14 05:26:14Z lschreur $
 * $Date: 2009-08-14 15:26:14 +1000 (Fri, 14 Aug 2009) $
 */

package org.coretween
{
	import flash.events.Event;
	import org.coretween.Tweenable;
	
	/**
	 * Tween events are dispatched by the Tween and other classes.
	 */
	public class TweenEvent extends Event
	{
		public static var START : String = "onStart";
		public static var STOP : String = "onStop";
		public static var PAUSE : String = "onPause";
		public static var RESUME : String = "onResume";
		public static var REWIND : String = "onRewind";
		public static var UPDATE_ENTER : String = "onUpdateEnter";
		public static var UPDATE_LEAVE : String = "onUpdateLeave";
		public static var COMPLETE : String = "onComplete";
		
		private var _source : Tweenable = null;
		
		public function get source() : Tweenable
		{
			return( this._source );
		}
		
		public function set source(source : Tweenable) : void
		{
			this._source = source;
		}
		
		public function TweenEvent(type : String, source : Tweenable, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.source = source; 
		}
	}	
}

/*!
 * EOF
 */
