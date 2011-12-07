package com.n2.components.scene.interfaces {
	import away3d.entities.Mesh;
	import fl.data.DataProvider;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface ISceneModel {
		function get selectedStageObject():Mesh;
		
		function get stageObjects():DataProvider;
	}

}