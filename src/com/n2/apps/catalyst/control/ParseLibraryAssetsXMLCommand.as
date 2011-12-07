package com.n2.apps.catalyst.control {
	import com.n2.apps.catalyst.events.XMLParserEvent;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.services.loader.ComponentLoader;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class ParseLibraryAssetsXMLCommand extends Command {
		[Inject]
		public var loader:ComponentLoader;
		[Inject]
		public var model:IGameCatalystModel;
		
		override public function execute():void {
			var libraryXML:XML = new XML(loader.getLoadedObjectByID("assets_library"));
			var oList:XMLList = libraryXML.child("objects");
			var gameObjects:Object = {};
			
			for each (var item:XML in oList){
				var goList:XMLList = item.child("gameAsset");
				
				for each (var go:XML in goList){
					var gameObject:Object = {};
					//Set object properties
					gameObject.id = go.attribute("id");
					gameObject.assetGroup = go.attribute("assetGroup");
					gameObject.assetPath = go.attribute("assetPath");
					
					//Add object as property with the name set to the objects id
					gameObjects[go.attribute("id")] = gameObject;
				}
			}
			
			//Set assets descriptor object
			dispatch(new XMLParserEvent(XMLParserEvent.ASSETS_DESCRIPTOR_PARSED, gameObjects));
		}
	}

}