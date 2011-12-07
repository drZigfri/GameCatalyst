package com.n2.apps.catalyst.model.interfaces {
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface ICatalystConfig {
		function get gameAssetsConfig():Object;
		
		function getGameAssetByID(id:String):Object;
		
		function get gameObjectsConfig():Object;
		
		function getGameObjectByID(id:String):Object;
	}

}