package com.n2.components.library.interfaces {
	import com.n2.common.games.IGameObject;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameObjectsLibrary {
		function initialize():void;
		
		function loadAssets():void;
		
		function getGameObjectByID(id:String):*;
		
		function getGameObjectsByType(type:String):IGameObject;
	}

}