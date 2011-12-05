/*
 * [function] resolveAbsoluteURL.as
 *
 * All code/functions/classes
 * written by: Matt Robenolt
 * Copyright © 2007 YDEK Productions LLC
 * http://www.ydekproductions.com
 * matt@ydekproductions.com
 * 
 */

package com.ydekproductions.net
{
	import flash.display.DisplayObject;
	
	import com.ydekproductions.net.resolveThisURL;
	
	/**
	 * Converts a relative URL to a fully qualified
	 * URL based on the source URL.
	 *
 	 * @param	$relative String Relative URL that you would like to resolve to absolute.
	 * @param	$source(optional) String or DisplayObject, Pass a string URL to a <b>file</b> on the server.
	 *			Pass a DisplayObject (usually root) to use the url of that object.
	 * @returns	String Fully qualified URL.
	 */
	public function resolveAbsoluteURL($relative:String, $source:* = null):String
	{
		if($source == null) $source = resolveThisURL();
		
		if(!($source is String || $source is DisplayObject)) throw new Error("Invalid source type.  Must be String or DisplayObject.");
		
		var url:String;
		
		if($source is Loader)             url = Loader($source).contentLoaderInfo.loaderURL;
		else if($source is DisplayObject) url = DisplayObject($source).loaderInfo.url;
		if($source is String)             url = $source;
		
		var reg:RegExp = new RegExp("^(https?|ftp|file)://(/?.*?)/(.*)$", "i");
		
		if(!reg.test($source)) throw new Error("Source url is not an absolute reference!");
		
		var parts:Array = reg.exec(url);
		var base:String = parts[1]+"://"+parts[2]+"/";
		
		url = url.replace(base, "");
		
		var folders:Array = url.split("/");
		folders.pop();
		
		if($relative.substr(0, 2) == "./")  return base+((folders.length==0)?"":(folders.join("/"))+"/")+$relative.substr(2);
		if($relative.substr(0, 1) == "/")   return base+$relative.substr(1);
		if($relative.substr(0, 3) == "../")
		{
			reg = new RegExp("^../");
			var ups:int = 0;
			while(reg.test($relative))
			{
				ups++;
			
				$relative = $relative.replace(reg, "");
			}
		
			if(ups > folders.length) ups = folders.length;
			
			folders = folders.slice(0, folders.length-ups);
			
			return base+((folders.length==0)?"":(folders.join("/"))+"/")+$relative;
		}
		else return base+((folders.length==0)?"":(folders.join("/"))+"/")+$relative;
	}
}