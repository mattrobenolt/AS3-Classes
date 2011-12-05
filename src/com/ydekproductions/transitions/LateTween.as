/*
 * LateTween.as
 *
 * All code/functions/classes
 * written by: Matt Robenolt
 * Copyright © 2007 YDEK Productions LLC
 * http://www.ydekproductions.com
 * matt@ydekproductions.com
 * 
 */

package com.ydekproductions.transitions
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import fl.transitions.Tween;
	
	public class LateTween extends Tween
	{	
		private var _timer:Timer;
		
		public function LateTween($obj:*, $prop:String, $func:Function, $begin:Number, $finish:Number, $duration:Number, $delay:Number, $isSeconds:Boolean = true)
		{	
			super($obj, $prop, $func, $begin, $finish, $duration, $isSeconds);
			
			super.stop();
			
			if($delay <= 0) return;
			
			_timer = new Timer($delay*1000, 1);
			
			_timer.addEventListener(TimerEvent.TIMER, startTween);
			_timer.start();
		}
		
		private function startTween($event:TimerEvent)
		{
			_timer.removeEventListener(TimerEvent.TIMER, startTween);
			start();
		}
		
		public override function stop():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, startTween);
			
			super.stop();
		}
	}
}