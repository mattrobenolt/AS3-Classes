package com.ydekproductions.util
{
	import flash.display.DisplayObject;
	
	public function centerObjectY($target:DisplayObject, $what:DisplayObject):void
	{
		$what.y = Math.round($target.height/2 - $what.height/2);
	}
}