/*
 * Cookie.as
 *
 * All code/functions/classes
 * written by: Matt Robenolt
 * Copyright © 2007 YDEK Productions LLC
 * http://www.ydekproductions.com
 * matt@ydekproductions.com
 * 
 */
 
/**
 * A more user friendly version of Flash's SharedObject
 * used for setting/getting cookies in Flash.
 */

package com.ydekproductions.net
{
	import flash.net.SharedObject;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	dynamic public class Cookie extends Proxy
	{
		private var _so:SharedObject;
		private var _properties:Object;  //temporary Object
		
		/**
		 * Constructor
		 * 
		 * @param   $name The name of the cookie.
		 */
		function Cookie($name:String)
		{
			_so = SharedObject.getLocal($name);
			_properties = _so.data;
		}
		
		/**
		 * Clears the cookie
		 *
		 * @return  void
		 */
		public function clear():void
		{
			_so.clear();
			_properties = new Object();
		}
		
		public function get properties():Object
		{
			return _properties;
		}
		
		/**
		 * Sets a variable in the cookie.
		 * 
		 * @param   $name  Variable name
		 * @param   $value Value of the variable.
		 * @return  *
		 */
        override flash_proxy function getProperty($name:*):*
		{
			if(_so == null || !($name in _so.data)) return ($name in _properties) ? _properties[$name] : undefined;
			
			return _so.data[$name];
        }
		
        /**
		 * Sets a variable in the cookie.
		 * 
		 * @param   $name  Variable name
		 * @param   $value Value of the variable.
		 * @return  void
		 */
        override flash_proxy function setProperty($name:*, $value:*):void
		{
            _properties[$name] = $value;
			
			if(_so != null)
			{
				_so.data[$name] = $value;
				_so.flush();
			}
        }
		
		override flash_proxy function deleteProperty($name:*):Boolean
		{
			delete _properties[$name];
			
			if(_so != null && $name in _so.data) delete _so.data[$name];
			
			return true;
		}
	}
}
