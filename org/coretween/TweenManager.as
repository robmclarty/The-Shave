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
 * $Id: TweenManager.as 48 2009-08-10 06:49:36Z lschreur $
 * $Date: 2009-08-10 16:49:36 +1000 (Mon, 10 Aug 2009) $
 */

package org.coretween
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.display.Shape;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	
	import org.coretween.Tween;
	import org.coretween.Tweenable;
	
	/**
	 * The TweenManager class is responsible for the management of all Tween 
	 * objects that implement the Tweenable interface, this includes both Tween 
	 * and Effect objects. The TweenManager is implemented as a singleton and 
	 * no instances of the TweenManager should be created.
	 */
	public class TweenManager
	{
		/**
		 * @private
		 */
		protected static const MAX_FPS : int = 60;
		
		/**
		 * @private
		 */
		protected static var _mc : Shape = null;
		
		/**
		 * @private
		 */
		protected static var _fps : uint = MAX_FPS;
		
		/**
		 * @private
		 */
		protected static var _timer : uint = 0;
		
		/**
		 * @private
		 */
		protected static var _timeTweens : /*Vector.<Tweenable>*/ Array = null;
		
		/**
		 * @private
		 */
		protected static var _frameTweens : /*Vector.<Tweenable>*/ Array = null;
		
		/**
		 * @private
		 */
		protected static var _paused : Boolean = false;
		
		/**
		 * @private
		 */
		protected static var _renderType : uint = Tween.FRAME;
		
		/**
		 * @private
		 */
		protected static var _prevfps : Number = _fps;
		
		/**
		 * Sets or returns the current time based FPS. Use this property to set 
		 * CoreTween's internal time based rendering fps. The higher this value 
		 * the more smooth your animations will be. Keep in mind however that the 
		 * fps set through this property is no guaranteed interval. So for instance, 
		 * when setting this value to 60 then the Flash Player will try to keep this 
		 * fps but it is in no way guaranteed. When setting this value its range 
		 * can be set from 0 to 60. the default value for this property is 60. 
		 * Setting this property to zero will disable CoreTweens time based renderer.
		 */
		public static function get fps() : uint
		{
			return( TweenManager._fps );
		}
		
		public static function set fps(fps : uint) : void
		{
			TweenManager._fps = ( fps > MAX_FPS ? MAX_FPS : ( fps < 1 ? 0 : fps ) );
			
			if( TweenManager._timer )
			{
				clearInterval( TweenManager._timer );
			}
			
			if( TweenManager.fps > 0 )
			{
				TweenManager._timer = setInterval( onUpdateTime, 1000 / TweenManager.fps, new TimerEvent( TimerEvent.TIMER ) );
			}
		}
		
		/**
		 * Returns the paused state. When pausing the TweenManager all tweens 
		 * that are currently under the tween managers control will be paused.
		 *
		 * @see TweenManager#pause()
		 */
		public static function get paused() : Boolean
		{
			return( TweenManager._paused );
		}
		
		/**
		 * Use this property to change the default render type. By default the type of
		 * rendering is set to Tween.FRAME and all Tween objects instantiated will have
		 * their rendering type set to Tween.FRAME. Setting this property allows you
		 * to change the default render type to Tween.TIME.
		 * 
		 * @see Tween#type
		 */
		public static function get renderType() : uint
		{
			return( TweenManager._renderType );
		}
		
		public static function set renderType(type : uint) : void
		{
			TweenManager._renderType = type;
		}
		
		/**
		 * This is the TweenManager class constructor. No instances of the TweenManager 
		 * have to be created in order to use the TweenManager.
		 */
		public function TweenManager()
		{
			// OMG, as3 doesn't support private constructors. WTF???
		}
		
		/**
		 * This method initialises the TweenManager. It should only be called once 
		 * during an applications life time. If the method is called a second time 
		 * the TweenManager will re-initialize.
		 */
		private static function initialize() : void
		{
			if( TweenManager._mc == null )
			{
				// Create a movieclip that handles the update of all frame based timed
				// tweens.
				TweenManager._mc = new Shape();
				TweenManager._mc.addEventListener( Event.ENTER_FRAME, onUpdateFrame );
				TweenManager._mc.visible = false;
				
				// These array's stores all references to the Tweenable objects under 
				// control of the TweenManager.
				TweenManager._timeTweens = new /*Vector.<Tweenable>()*/ Array();
				TweenManager._frameTweens = new /*Vector.<Tweenable>()*/ Array();
				
				// By setting the FPS we force a new timer to be created that handles 
				// all time based tweens.
				fps = TweenManager._prevfps;
			}
		}
		
		/**
		 * Releases the tween manager. Use this method to shutdown the tween manager. 
		 * If after releasing the tween manager its necessary to start the teen manager 
		 * again, simply tell a Tween instance to start and the tween manager will be 
		 * re-initialised.
		 */
		public static function release() : void
		{
			var tween : Tween;
			
			for each( tween in TweenManager._timeTweens )
			{
				tween.stop();
			}

			for each( tween in TweenManager._frameTweens )
			{
				tween.stop();
			}

			TweenManager._timeTweens = null;
			TweenManager._frameTweens = null;
			
			if( TweenManager._mc )
			{
				TweenManager._mc.removeEventListener( Event.ENTER_FRAME, onUpdateFrame );
				TweenManager._mc = null;
			}
			
			TweenManager._prevfps = fps;
			fps = 0;
		}
	
		/**
		 * Use this method to pause or resume all tweens that are currently under the 
		 * control of the tween manager. Calling this method when all tweens are paused 
		 * will resume all tweens, reversing the paused state. However, calling this 
		 * method when only some tweens are paused will not cause the paused tweens to 
		 * resume, they will stay paused. Resuming the paused state of the tween manager 
		 * will cause all tweens to be un-paused.
		 *
		 * @see TweenManager#paused
		 * @see TweenManager#resume()
		 */
		public static function pause( ... args ) : void
		{
			var tween : Tween;
			
			TweenManager._paused = (args[0] == undefined) ? !TweenManager._paused : args[0];
			
			for each( tween in TweenManager._timeTweens )
			{
				tween.pause( TweenManager._paused );
			}
			
			for each( tween in TweenManager._frameTweens )
			{
				tween.pause( TweenManager._paused );
			}
		}
		
		/**
		 * Use this method to resume all tweens that where previously paused with the 
		 * TweenManager pause method. Calling this method will resume all tweens, also 
		 * tweens that where previously not set to a paused state by the tween manager.
		 *
		 * @see TweenManager#paused
		 * @see TweenManager#pause()
		 */
		public static function resume() : void
		{
			var tween : Tween;
			
			for each( tween in TweenManager._timeTweens )
			{
				tween.resume();
			}
			
			for each( tween in TweenManager._frameTweens )
			{
				tween.resume();
			}
			
			pause( false );
		}
		
		/**
		 * Use this method to rewind all tweens that are currently under control of 
		 * the tween manager.
		 */
		public static function rewind() : void
		{
			var tween : Tween;
			
			for each( tween in TweenManager._timeTweens )
			{
				tween.rewind();
			}
			
			for each( tween in TweenManager._frameTweens )
			{
				tween.rewind();
			}
		}
		
		/**
		 * Use this method to register an object with the tween manager that implements 
		 * the Tweenable interface. When an object is registered with it can be controlled 
		 * and updated by the tween manager. Normally when an opject is registered it is 
		 * automatically unregistered when the object's stop method is called or when the 
		 * tween of the object is completed.
		 *
		 * @see TweenManager#unregister()
		 */
		public static function register(tween : Tweenable) : void
		{
			var t : Tween;
			var a : Array;
			
			initialize();
			
			t = Tween( tween );

			if( t.type == Tween.TIME )
			{
				a = TweenManager._timeTweens;
			}
			else
			if( t.type == Tween.FRAME )
			{
				a = TweenManager._frameTweens;
			}

			a.push( tween );
		}
		
		/**
		 * Use this method to unregister an object with the tween manager that implements 
		 * the Tweenable interface. Normally it is not necessary to call this method manually. 
		 * In normal circumstances it is called when a tweenable object is stopped or completed.
		 *
		 * @see TweenManager#register
		 */
		public static function unregister(tween : Tweenable) : void
		{
			var i : int;
			var a : Array;
			var t : Tween;
			
			t = Tween( tween );
			
			if( t.type == Tween.TIME )
			{			
				a = TweenManager._timeTweens;
			}
			else
			if( t.type == Tween.FRAME )
			{
				a = TweenManager._frameTweens;
			}
			
			for( i = 0; i < a.length; i++ )
			{
				if( a[ i ] == t )
				{
					a.splice( i, 1 );
					
					break;
				}
			}
		}

		/**
		 * The onUpdateFrame is responsible for updating all frame based Tweenable objects.
		 */
		private static function onUpdateFrame(event : Event) : void
		{
			var time : int = getTimer();
			var tween : Tween;
			
			for each( tween in TweenManager._frameTweens )
			{
				if( tween != null )
				{
					tween.update( time );
				}
			}
		}
		
		/**
		 * The onUpdateTime is responsible for updating all time based Tweenable objects.
		 */
		private static function onUpdateTime(event : TimerEvent) : void
		{
			var time : int = getTimer();
			var tween : Tween;
			
			for each( tween in TweenManager._timeTweens )
			{
				if( tween != null )
				{
					tween.update( time );
				}
			}

			if( TweenManager._timeTweens.length > 0 )
			{
				event.updateAfterEvent();
			}			
		}
	}
}

/*!
 * EOF
 */
