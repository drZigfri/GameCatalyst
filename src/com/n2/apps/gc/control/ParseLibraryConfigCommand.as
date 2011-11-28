package com.n2.apps.gc.control {
	import com.n2.apps.gc.model.GameCatalystModel;
	import com.n2.apps.gc.model.services.loader.ComponentLoader;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ParseLibraryConfigCommand extends Command {
		[Inject]
		public var loader:ComponentLoader;
		[Inject]
		public var model:GameCatalystModel;
		
		override public function execute():void {
			var libraryXML:XML = new XML(loader.getLoadedObjectByID("libraryConfig"));
			var oList:XMLList = libraryXML.child("objects");
			var gameObjects:Object = {};
			
			for each (var item:XML in oList){
				var goList:XMLList = item.child("gameObject");
				
				for each (var go:XML in goList){
					var gameObject:Object = {};
					
					gameObject.id = go.attribute("id");
					gameObject.type = go.attribute("type");
					gameObject.assetGroup = go.attribute("assetGroup");
					gameObject.classPath = go.attribute("classPath");
					gameObject.assetPath = go.attribute("assetPath");
					gameObject.textureIDs = String(go.attribute("textureIDs")).split(";");
					gameObject.texturePaths = String(go.attribute("texturePaths")).split(";");
					gameObjects[go.attribute("id")] = gameObject;
				}
			}
			
			model.gameObjectsLibrary.assetsDescriptor = gameObjects;
		}
	}

}