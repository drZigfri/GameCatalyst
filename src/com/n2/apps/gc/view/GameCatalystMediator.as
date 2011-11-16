package com.n2.apps.gc.view {
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.components.library.events.AssetLoaderEvent;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystMediator extends Mediator {
		[Inject]
		public var view:GameCatalystView;
		[Inject]
		public var model:GameCatalystModel;
		
		public function GameCatalystMediator(){
		}
		
		override public function onRegister():void {
			//Map events
			eventMap.mapListener(model.gameObjectsLibrary, AssetLoaderEvent.LOAD_ASSETS_END, handleAssetsLoaded, AssetLoaderEvent);
			
			initView();
		}
		
		private function initView():void {
			view.initialize();
		}
		
		private function handleAssetsLoaded(e:AssetLoaderEvent):void {
			//TODO: Assets loaded handling
		}
	
	}

}