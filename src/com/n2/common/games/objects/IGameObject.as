package com.n2.common.games.objects {
	import away3d.entities.Mesh;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameObject {
		function get properties():GameObjectProperties;
		
		/**
		 * Game object's asset path ex. <strong>"com.n2.BoxMadness.assets.enemy::FootSoldier"</strogng>
		 */
		function get definition() : String;
	}

}