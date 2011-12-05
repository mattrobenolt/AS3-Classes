/*
 * [Static] Cache.as
 *
 * All code/functions/classes
 * written by: Matt Robenolt
 * Copyright © 2007 YDEK Productions LLC
 * http://www.ydekproductions.com
 * matt@ydekproductions.com
 * 
 */
 
/**
 * A static class for caching Loader objects inside the application.
 */
 
package com.ydekproductions.utils
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ydekproductions.net.resolveAbsoluteURL;
	import com.ydekproductions.net.resolveThisURL;

	public class Cache
	{
		private static var _cache:Dictionary;
		
		/**
		 * Adds image to cache and returns Loader object.
		 * If image already exists, return cached Loader object.
		 * 
		 * @param   $request URLRequest object or String url to load.
		 * @return  Loader object.
		 */
		public static function load($request:*):Loader
		{
			if(!($request is String || $request is URLRequest)) throw new Error("Invalid request type.  Must be String or URLRequest.");
			
			if(_cache == null) _cache = new Dictionary();
			
			var r:URLRequest;
			
			if($request is String)     r = new URLRequest($request);
			if($request is URLRequest) r = $request;
			
			var url:String = resolveAbsoluteURL(r.url);
			
			if(_cache[url] != undefined) return _cache[url];
			
			_cache[url] = new Loader();
			_cache[url].load(r);
			
			return _cache[url];
		}
		
		/**
		 * Adds existing Loader object into the cache.
		 *
		 * @param	$loader The Loader object to cache.
		 * @return	Loader A reference to the Loader object just cached.
		 */
		public static function add($loader:Loader):Loader
		{
			if(_cache == null) _cache = new Dictionary();
			
			var url:String = $loader.contentLoaderInfo.url;
			
			if(_cache[url] == undefined) _cache[url] = $loader
			
			return _cache[url];
		}
			
		
		/**
		 * Remove item from cache.
		 * 
		 * @param	$request URLRequest or String representing cached item.
		 * @return	Boolean true if item existed in cache, false if not.
		 */
		public static function remove($request:*):Boolean
		{
			if(_cache == null || !isCached($request)) return false;
			
			var r:String;
			
			if($request is URLRequest)
			{
				r = $request.url;
			}
			
			if($request is String)
			{
				r = $request;
			}
			
			if(r == null) return false;
			
			if(_cache[r] == undefined)
			{
				r = resolveAbsoluteURL(r);
			}
			
			if(_cache[r] == undefined) return false;
			
			try
			{
				_cache[r].close();
			}
			catch($e:Error)
			{
				//throws error if the stream is not currently in progress
			}
			
			_cache[r].unload();
			delete _cache[r];
			
			return true;
		}
		
		/**
		 * Check if item exists in the cache.
		 * 
		 * @param	$request URLReqest or String representing cached item.
		 * @return	Boolean true if item existed in cache, false if not.
		 */
		public static function isCached($request:*):Boolean
		{
			if(_cache == null) return false;
			
			var r:String;
			
			if($request is URLRequest)
			{
				r = $request.url;
			}
			
			if($request is String)
			{
				r = $request;
			}
			
			if(r == null || (_cache[r] == undefined && _cache[resolveAbsoluteURL(r)] == undefined)) return false;

			return true;
		}
		
		/**
		 * Removes all items from cache.
		 *
		 * @return	void
		 */
		public static function empty():void
		{
			if(_cache == null) return;
			
			for(var r:String in _cache)
			{
				remove(r);
			}
		}
		
		public static function getObjects():Array
		{
			if(_cache == null) return null;
			
			var arr:Array = new Array();
			
			for(var r:String in _cache)
			{
				arr.push(r);
			}
			
			return arr;
		}
	}
}