package com.n2.apps.gc.model.interfaces {
	import com.n2.common.games.IGameObject;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameObjectsLibrary {
		function initialize():void;
		
		function getResourceByID(id:String):Object;
		
		function getGameObjectByID(id:String):*;
		
		function getGameObjectsByType(type:String):IGameObject;
	}

}