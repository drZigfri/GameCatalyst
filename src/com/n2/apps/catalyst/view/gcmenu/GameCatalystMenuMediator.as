package com.n2.apps.catalyst.view.gcmenu {
	import alternativa.gui.data.DataProvider;
	import alternativa.gui.event.DropDownMenuEvent;
	import com.n2.apps.catalyst.events.GCComponentEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalystMenuMediator extends Mediator {
		[Inject]
		public var view:GameCatalystMenuView;
		
		override public function onRegister():void {
			view.initializeMenu(getMenuConfig());
			
			mapEvents();
		}
		
		private function mapEvents():void {
			eventMap.mapListener(view.gameMenuDropDown, DropDownMenuEvent.SELECT, handleMenuItemSelected, DropDownMenuEvent);
		}
		
		private function getMenuConfig():DataProvider {
			var gmDataProvider:DataProvider = new DataProvider();
			var componentsItem:Object = { };
			
			//Components
			componentsItem.id = 1;
			componentsItem.label = "Components";
			componentsItem.items = new DataProvider();
			gmDataProvider.addItem(componentsItem);
			
			//Object propeties view
			var propertiesEditorItem:Object = {};
			propertiesEditorItem.id = 'ObjectProperties';
			propertiesEditorItem.label = "Object properties";
			propertiesEditorItem.parent = componentsItem;
			componentsItem.items.addItem(propertiesEditorItem);
			
			//Library view
			var libraryItem:Object = {};
			libraryItem.id = 'Library';
			libraryItem.label = "Assets library";
			libraryItem.parent = componentsItem;
			componentsItem.items.addItem(libraryItem);
			
			//camera control view
			var cameraControlItem:Object = {};
			cameraControlItem.id = 'CameraControl';
			cameraControlItem.label = "Camera controls";
			cameraControlItem.parent = componentsItem;
			componentsItem.items.addItem(cameraControlItem);
			
			//camera control view
			var gameObjectsLibraryItem:Object = {};
			gameObjectsLibraryItem.id = 'GameObjectsLibrary';
			gameObjectsLibraryItem.label = "Game objects lib";
			gameObjectsLibraryItem.parent = componentsItem;
			componentsItem.items.addItem(gameObjectsLibraryItem);
			
			return gmDataProvider;
		}
		
		private function handleMenuItemSelected(e:DropDownMenuEvent):void {
			switch (e.data.id) 
			{
				case 'Library':
					dispatch(new GCComponentEvent(GCComponentEvent.CREATE_COMPONENT, 'GameAssetsLibraryView'));
					break;
				case 'ObjectProperties':
					dispatch(new GCComponentEvent(GCComponentEvent.CREATE_COMPONENT, 'GameObjectPropertiesView'));
					break;
				case 'CameraControl':
					dispatch(new GCComponentEvent(GCComponentEvent.CREATE_COMPONENT, 'CameraControlView'));
					break;
				case 'GameObjectsLibrary':
					dispatch(new GCComponentEvent(GCComponentEvent.CREATE_COMPONENT, 'GameObjectsLibraryView'));
					break;
				default:
					break;
			};
		}
	}

}