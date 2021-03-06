package sunag.sea3d.framework
{
	import away3d.entities.JointObject;
	
	import sunag.sea3dgp;
	import sunag.sea3d.objects.SEAJointObject;
	import sunag.sea3d.objects.SEAObject;
	
	use namespace sea3dgp;
	
	public class JointObject extends Object3D
	{
		sea3dgp var jointObj:away3d.entities.JointObject;
		
		sea3dgp var mesh:Mesh;
		
		public function JointObject()
		{
			super(jointObj = new away3d.entities.JointObject(null, 0, false));
		}
		
		private function updateInternal():void
		{
			if (mesh && _scene)
			{
				jointObj.target = mesh.mesh;
				jointObj.autoUpdate = true;
			}
			else
			{
				jointObj.autoUpdate = false;
			}
		}
		
		public function set target(val:Mesh):void
		{
			if (mesh == val) return;
			
			mesh = val;
			
			updateInternal();
		}
		
		public function get target():Mesh
		{
			return mesh;
		}
		
		public function set jointIndex(index:Number):void
		{
			jointObj.jointIndex = index;
			updateInternal();
		}
		
		public function get jointIndex():Number
		{
			return jointObj.jointIndex;
		}
		
		public function set jointName(name:String):void
		{
			jointObj.jointName = name;
			updateInternal();
		}
		
		public function get jointName():String
		{
			return jointObj.jointName;
		}
		
		sea3dgp override function setScene(scene:Scene3D):void
		{
			super.setScene(scene);
			
			target = parent as Mesh;
			
			updateInternal();
		}
		
		//
		//	LOADER
		//
		
		override sea3dgp function load(sea:SEAObject):void
		{
			super.load(sea);
			
			//
			//	JOINT OBJECT
			//
			
			var jnt:SEAJointObject = sea as SEAJointObject;
			
			target = jnt.target.tag;			
			jointIndex = jnt.joint;
		}
		
		override sea3dgp function copyFrom(asset:Asset):void
		{
			super.copyFrom(asset);
			
			var jo:JointObject = asset as JointObject;
			//target = jo.target;
			jointIndex = jo.jointIndex;			
		}
		
		override public function clone(force:Boolean=false):Asset
		{
			var jo:JointObject = new JointObject();		
			jo.copyFrom(this);
			return jo;
		}
	}
}