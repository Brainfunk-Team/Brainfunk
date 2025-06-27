package states.stages;

import states.stages.objects.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import states.PlayState;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.group.FlxGroup;

class Bedroom extends BaseStage
{
    var tv:FlxSprite;

	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0xFFFFFFFF;

		// Bedroom background sprites
		var sky = new BGSprite("bedroom/sky", -95, 234);
		sky.scrollFactor.set(1, 1);
		sky.antialiasing = true;
		sky.color = FlxColor.WHITE;
		add(sky);

		var bg = new BGSprite("bedroom/bg", -442, -241);
		bg.scrollFactor.set(1, 1);
		bg.antialiasing = true;
		bg.color = FlxColor.WHITE;
		add(bg);

		var bed = new BGSprite("bedroom/bed", 947, 533);
		bed.scrollFactor.set(1, 1);
		bed.antialiasing = true;
		bed.color = FlxColor.WHITE;
		add(bed);

        tv = new BGSprite("bedroom/tv", -628, 692);
		tv.scrollFactor.set(1, 1);
		tv.antialiasing = true;
		tv.color = FlxColor.WHITE;

		// Fade overlay
		var fade = new FlxSprite(-975, -690);
		fade.makeGraphic(10000, 10000, FlxColor.BLACK);
		fade.scrollFactor.set(0, 0);
		fade.alpha = 0.5;
		add(fade);

		// Stage camera settings
		if (PlayState.instance != null)
		{
			PlayState.instance.defaultCamZoom = 0.7;
			PlayState.instance.camZooming = true;
			PlayState.instance.cameraSpeed = 1;
		}

		// Hide girlfriend
		if (gf != null) gf.visible = false;
	}

	override public function createPost():Void
	{
		// Character positions (offset Y by +300)
		if (boyfriend != null) boyfriend.setPosition(890, 280 + 300);
		if (gf != null) gf.setPosition(400, 130 + 310000000);
		if (dad != null) dad.setPosition(205, 260 + 200);
        if (tv != null) add(tv);
	}
}
