package com.n2.apps.catalyst.view {
	import alternativa.gui.base.GUIobject;
	import com.n2.apps.catalyst.events.GCComponentEvent;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.components.controllers.camera.CameraControlView;
	import com.n2.components.gol.GameObjectsLibraryView;
	import com.n2.components.gop.GameObjectPropertiesView;
	import com.n2.components.ol.GameAssetsLibraryView;
	import flash.display.Sprite;
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
		public var model:IGameCatalystModel;
		
		public function GameCatalystMediator(){
		}
		
		override public function onRegister():void {
			mapEvents();
			view.initialize();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(eventDispatcher, GCComponentEvent.CREATE_COMPONENT, handleCreateComponent, GCComponentEvent);
		}
		
		private function handleCreateComponent(e:GCComponentEvent):void {
			var comp:GUIobject;
			var componentType:String = e.componentType;
			trace("componentExists(componentType): " + componentExists(componentType));
			if (!componentExists(componentType)){
				var compClass:Class = getComponentTypeClass(componentType);
				
				comp = new compClass();
				trace("comp: " + comp);
				if (comp != null){
					comp.x = 30;
					comp.y = 60;
					view.componentContainer.addChild(comp);
				}
			} else {
				removeComponent(componentType);
			}
		}
		
		private function componentExists(type:String):Boolean {
			var compClass:Class = getComponentTypeClass(type);
			var compContainer:Sprite = view.componentContainer;
			
			for (var i:int = 0; i < compContainer.numChildren; i++){
				var child:* = compContainer.getChildAt(i);
				if (child is compClass)
					return true;
			}
			
			return false;
		}
		
		private function removeComponent(type:String):void {
			var compClass:Class = getComponentTypeClass(type);
			var compContainer:Sprite = view.componentContainer;
			
			for (var i:int = 0; i < compContainer.numChildren; i++){
				var child:* = compContainer.getChildAt(i);
				if (child is compClass)
					compContainer.removeChild(child);
			}
		}
		
		private function getComponentTypeClass(type:String):Class {
			var compClass:Class;
			
			switch (type){
				case 'GameObjectPropertiesView': 
					compClass = GameObjectPropertiesView;
					break;
				case 'GameAssetsLibraryView': 
					compClass = GameAssetsLibraryView;
					break;
				case 'CameraControlView': 
					compClass = CameraControlView;
					break;
				case 'GameObjectsLibraryView': 
					compClass = GameObjectsLibraryView;
					break;
				default: 
					break;
			}
			
			return compClass;
		}
	}

}