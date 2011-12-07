package com.n2.common.games.objects {
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.MaterialBase;
	import com.n2.common.games.events.GameObjectEvent;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameObjectMesh extends Mesh {
		
		public function GameObjectMesh(material:MaterialBase = null, geometry:Geometry = null){
			super(material, geometry);
		
		}
		
		public function setupGameObject(gop:GameObjectProperties):void {
			dispatchEvent(new GameObjectEvent(GameObjectEvent.INITIALIZE_GOP, gop));
		}
	
	}

}