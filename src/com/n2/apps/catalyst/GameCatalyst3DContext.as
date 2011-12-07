package com.n2.apps.catalyst {
	import com.n2.apps.catalyst.control.InitializeServicesCommand;
	import com.n2.apps.catalyst.control.LoadComponentsConfigCommand;
	import com.n2.apps.catalyst.control.ParseLibraryAssetsXMLCommand;
	import com.n2.apps.catalyst.control.ParseGameObjectsDefinitionsCommand;
	import com.n2.apps.catalyst.events.ContextEventGC;
	import com.n2.apps.catalyst.model.CatalystConfig;
	import com.n2.apps.catalyst.model.GameCatalystModel;
	import com.n2.apps.catalyst.model.interfaces.ICameraControl;
	import com.n2.apps.catalyst.model.interfaces.ICatalystConfig;
	import com.n2.apps.catalyst.model.interfaces.IGameAssetsLibrary;
	import com.n2.apps.catalyst.model.interfaces.IGameCatalystModel;
	import com.n2.apps.catalyst.model.interfaces.IGameObjectsLibrary;
	import com.n2.apps.catalyst.model.services.camera.CameraControl;
	import com.n2.apps.catalyst.model.services.library.GameAssetsLibrary;
	import com.n2.apps.catalyst.model.services.library.GameObjectsLibrary;
	import com.n2.apps.catalyst.model.services.loader.ComponentLoader;
	import com.n2.apps.catalyst.model.services.loader.events.ComponentLoaderEvent;
	import com.n2.apps.catalyst.model.services.loader.queue.LoaderQueue;
	import com.n2.apps.catalyst.view.GameCatalystMediator;
	import com.n2.apps.catalyst.view.GameCatalystView;
	import com.n2.apps.catalyst.view.gcmenu.GameCatalystMenuMediator;
	import com.n2.apps.catalyst.view.gcmenu.GameCatalystMenuView;
	import com.n2.components.controllers.camera.CameraControlView;
	import com.n2.components.controllers.camera.CameraControlViewMediator;
	import com.n2.components.gol.GameObjectsLibraryView;
	import com.n2.components.gol.GameObjectsLibraryViewMediator;
	import com.n2.components.gop.GameObjectPropertiesView;
	import com.n2.components.gop.GameObjectPropertiesViewMediator;
	import com.n2.components.ol.GameAssetsLibraryView;
	import com.n2.components.ol.GameAssetsLibraryViewMediator;
	import com.n2.components.scene.interfaces.ISceneModel;
	import com.n2.components.scene.model.SceneModel;
	import com.n2.components.scene.SceneMediator;
	import com.n2.components.scene.SceneView;
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameCatalyst3DContext extends Context {
		public function GameCatalyst3DContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true){
			super(contextView, autoStartup);
		}
		
		override public function startup():void {
			mapModels();
			mapServices();
			mapEvents();
			mapViews();
			mapClasses();
			
			initializeView();
			
			super.startup();
		}
		
		private function initializeView():void {
			//GameCatalyst(contextView).initializeView();
		}
		
		private function mapEvents():void {
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitializeServicesCommand, ContextEvent, true);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadComponentsConfigCommand, ContextEvent, true);
			commandMap.mapEvent(ComponentLoaderEvent.COMPONENTS_LOADED, ParseLibraryAssetsXMLCommand, ComponentLoaderEvent, true);
			commandMap.mapEvent(ComponentLoaderEvent.COMPONENTS_LOADED, ParseGameObjectsDefinitionsCommand, ComponentLoaderEvent, true);
		}
		
		private function mapModels():void {
			injector.mapSingleton(LoaderQueue);
			injector.mapSingleton(ComponentLoader);
			injector.mapSingletonOf(ISceneModel, SceneModel);
			injector.mapSingletonOf(IGameCatalystModel, GameCatalystModel);
		}
		
		private function mapServices():void {
			injector.mapSingletonOf(IGameAssetsLibrary, GameAssetsLibrary);
			injector.mapSingletonOf(IGameObjectsLibrary, GameObjectsLibrary);
			injector.mapSingletonOf(ICatalystConfig, CatalystConfig);
			injector.mapSingletonOf(ICameraControl, CameraControl);
		}
		
		private function mapClasses():void {
			injector.mapClass(ContextEventGC, ContextEventGC);
		}
		
		private function mapViews():void {
			mediatorMap.mapView(GameCatalystView, GameCatalystMediator);
			mediatorMap.mapView(GameCatalystMenuView, GameCatalystMenuMediator);
			mediatorMap.mapView(SceneView, SceneMediator);
			mediatorMap.mapView(GameObjectPropertiesView, GameObjectPropertiesViewMediator);
			mediatorMap.mapView(GameAssetsLibraryView, GameAssetsLibraryViewMediator);
			mediatorMap.mapView(CameraControlView, CameraControlViewMediator);
			mediatorMap.mapView(GameObjectsLibraryView, GameObjectsLibraryViewMediator);
		}
	}

}