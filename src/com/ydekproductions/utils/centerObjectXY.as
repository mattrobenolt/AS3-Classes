package com.ydekproductions.util
{
	import flash.display.DisplayObject;
	
	import com.ydekproductions.util.centerObjectX;
	import com.ydekproductions.util.centerObjectY;
	
	public function centerObjectXY($target:DisplayObject, $what:DisplayObject):void
	{
		centerObjectX($target, $what);
		centerObjectY($target, $what);
	}
}