package com.n2.apps.catalyst.model.interfaces {
	import com.n2.components.scene.interfaces.ISceneModel;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameCatalystModel {
		function get gameDescriptor():ICatalystConfig;
		
		function get gameAssetsLibrary():IGameAssetsLibrary;
		
		function get gameObjectsLibrary():IGameObjectsLibrary;
		
		function get scene():ISceneModel;
		
		function get cameraControlModel():ICameraControl;
		
		function get catalystConfig():ICatalystConfig;
	}

}