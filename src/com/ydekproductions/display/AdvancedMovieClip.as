package com.ydekproductions.display
{
	import flash.display.MovieClip;
	
	import flash.geom.Point;
	
	public class AdvancedMovieClip extends MovieClip
	{
		private var _width:		Number;
		private var _height:	Number;
		private var _scaleX:	Number;
		private var _scaleY:	Number;
		
		public var transformationPoint:Point;
		
		public function AdvancedMovieClip()
		{
			_width = super.width;
			_height = super.height;
			_scaleX = 1.0;
			_scaleY = 1.0;
			
			transformationPoint = new Point();
		}
		
		////////////////////////////////////////////////////
		//  SIZING OVERRIDE CODE
		////////////////////////////////////////////////////
		
		public override function get width():Number { return _width }
		public override function get height():Number { return _height }
		public override function get scaleX():Number { return _scaleX }
		public override function get scaleY():Number { return _scaleY }
		
		public override function set width(w:Number):void
		{
			var r:Number = rotation;
			rotation = 0;
			
			_width = w;
			updateWidth();
			
			rotation = r;
		}
		
		public override function set height(h:Number):void
		{
			var r:Number = rotation;
			rotation = 0;
			
			_height = h;
			updateHeight();
			
			rotation = r;
		}
		
		public override function set scaleX(s:Number):void
		{
			var r:Number = rotation;
			rotation = 0;
			
			_scaleX = s;
			updateWidth();
			
			rotation = r;
		}
		
		public override function set scaleY(s:Number):void
		{
			var r:Number = rotation;
			rotation = 0;
			
			_scaleY = s;
			updateHeight();
			
			rotation = r;
		}
		
		private function updateWidth():void
		{
			super.width = _width * _scaleX
		}
		
		private function updateHeight():void
		{
			super.height = _height * _scaleY
		}
		////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////
		//  TRANSFORMATION CODE
		////////////////////////////////////////////////////
			
		public function get relativeX():Number { return parent.globalToLocal(localToGlobal(transformationPoint)).x }
		public function get relativeY():Number { return parent.globalToLocal(localToGlobal(transformationPoint)).y }
		public function get relativeWidth():Number { return width }
		public function get relativeHeight():Number { return height }
		public function get relativeScaleX():Number { return scaleX }
		public function get relativeScaleY():Number { return scaleY }
		public function get relativeRotation():Number { return rotation }
		
		public function set relativeX(value:Number):void { x += value - parent.globalToLocal(localToGlobal(transformationPoint)).x }
		public function set relativeY(value:Number):void { y += value - parent.globalToLocal(localToGlobal(transformationPoint)).y }
		public function set relativeWidth(value:Number):void { setRelativeProperty("width", value) }
		public function set relativeHeight(value:Number):void { setRelativeProperty("height", value) }
		public function set relativeScaleX(value:Number):void { setRelativeProperty("scaleX", value) }
		public function set relativeScaleY(value:Number):void { setRelativeProperty("scaleY", value) }
		public function set relativeRotation(value:Number):void { setRelativeProperty("rotation", value) }
		
		private function setRelativeProperty(prop:String, value:Number):void
		{
			var p1:Point, p2:Point;
			
			p1 = parent.globalToLocal(localToGlobal(transformationPoint));
			
			this[prop] = value;
			
			p2 = parent.globalToLocal(localToGlobal(transformationPoint));
			
			x -= p2.x - p1.x;
			y -= p2.y - p1.y;
		}
		////////////////////////////////////////////////////
	}
}