package com.n2.components.library {
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class GameAssets {
		[Embed(source="../../../../../lib/assets/models/Box001.3DS",mimeType="application/octet-stream")]
		private var boxAsset:Class;
		[Embed(source="../../../../../lib/assets/models/player01.3DS",mimeType="application/octet-stream")]
		private var playerAsset:Class;
		[Embed(source="../../../../../lib/assets/textures/box001.jpg")]
		private var boxSkin:Class;
		[Embed(source="../../../../../lib/assets/textures/player01.jpg")]
		private var playerSkin:Class;
		
		public function GameAssets(){
		
		}
		
		public function get BoxAsset():Class {
			return boxAsset;
		}
		
		public function get BoxSkin():Class {
			return boxSkin;
		}
		
		public function get PlayerAsset():Class {
			return playerAsset;
		}
		
		public function get PlayerSkin():Class {
			return playerSkin;
		}
	
	}

}