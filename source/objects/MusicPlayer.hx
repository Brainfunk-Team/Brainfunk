package objects;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import flixel.math.FlxMath;
import states.FreeplayState;

@:access(states.FreeplayState)
class MusicPlayer extends FlxGroup
{
    public var instance:FreeplayState;
    public var controls:Controls;

    public var playing(get, never):Bool;
    public var playingMusic:Bool = false;
    public var curTime:Float;

    var songBG:FlxSprite;
    var songTxt:FlxText;
    var timeTxt:FlxText;
    var progressBar:FlxBar;
	var playbackBG:FlxSprite;
    var playbackSymbols:Array<FlxText> = [];
    var playbackTxt:FlxText;

    var wasPlaying:Bool;
    var holdPitchTime:Float = 0;
    var playbackRate:Float = 1;


    var hoverTimer:Float = 0;
    var lastSongIndex:Int = -1;

    public function new(instance:FreeplayState)
    {
        super();
        this.instance = instance;
        this.controls = instance.controls;

        var xPos = FlxG.width * 0.7;

        songBG     = new FlxSprite(xPos-6,0).makeGraphic(1,100,0xFF000000);
        playbackBG = new FlxSprite(xPos-6,0).makeGraphic(1,100,0xFF000000);
        songBG.alpha = playbackBG.alpha = 0.6;
        add(songBG);
        add(playbackBG);

        songTxt = new FlxText(xPos,5,0,"",32);
        songTxt.setFormat(Paths.font("vcr.ttf"),32,FlxColor.WHITE,RIGHT);
        add(songTxt);

        timeTxt = new FlxText(xPos, songTxt.y+60,0,"",32);
        timeTxt.setFormat(Paths.font("vcr.ttf"),32,FlxColor.WHITE,RIGHT);
        add(timeTxt);

        for(i in 0...2)
        {
            var arrow = new FlxText(0,0,0,"^",32);
            arrow.setFormat(Paths.font("vcr.ttf"),32,FlxColor.WHITE,CENTER);
            if(i==1) arrow.flipY = true;
            arrow.visible = false;
            playbackSymbols.push(arrow);
            add(arrow);
        }

        progressBar = new FlxBar(
            timeTxt.x, timeTxt.y+timeTxt.height,
            LEFT_TO_RIGHT, Std.int(timeTxt.width),8,
            null,"",0,Math.POSITIVE_INFINITY
        );
        progressBar.createFilledBar(FlxColor.WHITE,FlxColor.BLACK);
        add(progressBar);

        playbackTxt = new FlxText(FlxG.width*0.6,20,0,"",32);
        playbackTxt.setFormat(Paths.font("vcr.ttf"),32,FlxColor.WHITE);
        add(playbackTxt);

        switchPlayMusic();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if(FreeplayState.curSelected != lastSongIndex)
        {
            lastSongIndex = FreeplayState.curSelected;
            hoverTimer = 0;

            if(playingMusic)
            {
                playingMusic = false;
                switchPlayMusic();
            }
        }

    if (!playingMusic)
    {

        if (FreeplayState.curSelected != lastSongIndex)
        {
            lastSongIndex = FreeplayState.curSelected;
            hoverTimer = 0;
        }

        else
        {
            hoverTimer += elapsed;
            if (hoverTimer >= 3)
            {

                playingMusic = true;
                switchPlayMusic();
                pauseOrResume();    
            }
        }
        return;
    }

        if(!playingMusic) return;

        var name = instance.songs[FreeplayState.curSelected].songName;
        songTxt.text = playing
            ? "PLAYING: " + name
            : "PLAYING: " + name + " (PAUSED)";

        if(controls.UI_LEFT_P || controls.UI_RIGHT_P)
        {
            if(playing) wasPlaying = true;
            pauseOrResume();
            curTime = FlxG.sound.music.time + (controls.UI_RIGHT_P ? 1000 : -1000);
            instance.holdTime = 0;
            curTime = FlxMath.bound(curTime,0,FlxG.sound.music.length);
            FlxG.sound.music.time = curTime;
            setVocalsTime(curTime);
        }

        if(controls.UI_LEFT || controls.UI_RIGHT)
        {
            instance.holdTime += elapsed;
            if(instance.holdTime > 0.5)
                curTime += 40000 * elapsed * (controls.UI_LEFT ? -1 : 1);
            curTime = FlxMath.bound(curTime,0,FlxG.sound.music.length);
            FlxG.sound.music.time = curTime;
            setVocalsTime(curTime);
        }

        if(controls.UI_LEFT_R || controls.UI_RIGHT_R)
        {
            FlxG.sound.music.time = curTime;
            setVocalsTime(curTime);
            if(wasPlaying)
            {
                pauseOrResume(true);
                wasPlaying = false;
            }
        }

        if(controls.UI_UP_P || controls.UI_DOWN_P)
        {
            holdPitchTime = 0;
            playbackRate += (controls.UI_UP_P ? 0.05 : -0.05);
            setPlaybackRate();
        }
        if(controls.UI_UP || controls.UI_DOWN)
        {
            holdPitchTime += elapsed;
            if(holdPitchTime > 0.6)
            {
                playbackRate += 0.05 * (controls.UI_UP ? 1 : -1);
                setPlaybackRate();
            }
        }

        if(controls.RESET)
        {
            playbackRate = 1;
            setPlaybackRate();
            FlxG.sound.music.time = 0;
            setVocalsTime(0);
        }

        if(playing)
        {
            if(FreeplayState.vocals       != null)
                FreeplayState.vocals.volume = (FreeplayState.vocals.length > FlxG.sound.music.time) ? 0.8 : 0;
            if(FreeplayState.opponentVocals != null)
                FreeplayState.opponentVocals.volume = (FreeplayState.opponentVocals.length > FlxG.sound.music.time) ? 0.8 : 0;

            if((FreeplayState.vocals != null &&
                Math.abs(FlxG.sound.music.time - FreeplayState.vocals.time) >= 25) ||
               (FreeplayState.opponentVocals != null &&
                Math.abs(FlxG.sound.music.time - FreeplayState.opponentVocals.time) >= 25))
            {
                pauseOrResume();
                setVocalsTime(FlxG.sound.music.time);
                pauseOrResume(true);
            }
        }

        positionSong();
        updateTimeTxt();
        updatePlaybackTxt();
    }

    function setVocalsTime(time:Float):Void
    {
        if(FreeplayState.vocals != null && FreeplayState.vocals.length > time)
            FreeplayState.vocals.time = time;
        if(FreeplayState.opponentVocals != null && FreeplayState.opponentVocals.length > time)
            FreeplayState.opponentVocals.time = time;
    }

    public function pauseOrResume(resume:Bool = false):Void
    {
        if(resume)
        {
            if(!FlxG.sound.music.playing) FlxG.sound.music.resume();
            if(FreeplayState.vocals != null && !FreeplayState.vocals.playing)       FreeplayState.vocals.resume();
            if(FreeplayState.opponentVocals != null && !FreeplayState.opponentVocals.playing) FreeplayState.opponentVocals.resume();
        }
        else
        {
            FlxG.sound.music.pause();
            if(FreeplayState.vocals        != null) FreeplayState.vocals.pause();
            if(FreeplayState.opponentVocals != null) FreeplayState.opponentVocals.pause();
        }
    }

    public function switchPlayMusic():Void
    {
        FlxG.autoPause = (!playingMusic && ClientPrefs.data.autoPause);
        active = visible = playingMusic;

        instance.scoreBG.visible  =
        instance.diffText.visible =
        instance.scoreText.visible = !playingMusic;

        songTxt.visible     =
        timeTxt.visible     =
        songBG.visible      =
        playbackTxt.visible =
        playbackBG.visible  =
        progressBar.visible = playingMusic;

        for(sym in playbackSymbols) sym.visible = playingMusic;

        holdPitchTime = 0;
        instance.holdTime = 0;
        playbackRate = 1;
        setPlaybackRate();
        updatePlaybackTxt();

        if(playingMusic)
        {
            instance.bottomText.text = Language.getPhrase(
              'musicplayer_tip',
              'Press ESCAPE to Exit / Press R to Reset the Song'
            );
            positionSong();
            progressBar.setRange(0, FlxG.sound.music.length);
            progressBar.setParent(FlxG.sound.music, "time");
            progressBar.numDivisions = 1600;
            updateTimeTxt();
        }
        else
        {
            progressBar.setRange(0, Math.POSITIVE_INFINITY);
            progressBar.setParent(null, "");
            progressBar.numDivisions = 0;
            instance.bottomText.text = instance.bottomString;
            instance.positionHighscore();
        }
        progressBar.updateBar();
    }

    function updatePlaybackTxt():Void
    {
        var s = if(Std.is(playbackRate,Int))
            Std.string(playbackRate)+".00"
        else
        {
            var t = Std.string(playbackRate);
            if(t.indexOf(".")>=0 && t.split(".")[1].length<2) t += "0";
            t;
        }
        playbackTxt.text = s + "x";
    }

    function positionSong():Void
    {
        var nm = instance.songs[FreeplayState.curSelected].songName;
        var len = nm.length;
        var short = len<5;

        songTxt.x = FlxG.width - songTxt.width - 6 - (short ? (10*len - len) : 0);
        songBG.scale.x = FlxG.width - songTxt.x + 12 + (short ? 6*len : 0);
        songBG.x = FlxG.width - (songBG.scale.x/2);

        timeTxt.x = Std.int(songBG.x + songBG.width/2) - timeTxt.width/2 - (short ? (len-5) : 0);

        playbackBG.scale.x = playbackTxt.width + 30;
        playbackBG.x = songBG.x - playbackBG.scale.x;
        playbackTxt.x = playbackBG.x - playbackTxt.width/2;
        playbackTxt.y = playbackTxt.height;

        progressBar.setGraphicSize(Std.int(songTxt.width),5);
        progressBar.y = songTxt.y+songTxt.height+10;
        progressBar.x = songTxt.x + songTxt.width/2 -15;
        if(short)
        {
            progressBar.scale.x += len/2;
            progressBar.x -= len-10;
        }

        for(i in 0...2)
        {
            var sym = playbackSymbols[i];
            sym.x = playbackTxt.x + playbackTxt.width/2 -10;
            sym.y = playbackTxt.y + (i==0 ? -playbackTxt.height : playbackTxt.height);
        }
    }

    function updateTimeTxt():Void
    {
        var t = FlxStringUtil.formatTime(FlxG.sound.music.time/1000,false)
              + " / "
              + FlxStringUtil.formatTime(FlxG.sound.music.length/1000,false);
        timeTxt.text = "< " + t + " >";
    }

    private function setPlaybackRate():Void
    {
        var v = FlxMath.roundDecimal(playbackRate,2);
        if(v>3)      v = 3;
        else if(v<0.25) v = 0.25;
        playbackRate = v;
        FlxG.sound.music.pitch = v;
        if(FreeplayState.vocals        != null) FreeplayState.vocals.pitch        = v;
        if(FreeplayState.opponentVocals != null) FreeplayState.opponentVocals.pitch = v;
    }

    function get_playing():Bool
    {
        return FlxG.sound.music.playing;
    }
}