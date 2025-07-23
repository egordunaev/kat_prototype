class KatFist : Weapon Replaces Fist
{
	default
	{
		Weapon.SlotNumber 1;
	}
	States
	{
		Ready:
			PUNG A 1 A_WeaponReady;
			TNT1 A 0 A_CheckMeleeProximity;
			Loop;
		Deselect:
			PUNG A 1 A_Lower(24); //24*8 for instant selection, maybe make this a powerup
			Loop;
		Select:
			PUNG A 1 A_Raise(24);
			Loop;
		Fire:
			//supposed to first play Fire or Fire1 then FireB of FireB1
			TNT1 A 0 A_StartSound("weapon/male/swoosh", 0, CHANF_OVERLAP);
			TNT1 A 0 A_JumpIfInventory("swungRightHand", 1, "FireB");
			TNT1 A 0 A_GiveInventory("swungRightHand", 1);
			TNT1 A 0 A_Jump(127, "Fire1");
			PUNG F 2;
			PUNG C 1 A_CheckMeleeProximitySound(); 
			PUNG B 1 A_CustomPunch(100, TRUE, CPF_NOTURN);
			PUNG D 1;
			PUNG E 1;
			PUNG F 1;
			TNT1 A 0 A_ReFire;
			TNT1 A 0 A_TakeInventory("swungRightHand", 1);
			Goto Ready;
		Fire1:
			PUNG F 2;
			PUNH C 1 A_CheckMeleeProximitySound(); 
			PUNH B 1 A_CustomPunch(100, TRUE, CPF_NOTURN);
			PUNH D 1;
			PUNH E 1;
			PUNG F 1;
			TNT1 A 0 A_ReFire;
			TNT1 A 0 A_TakeInventory("swungRightHand", 1);
			Goto Ready;
		FireB:
			TNT1 A 0 A_TakeInventory("swungRightHand", 1);
			TNT1 A 0 A_Jump(127, "FireB1");
			PUNI F 2;
			PUNI C 1 A_CheckMeleeProximitySound(); 
			PUNI B 1 A_CustomPunch(100, TRUE, CPF_NOTURN);
			PUNI D 1;
			PUNI E 1;
			PUNI F 1;
			TNT1 A 0 A_ReFire;
			Goto Ready;
		FireB1:
			TNT1 A 0 A_TakeInventory("swungRightHand", 1);
			PUNG F 2;
			PUNJ C 1 A_CheckMeleeProximitySound(); 
			PUNJ B 1 A_CustomPunch(100, TRUE, CPF_NOTURN);
			PUNJ D 1;
			PUNJ E 1;
			PUNG F 1;
			TNT1 A 0 A_ReFire;
			Goto Ready;	
		Hold:		
			TNT1 A 1 A_CheckMeleeProximity;
			TNT1 A 0 A_ReFire;
			Goto Ready;
	}
	
	//draw a crosshair if the player is close enough to melee
	action void A_CheckMeleeProximity()
	{
		FLineTraceData RemoteRay;
		bool hit = LineTrace(
				angle,
				64,
				pitch,
				offsetz: height-12,
				data: RemoteRay
		);

		if (hit && RemoteRay.HitType == TRACE_HitActor)
		{
			A_SetCrosshair(3);
		}
		else
		{
			A_SetCrosshair(0);
		}
	}
	
	//play sound and draw a crosshair if the player is close enough to melee
	action void A_CheckMeleeProximitySound()
	{
		FLineTraceData RemoteRay;
		bool hit = LineTrace
		(
			angle,
			64,
			pitch,
			offsetz: height-12,
			data: RemoteRay
		);

		if (hit && RemoteRay.HitType == TRACE_HitActor)
		{
			A_SetCrosshair(3);
			A_StartSound("weapon/male/fist", 0, CHANF_OVERLAP);
		}
		else
		{
			A_SetCrosshair(0);
		}
	}	
}

class swungRightHand : Inventory
{

}

class HandFire : Weapon Replaces Pistol
{	
	default
	{
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 100;
		Weapon.AmmoType "Clip";
		
		Inventory.PickupMessage "You got the fire spell!";
	}
	
	States 
	{
		Spawn:
		FRSP A -1;
		Stop;
		
		Select:
		HDFR AABBCCDD 1 A_Raise(24);
		Loop;
		
		Deselect:
		HDFR AABBCCDD 1 A_Lower(24);
		Loop;
		
		Ready:
		HDFR ABCD 3 A_WeaponReady;
		Loop;
		
		Fire:
		Goto HandFireFire;
		
		HandFireFire:
		HDFR E 0 A_PlaySound("weapon/handfire", CHAN_WEAPON, 1.7);
		HDFR EF 3;
		HDFR G 3 A_FireProjectile("PlasmaBall", 0, 2, 4, 0, 0);
		HDFR GH 3;
		HDFR I 0 A_Refire("HandFireFire");
		Goto Ready;
	}
}

class HandFireLevel2 : Weapon
{	
	default
	{
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 100;
		Weapon.AmmoType "Clip";
		
		Inventory.PickupMessage "Fire spell upraded to level 2!";
	}
	
	States 
	{
		Spawn:
		FRSP B -1;
		Stop;
		
		Select:
		HDFR AABBCCDD 1 A_Raise(24);
		Loop;
		
		Deselect:
		HDFR AABBCCDD 1 A_Lower(24);
		Loop;
		
		Ready:
		HDFR ABCD 3 A_WeaponReady;
		Loop;
		
		Fire:
		Goto HandFireFire;
		
		HandFireFire:
		HDFR E 0 A_PlaySound("weapon/handfire", CHAN_WEAPON, 1.7);
		HDFR EF 2;
		HDFR G 2 A_FireProjectile("PlasmaBall", 0, 2, 4, 0, 0);
		HDFR GH 2;
		HDFR I 0 A_Refire("HandFireFire");
		Goto Ready;
	}
}

Class HandFireLevel3 : Weapon
{	
	default
	{
		Weapon.SlotNumber 2;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 100;
		Weapon.AmmoType "Clip";
		
		Inventory.PickupMessage "Fire spell upraded to level 3!";
	}
	
	States 
	{
		Spawn:
		FRSP C -1;
		Stop;
		
		Select:
		HDFR AABBCCDD 1 A_Raise(24);
		Loop;
		
		Deselect:
		HDFR AABBCCDD 1 A_Lower(24);
		Loop;
		
		Ready:
		HDFR ABCD 3 A_WeaponReady;
		Loop;
		
		Fire:
		Goto HandFireFire;
		
		HandFireFire:
		HDFR E 0 A_PlaySound("weapon/handfire", CHAN_WEAPON, 1.7);
		HDFR EF 1;
		HDFR G 1 A_FireProjectile("PlasmaBall", 0, 2, 4, 0, 0);
		HDFR GH 1;
		HDFR I 0 A_Refire("HandFireFire");
		Goto Ready;
	}
}

class KatFireBall : Actor Replaces PlasmaBall 
{
	default
	{
		+RANDOMIZE
		
		Decal "Scorch";
		Projectile;
		
		Radius 5;
		Height 8;
		Speed 33;
		Damage 20;
		
		DeathSound "weapons/plasmax";
	}
	
	States 
	{
		Spawn:
		HDFM ABC 3 Bright;
		Loop;
		
		Death:
		HDFM DEFG 3 Bright;
		Stop;
	}
}
