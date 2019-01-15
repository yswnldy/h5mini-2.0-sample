package laya.d3.physics {
	import laya.components.Component;
	import laya.d3.core.Sprite3D;
	import laya.d3.physics.PhysicsTriggerComponent;
	import laya.d3.physics.PhysicsComponent;
	import laya.d3.physics.shape.ColliderShape;
	import laya.d3.utils.Physics3DUtils;
	import laya.events.Event;
	import laya.utils.Stat;
	
	/**
	 * <code>PhysicsCollider</code> 类用于创建物理碰撞器。
	 */
	public class PhysicsCollider extends PhysicsTriggerComponent {
		
		/**
		 * 创建一个 <code>PhysicsCollider</code> 实例。
		 * @param collisionGroup 所属碰撞组。
		 * @param canCollideWith 可产生碰撞的碰撞组。
		 */
		public function PhysicsCollider(collisionGroup:int = Physics3DUtils.COLLISIONFILTERGROUP_DEFAULTFILTER, canCollideWith:int = Physics3DUtils.COLLISIONFILTERGROUP_ALLFILTER) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			super(collisionGroup, canCollideWith);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _addToSimulation():void {
			_simulation._dynamicPhysicsColliders.push(this);
			_simulation._addPhysicsCollider(this, _collisionGroup, _canCollideWith);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _removeFromSimulation():void {
			_simulation._removePhysicsCollider(this);
			var dynamicPhysicsColliders:Vector.<PhysicsCollider> = _simulation._dynamicPhysicsColliders;
			dynamicPhysicsColliders.splice(dynamicPhysicsColliders.indexOf(this), 1);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _parse(data:Object):void {
			(data.friction != null) && (friction = data.friction);
			(data.rollingFriction != null) && (rollingFriction = data.rollingFriction);
			(data.restitution != null) && (restitution = data.restitution);
			(data.isTrigger != null) && (isTrigger = data.isTrigger);
			super._parse(data);
			_parseShape(data.shapes);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _onAdded():void {
			var physics3D:* = Laya3D._physics3D;
			var btColObj:* = new physics3D.btCollisionObject();
			btColObj.setUserIndex(id);
			btColObj.forceActivationState(ACTIVATIONSTATE_DISABLE_SIMULATION);//prevent simulation
			
			var flags:int = btColObj.getCollisionFlags();
			if ((owner as Sprite3D).isStatic) {//TODO:
				if ((flags & COLLISIONFLAGS_KINEMATIC_OBJECT) > 0)
					flags = flags ^ COLLISIONFLAGS_KINEMATIC_OBJECT;
				flags = flags | COLLISIONFLAGS_STATIC_OBJECT;
			} else {
				if ((flags & COLLISIONFLAGS_STATIC_OBJECT) > 0)
					flags = flags ^ COLLISIONFLAGS_STATIC_OBJECT;
				flags = flags | COLLISIONFLAGS_KINEMATIC_OBJECT;
			}
			btColObj.setCollisionFlags(flags);
			_nativeColliderObject = btColObj;
			super._onAdded();
		}
	}

}