package com.ydekproductions.util
{
	import flash.display.DisplayObject;
	
	public function centerObjectX($target:DisplayObject, $what:DisplayObject):void
	{
		$what.x = Math.round($target.width/2 - $what.width/2);
	}
}