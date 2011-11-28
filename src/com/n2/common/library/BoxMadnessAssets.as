package com.n2.common.library {
	import com.n2.apps.gc.model.interfaces.IGameAssets;
	import flash.display.Sprite;
	import flash.errors.IOError;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class BoxMadnessAssets extends Sprite implements IGameAssets {
		[Embed(source="../../../../../lib/assets/models/Box001.3DS",mimeType="application/octet-stream")]
		public var boxAsset:Class;
		[Embed(source="../../../../../lib/assets/models/player01.3DS",mimeType="application/octet-stream")]
		public var playerAsset:Class;
		[Embed(source="../../../../../lib/assets/textures/box001.jpg")]
		public var boxSkin:Class;
		[Embed(source="../../../../../lib/assets/textures/player01.jpg")]
		public var playerSkin:Class;
		
		/* INTERFACE com.n2.components.library.interfaces.IGameAssets */
		
		public function getAssetByID(id:String):Class {
			if (this[id] != null)
				return this[id] as Class;
			else throw(new IOError("No asset under id '" + id + "'"));
		}
	
	}

}