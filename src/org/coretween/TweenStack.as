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
 * $Id: TweenStack.as 49 2009-08-10 10:29:46Z lschreur $
 * $Date: 2009-08-10 20:29:46 +1000 (Mon, 10 Aug 2009) $
 */

package org.coretween
{
	import flash.events.EventDispatcher;
	
	import org.coretween.Tween;
	import org.coretween.Tweenable;
	import org.coretween.TweenEvent;
	
	/**
	 * The TweenStack class provides linair playback of executive Tween objects. 
	 * Use The TweenStack class to create an animation of tweens.
	 */
	public class TweenStack extends EventDispatcher implements Tweenable
	{
		/**
		 * @private
		 */
		private var _loop : Boolean = false;
		 
		/**
		 * _tweens An Array that holds reference to all tween objects that make up 
		 * the TweenStack.
		 * 
		 * @private
		 */
		private var _tweens : /*Vector.<Tweenable>*/ Array = null;
		 
		/**
		 * _tweenIndex A Number that indicates the current tween object thats being 
		 * processed.
		 * 
		 * @private
		 */
		private var _tweenIndex : int = 0;
		 
		/**
		 * _oldHandlers A Array that that keeps references to all tween objects old 
		 * handlers.
		 * 
		 * @private
		 */
		private var _oldHandlers : Array = null;
		 
		/**
		 * @private
		 */
		private var _paused : Boolean = false;
		
		/**
		 * Indicates whether the sequence is looping or not. The default for this 
		 * value is false.
		 */
		public function get loop() : Boolean
		{
			return( this._loop );
		}
		
		public function set loop(loop : Boolean) : void
		{
			this._loop = loop;
		}
		
		/**
		 * By getting or setting this property the paused state of the animation can 
		 * be controlled.
		 */
		public function get paused() : Boolean
		{
			return( this._paused );
		}
		
		public function set paused(paused : Boolean) : void
		{
			this._paused = paused;
		}
		
		/**
		 * This is the TweenStack class constructor. Use the TweenStack constructor 
		 * the create a new TweenStack object.
		 */
		public function TweenStack( loop : Boolean = false )
		{
			this.loop = loop;
		}
		
		/**
		 * This method pushes a Tweenable object onto the TweenStack. Tweenable objects 
		 * are executed in the order they where pushed onto the TweenStack.
		 */
		public function push(tween : Tweenable) : void
		{
			// initialize arrays?
			if( !_tweens )
			{
				this._tweens = new /*Vector.<Tweenable>*/ Array();
			}
			
			Tween( tween ).addEventListener(TweenEvent.COMPLETE, onTweenComplete);
			
			// add the tween to list.
			this._tweens.push( tween );
		}
		
		/**
		 * Starts executing the TweenStack animation.
		 */
		public function start() : void
		{
			this._tweenIndex = 0;
			
			dispatchEvent( new TweenEvent( TweenEvent.START, this ) );
			
			this._tweens[ this._tweenIndex ].start();
		}
		
		/**
		 * Stops executing the TweenStack animation.
		 */
		public function stop() : void
		{
			dispatchEvent( new TweenEvent( TweenEvent.STOP, this ) );
			
			this._tweens[ this._tweenIndex ].stop();
		}
		
		/**
		 * Indicates wheter to pause the animation or not.
		 */
		public function pause( ... args ) : void
		{
			this._paused = ( args[0] == undefined ) ? !this._paused : args[0];
			
			this._tweens[ this._tweenIndex ].pause( this._paused );
			
			dispatchEvent( new TweenEvent( TweenEvent.PAUSE, this ) );
		}
		
		/**
		 * Resumes a paused TweenStack animation. Has no effect on a TweenStack 
		 * animation that is not paused.
		 */
		public function resume() : void
		{
			this._paused = false;
			
			this._tweens[ this._tweenIndex ].resume();
			
			dispatchEvent( new TweenEvent( TweenEvent.RESUME, this ) );
		}
		
		/**
		 * Rewinds the TweenStack animation.
		 */
		public function rewind() : void
		{
			stop();
			start();
			
			dispatchEvent( new TweenEvent( TweenEvent.REWIND, this ) );
		}
		
		public function update( currentTime : Number ) : void
		{
		}
		
		private function onTweenComplete(event : TweenEvent) : void
		{
			this._tweenIndex++;
			
			if( this._tweenIndex > this._tweens.length - 1)
			{
				this._tweenIndex = 0;
				
				dispatchEvent( new TweenEvent( TweenEvent.COMPLETE, this ) );

				if( !this.loop )
				{
					return;
				}
			}
			
			this._tweens[ this._tweenIndex ].start();
		}
	}
}

/*!
 * EOF;
 */
