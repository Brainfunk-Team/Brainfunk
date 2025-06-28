package states.stages;

import states.stages.objects.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import states.PlayState;

class FarmNight extends BaseStage
{
    public var sky:BGSprite;
    public var flatGrass:BGSprite;
    public var farmhouse:BGSprite;
    public var grassLands:BGSprite;
    public var cornFence2:BGSprite;
    public var cornFence:BGSprite;
    public var sign:BGSprite;
    public var cornBag:BGSprite;
    public var fadeOverlay:FlxSprite;
    public var whiteFade:FlxSprite;

    override public function create():Void
    {
        super.create();
        FlxG.camera.bgColor = 0xff000000;

        sky = new BGSprite("sky_night", -736, -572, 0.1, 0.1);
        add(sky);

        flatGrass = new BGSprite("farm/gm_flatgrass", -259, -316);
        add(flatGrass);

        farmhouse = new BGSprite("farm/funfarmhouse", -202, -440);
        add(farmhouse);

        grassLands = new BGSprite("farm/grass lands", -737, 26);
        grassLands.scale.set(1.1, 2.2);
        grassLands.updateHitbox();
        add(grassLands);

        cornFence2 = new BGSprite("farm/cornFence2", 872, -183);
        add(cornFence2);

        cornFence = new BGSprite("farm/cornFence", -431, -155);
        add(cornFence);

        sign = new BGSprite("farm/sign", -90, 58);
        add(sign);

        cornBag = new BGSprite("farm/cornbag", 1118, 231);
        add(cornBag);

        for (sprite in [sky, flatGrass, farmhouse, grassLands, cornFence2, cornFence, sign, cornBag]) {
            sprite.antialiasing = true;
            sprite.color = FlxColor.WHITE;
            sprite.alpha = 1;
        }

        fadeOverlay = new FlxSprite(-1440, -680);
        fadeOverlay.makeGraphic(10000, 10000, FlxColor.BLACK);
        fadeOverlay.scrollFactor.set(0, 0);
        fadeOverlay.alpha = 0.4;
        add(fadeOverlay);

        whiteFade = new FlxSprite(-280, -180);
        whiteFade.makeGraphic(1850, 1250, FlxColor.WHITE);
        whiteFade.scrollFactor.set(0, 0);
        whiteFade.alpha = 0;
        add(whiteFade);

        if (PlayState.instance != null)
        {
            PlayState.instance.defaultCamZoom = 0.85;
            PlayState.instance.cameraSpeed = 1;
        }

        if (gf != null) gf.visible = true;
    }

    override public function createPost():Void
    {
        if (boyfriend != null) boyfriend.setPosition(910, 200);
        if (gf != null) gf.setPosition(400, -170);
        if (dad != null) dad.setPosition(80, 195);
    }
}
