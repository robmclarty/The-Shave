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
 * $Id: Version.as 52 2009-08-14 05:26:14Z lschreur $
 * $Date: 2009-08-14 15:26:14 +1000 (Fri, 14 Aug 2009) $
 */

/**
 * The Version class keeps track of the CoreTween version details. */
package org.coretween
{
	/**
	 * Represents the Coretween version.
	 */
	public class Version
	{
		public static var MAJOR : uint = 1;
		public static var MINOR : uint = 0;
		public static var REVISION : uint = 0;
		public static var RELEASE : String = "rc1";
		public static var COPYRIGHT : String = "Copyright (c) 2007 by Northern Binary. All rights (r) reserved 2007. Licenced under GNU Genral Public Licence (GPL).";
		
		/**
		 * Version class constructor. This constructor is <i>private</i> to prevent instantiation.		 */
		public function Version()
		{
		}
		
		/**
		 */
		public static function toString() : String
		{
			return( "v" + MAJOR + "." + MINOR + "." + REVISION + " " + RELEASE);
		}
	}
}

/*!
 * EOF;
 */
