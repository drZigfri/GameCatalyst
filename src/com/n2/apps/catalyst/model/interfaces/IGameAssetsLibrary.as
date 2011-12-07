package com.n2.apps.catalyst.model.interfaces {
	import com.n2.common.games.objects.IGameObject;
	import fl.data.DataProvider;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameAssetsLibrary {
		function getAssetByID(id:String):*;
		
		function getAllAssets():DataProvider;
	}

}