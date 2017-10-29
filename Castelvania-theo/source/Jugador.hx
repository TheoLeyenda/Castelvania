package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;

/**
 * ...
 * @author Theo Leyenda
 */
enum Estado{
	QUIETO;
	CORRE;
	SALTA;
}

class Jugador extends FlxSprite 
{
	private var state:Estado = Estado.QUIETO;
	private var habilitarA:Bool = false;
	private var habilitarD:Bool = false;
	private var Pinia:Trompada;
	private var habilitarTimer:Bool = false;
	private var tiempoPinia:Int = 15;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		Pinia = new Trompada(x, y);
		Pinia.kill();
		
		loadGraphic(AssetPaths.animations__png, true, 32, 32);
		animation.add("idle", [1], 8, false);
		animation.add("run", [1,2,3,4], 8, true);
		animation.add("jump", [5, 6, 7, 8], 8, false);
		animation.add("attack",[9, 10, 11, 12, 13, 14, 15, 16], 16, false);
		animation.add("attackJump",[17, 18, 19, 20, 21, 22, 23, 24], 8, false);
		//animation.play("idle");
		
		setFacingFlip(FlxObject.LEFT, true, false);//el segundo parametro dice si volteo X y el segundo si volteo Y (true lo voltea false no lo voltea)
		//voltea: cambia el signo.
		//para setear que mire para la izquierda;
		setFacingFlip(FlxObject.RIGHT, false, false);//el segundo parametro dice si volteo X y el segundo si volteo Y (true lo voltea false no lo voltea)
		//voltea: cambia el signo.h 
		// para setear que mire para la derecha;
		
		acceleration.y = 1500;
	}
	override public function update(elapsed:Float):Void
	{
		maquinaStado();
		Golpear();
		if (isTouching(FlxObject.FLOOR))
		{
			habilitarA = true;
			habilitarD = true;
		}
		super.update(elapsed);
	}
	public function maquinaStado():Void
	{
		switch(state)
		{
			case Estado.QUIETO:
				animation.play("idle");
				
				if (isTouching(FlxObject.FLOOR))
				{
					salto();
					movimientoHorizontal();
				}
				if (velocity.y != 0)
				{
					state = Estado.SALTA;
				}
				if (velocity.x != 0)
				{
					state = Estado.CORRE;
				}
			case Estado.SALTA:
				if (velocity.y == 0)
				{
					state = Estado.QUIETO;
				}
				if (habilitarA && habilitarD)
				{
					state = Estado.CORRE;
				}
			case Estado.CORRE:
				if (isTouching(FlxObject.FLOOR))
				{
					salto();
					movimientoHorizontal();
				}
				if (velocity.y != 0)
				{
					state = Estado.SALTA;
				}
				else if (velocity.x == 0)
				{
					state = Estado.QUIETO;
				}
		}
	}

	public function salto():Void
	{
		
		if (FlxG.keys.justPressed.W && isTouching(FlxObject.FLOOR))
		{
			animation.play("jump");
			if (facing == FlxObject.RIGHT)
			{
				habilitarA = false;
				velocity.x = 40;
				velocity.y = velocity.y -400;
			}
			else
			{
				habilitarD = false;
				velocity.x = -40;
				velocity.y = velocity.y -400;
			}
			state = Estado.SALTA;
		}
	}
	
	public function movimientoHorizontal():Void
	{
		velocity.x = 0;
		
		if (FlxG.keys.pressed.D && habilitarD)
		{
			velocity.x = velocity.x +300;
		}
		if (FlxG.keys.pressed.A && habilitarA)
		{
			velocity.x = velocity.x -300;
		}
		if (isTouching(FlxObject.FLOOR) && velocity.y == 0)
		{
			if (velocity.x != 0)
			{
				if (velocity.x > 0)
				{
					facing = FlxObject.RIGHT;
					animation.play("run");
					
				}
				if (velocity.x < 0)
				{
					facing = FlxObject.LEFT;
					animation.play("run");
					
				}
			}
		}
	}
	public function Golpear():Void
	{
		if (FlxG.keys.pressed.L)
		{
			animation.play("attack");

			
			Pinia.reset(x+width/2, y+(height*0.4));
			Pinia.makeGraphic(3, 3, 0xffff00ff);
			Pinia.velocity.x = 100;
			FlxG.state.add(Pinia);
			habilitarTimer = true;
		}
		if (habilitarTimer)
		{
			tiempoPinia = tiempoPinia - 1;
		}
		if (tiempoPinia == 0)
		{
			habilitarTimer = false;
			tiempoPinia = 15;
			Pinia.kill();
		}
	}
}
	
	