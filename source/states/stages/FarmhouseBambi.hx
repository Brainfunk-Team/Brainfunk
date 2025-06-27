package states.stages;

import states.stages.objects.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import states.PlayState;

class FarmhouseBambi extends BaseStage
{
    public var sky:BGSprite;
    public var flatGrass:BGSprite;
    public var farmhouse:BGSprite;
    public var grassLands:BGSprite;
    public var cornFence2:BGSprite;
    public var cornFence:BGSprite;
    public var sign:BGSprite;
    public var cornBag:BGSprite;
    public var hiddenElements:Array<FlxSprite>;

    override public function create():Void
    {
        super.create();
        FlxG.camera.bgColor = 0xff000000;

        // Stage elements
        sky = new BGSprite("sky", -736, -717);
        sky.scrollFactor.set(0.1, 0.1);
        add(sky);

        flatGrass = new BGSprite("farm/gm_flatgrass", -259, -66);
        flatGrass.scrollFactor.set(1, 1);
        add(flatGrass);

        farmhouse = new BGSprite("farm/funfarmhouse", -202, -140);
        farmhouse.scrollFactor.set(1, 1);
        add(farmhouse);

        grassLands = new BGSprite("farm/grass lands", -737, 326);
        grassLands.scrollFactor.set(1, 1);
        grassLands.scale.set(1.1, 2.2);
        grassLands.updateHitbox();
        add(grassLands);

        cornFence2 = new BGSprite("farm/cornFence2", 872, 117);
        cornFence2.scrollFactor.set(1, 1);
        add(cornFence2);

        cornFence = new BGSprite("farm/cornFence", -431, 145);
        cornFence.scrollFactor.set(1, 1);
        add(cornFence);

        sign = new BGSprite("farm/sign", -90, 358);
        sign.scrollFactor.set(1, 1);
        add(sign);

        cornBag = new BGSprite("farm/cornbag", 1118, 531);
        cornBag.scrollFactor.set(1, 1);
        add(cornBag);

        // Set all alphas to fully visible
        for (sprite in [sky, flatGrass, farmhouse, grassLands, cornFence2, cornFence, sign, cornBag]) {
            sprite.antialiasing = true;
            sprite.color = FlxColor.WHITE;
            sprite.alpha = 1;
        }

        // Fade overlay (optional)
        var fadeOverlay = new FlxSprite(-1440, -680);
        fadeOverlay.makeGraphic(10000, 10000, FlxColor.BLACK);
        fadeOverlay.scrollFactor.set(0, 0);
        fadeOverlay.alpha = 0.4;
        add(fadeOverlay);

        if (PlayState.instance != null)
        {
            PlayState.instance.defaultCamZoom = 1;
            PlayState.instance.camZooming = true;
            PlayState.instance.cameraSpeed = 1;
        }

        if (gf != null) gf.visible = true;
    }

    override public function createPost():Void
    {
        if (boyfriend != null) boyfriend.setPosition(910, 460);
        if (gf != null) gf.setPosition(400, 130);
        if (dad != null) dad.setPosition(80, 495);
    }
}