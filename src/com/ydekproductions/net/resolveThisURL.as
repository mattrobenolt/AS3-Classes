/*
 * [function] resolveThisURL.as
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
	import flash.display.Loader;
	
	/**
	 * Retrieves the url that the current .swf is at.
	 *
	 * @returns	String Fully qualified URL.
	 */
	public function resolveThisURL():String
	{
		return new Loader().contentLoaderInfo.loaderURL;
	}
}