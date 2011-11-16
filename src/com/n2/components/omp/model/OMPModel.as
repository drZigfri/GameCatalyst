package com.n2.components.omp.model
{
	import com.n2.common.games.IGameObject;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Eli Nesic
	 */
	public class OMPModel extends Actor
	{
		private var _selectedGameObject:IGameObject;
		
		public function OMPModel()
		{
		
		}
		
		public function get selectedGameObject():IGameObject
		{
			return _selectedGameObject;
		}
		
		public function set selectedGameObject(value:IGameObject):void
		{
			_selectedGameObject = value;
		}
	
	}

}