package com.n2.common.games {
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public interface IGameObject {
		/*
		 * Game object's asset path ex. <strong>"com.n2.BoxMadness.assets.enemy::FootSoldier"</strogng>
		 */
		function get definition() : String;
		
		/*
		 * Any type of display or 3d object
		 */
		function get representation() : *;
	}

}