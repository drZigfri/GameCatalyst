package com.n2.apps.catalyst.model {
	import com.n2.apps.catalyst.events.AssetLoaderEvent;
	import com.n2.apps.catalyst.events.XMLParserEvent;
	import com.n2.apps.catalyst.model.interfaces.ICatalystConfig;
	import com.n2.apps.catalyst.model.interfaces.ICatalystService;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class CatalystConfig extends Actor implements ICatalystConfig, ICatalystService {
		private var _gameAssetsConfig:Object;
		private var _gameObjectsConfig:Object;
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystConfig */
		
		public function get gameAssetsConfig():Object {
			return _gameAssetsConfig;
		}
		
		public function getGameAssetByID(id:String):Object {
			return null;
		}
		
		public function get gameObjectsConfig():Object {
			return _gameObjectsConfig;
		}
		
		public function getGameObjectByID(id:String):Object {
			return null;
		}
		
		/* INTERFACE com.n2.apps.catalyst.model.interfaces.ICatalystService */
		
		public function initialize():void {
			createObjects();
			mapEvents();
		}
		
		/* INTERFACE END */
		
		public function set gameAssetsConfig(value:Object):void {
			_gameAssetsConfig = value;
		}
		
		private function createObjects():void {
			_gameAssetsConfig = {};
			_gameObjectsConfig = {};
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, XMLParserEvent.OBJECT_DEFINITIONS_PARSED, handleObjectsDescriptorParsed, XMLParserEvent);
			eventMap.mapListener(eventDispatcher, XMLParserEvent.ASSETS_DESCRIPTOR_PARSED, handleAssetsDescriptorParsed, XMLParserEvent);
		}
		
		private function handleObjectsDescriptorParsed(e:XMLParserEvent):void {
			_gameObjectsConfig = e.value;
			dispatch(new AssetLoaderEvent(AssetLoaderEvent.OBJECTS_DESCRIPTOR_UPDATED, _gameObjectsConfig));
		}
		
		private function handleAssetsDescriptorParsed(e:XMLParserEvent):void {
			_gameAssetsConfig = e.value;
			dispatch(new AssetLoaderEvent(AssetLoaderEvent.ASSETS_DESCRIPTOR_UPDATED, _gameAssetsConfig ));
		}
	
	}

}