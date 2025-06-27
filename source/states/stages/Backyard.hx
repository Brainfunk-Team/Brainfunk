package states.stages;

import states.stages.objects.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import states.PlayState;

class Backyard extends BaseStage
{
    override public function create():Void
    {
        super.create();
        FlxG.camera.bgColor = 0xFFFFFFFF;

        var fade = new FlxSprite(-1050, -1270);
        fade.makeGraphic(10000, 10000, FlxColor.BLACK);
        fade.alpha = 0;
        fade.scrollFactor.set(0, 0);
        add(fade);

        var sky = new BGSprite("sky", -342, -420);
        add(sky);

        var hills = new BGSprite("backyard/hills", -766, -353);
        add(hills);

        var grassBg = new BGSprite("backyard/grass bg", -1019, 230);
        add(grassBg);

        var gate = new BGSprite("backyard/gate", -398, 15);
        add(gate);

        var grass = new BGSprite("backyard/grass", -748, 185);
        add(grass);

        var grassFlip = new BGSprite("backyard/grass", -838, 765);
        grassFlip.angle = 180;
        add(grassFlip);

        if (PlayState.instance != null)
        {
            PlayState.instance.defaultCamZoom = 0.85;
            PlayState.instance.cameraSpeed = 1;
        }
    }

    override public function createPost():Void
    {
        // Character positions
        if (boyfriend != null) boyfriend.setPosition(830, 120);
        if (gf != null) gf.setPosition(400, 130);
        if (dad != null) dad.setPosition(100, 0);
    }
}
