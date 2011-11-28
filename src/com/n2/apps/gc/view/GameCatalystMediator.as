package com.n2.apps.gc.view {
	import com.n2.apps.gc.events.ContextEventGC;
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import com.n2.apps.gc.model.services.loader.events.ComponentLoaderEvent;
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
		[Inject]
		public var loader:ComponentLoader;
		
		public function GameCatalystMediator(){
		}
		
		override public function onRegister():void {
			//Map events
		}
	}

}