/*
 * formatTime.as
 *
 * All code/functions/classes
 * written by: Matt Robenolt
 * Copyright © 2007 YDEK Productions LLC
 * http://www.ydekproductions.com
 * matt@ydekproductions.com
 * 
 */

package com.ydekproductions.time
{
	import com.ydekproductions.time.TimeFormat;
	
	public function formatTime($seconds:uint, $format:String = null):String
	{
		//fucking retarded hack because constants aren't allowed in the initializer!
		if($format == null) $format = TimeFormat.MINUTES_SECONDS;
		//end fucking retarded hack
		
		
		if($format == TimeFormat.MINUTES_SECONDS)
			return formatTimeMinutesSeconds($seconds);
			
		if($format == TimeFormat.HOURS_MINUTES_SECONDS)
			return formatTimeHoursMinutesSeconds($seconds);
			
		return String($seconds);
	}
}

////////////////////////////////////
//Helper functions//////////////////
////////////////////////////////////

function formatTimeMinutesSeconds($seconds:uint):String
{
	var minutes:uint = Math.floor($seconds/60);
	var seconds:uint = $seconds % 60;
	
	
	return ((minutes<10)? "0":"") + String(minutes) + ":" + ((seconds<10)? "0":"") + String(seconds);
}
	
function formatTimeHoursMinutesSeconds($seconds:uint):String
{
	var hours:uint = Math.floor($seconds/3600);
	var minutes:uint = Math.floor($seconds/60) - hours*60;
	var seconds:uint = $seconds % 60;
	
	return ((hours<10)? "0":"") + String(hours) + ":" +((minutes<10)? "0":"") + String(minutes) + ":" + ((seconds<10)? "0":"") + String(seconds);
}