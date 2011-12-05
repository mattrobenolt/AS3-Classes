package com.ydekproductions.loading
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;

	public class MultiLoader extends EventDispatcher
	{
		private var _requests:Array;
		private var _loaders:Array;
		private var _activeLoaders:Array;
		
		private var _bytesLoaded:uint;
		private var _bytesTotal:uint;
				
		private var _totalStarted:int;
		
		public function MultiLoader()
		{
			_requests      = new Array();
			_loaders       = new Array();
			_activeLoaders = new Array();
			
			_totalStarted = 0;
		}
		
		public function add($request:URLRequest, $loader:Loader):void
		{
			_requests.push($request);
			_loaders.push($loader);
		}
		
		public function start():void
		{
			var i:int;
			
			for (i = 0; i < _loaders.length; i++)
			{
				//_loaders[i].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
				_loaders[i].contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
				_loaders[i].contentLoaderInfo.addEventListener(Event.OPEN, onLoadStart);
				_loaders[i].load(_requests[i]);
				
				_activeLoaders.push(_loaders[i]);
			}
		}
		
		public function stop():void
		{
			for (var i:int; i< _activeLoaders.length; i++)
			{
				_activeLoaders[i].close();
			}
		}
		
		public function destroy():void
		{
			var i:int;
			
			for (i = 0; i < _activeLoaders.length; i++)
			{
				_activeLoaders[i].contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				_activeLoaders[i].contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				_activeLoaders[i].contentLoaderInfo.removeEventListener(Event.OPEN, onLoadStart);
				
				_activeLoaders[i].close();
			}
			
			_loaders = null;
			_requests = null;
			_activeLoaders = null;
		}
		
		private function onLoadStart($event:Event):void
		{
			_totalStarted++;
			
			if(_totalStarted == _loaders.length)
			{
				for(var i:int = 0; i < _loaders.length; i++)
				{
					_loaders[i].contentLoaderInfo.removeEventListener(Event.OPEN, onLoadStart);
					
					_loaders[i].contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
				}
			}
		}
		
		private function onProgress($event:ProgressEvent):void
		{
			var i:int;
			
			_bytesLoaded = 0;
			_bytesTotal  = 0;
			
			for (i = 0; i < _loaders.length; i++)
			{	
				_bytesLoaded += _loaders[i].contentLoaderInfo.bytesLoaded;
				_bytesTotal  += _loaders[i].contentLoaderInfo.bytesTotal;
			}
			
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, _bytesLoaded, _bytesTotal));
		}
		
		private function onComplete($event:Event):void
		{
			_activeLoaders.splice(_activeLoaders.indexOf($event.target.loader), 1);
			
			Loader($event.target.loader).contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			Loader($event.target.loader).contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			
			if (_activeLoaders.length == 0)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				
				_loaders       = new Array();
				_requests      = new Array();
				_totalStarted  = 0;
			}
		}
		
		public function get progress():Number
		{
			return _bytesLoaded/_bytesTotal;
		}
		
		public function get loaders():Array
		{
			return _loaders;
		}
				
	}
	
}