package com.n2.apps.gc.control {
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class AddResourcesClassesCommand extends Command {
		[Inject]
		public var loader:ComponentLoader;
		[Inject]
		public var model:GameCatalystModel;
		
		override public function execute():void {
			var resources:* = loader.getLoadedObjectByID("gameAssets");
			model.gameObjectsLibrary.gameResources = resources;
		}
	
	}

}