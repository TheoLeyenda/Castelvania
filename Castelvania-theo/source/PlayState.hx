package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
class PlayState extends FlxState
{
	private var player:Jugador;
	private var plataforma:FlxSprite;
	private var obstaculo1:Obstaculo1;
	override public function create():Void
	{
		super.create();
		
		player = new Jugador(FlxG.width / 2, 100);
		obstaculo1 = new Obstaculo1(10, 200);
		obstaculo1.makeGraphic(100, 10,0xff00ffff);
		plataforma = new FlxSprite(10,220);
		plataforma.makeGraphic(246,32);
		plataforma.immovable = true;
		add(plataforma);
		add(player);
		add(obstaculo1);
		FlxG.camera.follow(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(plataforma, player);
		
		if (FlxG.pixelPerfectOverlap(player, obstaculo1))
		{
			player.y  = obstaculo1.y- player.height;
			if (obstaculo1.getContador() <= 100)
			{
				player.x = player.x +1;
			}
			if (obstaculo1.getContador() > 100)
			{
				player.x = player.x - 1;
			}
			if (obstaculo1.getContador() == 0)
			{
				player.x = player.x;
			}
		}
		if (player.isTouching(FlxObject.FLOOR))
		{
			player.velocity.y = 0;
		}
	}
}