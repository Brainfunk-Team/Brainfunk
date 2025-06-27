package states.editors;

import openfl.net.FileReference;
import openfl.net.FileFilter;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import haxe.Json;
import backend.Paths;
import backend.ui.PsychUIEventHandler.PsychUIEvent;
import backend.ui.PsychUIBox;
import backend.ui.PsychUIInputText;
import backend.ui.PsychUIButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import Conductor;

class MidsongEditorState extends MusicBeatState implements PsychUIEvent {
    var emptyString:String = "(Empty!)";
    var text:Array<String> = [];
    var stepStart:Array<Int> = [];
    var stepEnd:Array<Int> = [];
    var fadeStepStart:Array<Int> = [];
    var fadeStepEnd:Array<Int> = [];
    var fadeTime:Array<Float> = [];
    var box:PsychUIBox;
    var textInput:PsychUIInputText;
    var songInput:PsychUIInputText;
    var currentText:FlxText;
    var previewText:FlxText;
    var reloadSongButton:PsychUIButton;
    var saveButton:PsychUIButton;
    var loadButton:PsychUIButton;
    var modeText:FlxText;
    var mode:Int = 0;
    var songPlaying:Bool = false;

    override function create():Void {
        super.create();
        FlxG.camera.bgColor = FlxColor.BLACK;

        box           = new PsychUIBox(10, 10, 300, 250, ["Type text here, then SPACE to set start/end", "SHIFT to toggle Dialogue/Fade"]);
        textInput     = new PsychUIInputText(20, 40, 260, "");
        songInput     = new PsychUIInputText(20, 300, 260, "");
        reloadSongButton = new PsychUIButton(20, 330, "Load Song", null, 100, 20);
        saveButton    = new PsychUIButton(130, 330, "Save JSON", null, 100, 20);
        loadButton    = new PsychUIButton(240, 330, "Load JSON", null, 100, 20);
        currentText   = new FlxText(20, 70, 260, emptyString);
        modeText      = new FlxText(20, 100, 260, "Mode: Dialogue");
        previewText   = new FlxText(0, FlxG.height - 50, FlxG.width, "");
        
        currentText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, "left");
        modeText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.YELLOW, "left");
        previewText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, "center");
        
        add(box);
        add(textInput);
        add(songInput);
        add(reloadSongButton);
        add(saveButton);
        add(loadButton);
        add(currentText);
        add(modeText);
        add(previewText);
        
        FlxG.mouse.visible = true;
    }

    override function update(elapsed:Float):Void {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new states.editors.MasterEditorMenu());
            FlxG.sound.playMusic(Paths.music("freakyMenu"));
        }

        if (FlxG.keys.justPressed.SHIFT) {
            mode = (mode + 1) % 2;
            modeText.text = "Mode: " + (if mode == 0 "Dialogue" else "Fade");
        }

        if (FlxG.keys.justPressed.SPACE) {
            var s = Conductor.curStep;
            if (mode == 0) {
                var t = if (textInput.text.length > 0) textInput.text else emptyString;
                text.push(t);
                stepStart.push(s);
                stepEnd.push(s); // initial, you can extend later
                currentText.text = "Added Dialogue @ " + s;
            } else {
                fadeStepStart.push(s);
                fadeStepEnd.push(s);
                var ft = Std.parseFloat(textInput.text) ?? 0.1;
                fadeTime.push(ft);
                currentText.text = "Added Fade @ " + s + " time:" + ft;
            }
        }

        if (songPlaying) {
            var disp:String = "";
            var step = Conductor.curStep;
            for (i in 0...text.length) if (step >= stepStart[i] && step <= stepEnd[i]) disp = text[i];
            previewText.text = disp;
        }
    }

    public function UIEvent(id:String, sender:Dynamic):Void {
        if (id == PsychUIInputText.CHANGE_EVENT && sender == textInput) {
            currentText.text = if (textInput.text.length > 0) textInput.text else emptyString;
        }

        if (id == PsychUIButton.CLICK_EVENT) {
            if (sender == reloadSongButton) {
                if (songPlaying) { 
                    Conductor.stopSong(); 
                    songPlaying = false; 
                }
                var name = songInput.text.trim();
                if (name.length > 0) {
                    song = name;
                    Conductor.curStep = 0;
                    Conductor.songPosition = 0;
                    loadSong();
                    songPlaying = true;
                    previewText.text = "";
                }
            } else if (sender == saveButton) {
                var d:Array<Dynamic> = [];
                for (i in 0...text.length) d.push({ text: text[i], startStep: stepStart[i], endStep: stepEnd[i] });
                var f:Array<Dynamic> = [];
                for (i in 0...fadeStepStart.length) f.push({ startStep: fadeStepStart[i], endStep: fadeStepEnd[i], fadeTime: fadeTime[i] });
                new FileReference().save(Json.stringify({ dialogue: d, fade: f }, "\t"), "midsong.json");
            } else if (sender == loadButton) {
                var fr = new FileReference();
                fr.addEventListener(Event.SELECT, function(_:Event) fr.load());
                fr.addEventListener(Event.COMPLETE, function(_:Event) {
                    var data = Json.parse(fr.data.toString());
                    text = []; stepStart = []; stepEnd = [];
                    fadeStepStart = []; fadeStepEnd = []; fadeTime = [];
                    for (d in (data.dialogue:Array<Dynamic>)) {
                        text.push(d.text);
                        stepStart.push(d.startStep);
                        stepEnd.push(d.endStep);
                    }
                    for (f in (data.fade:Array<Dynamic>)) {
                        fadeStepStart.push(f.startStep);
                        fadeStepEnd.push(f.endStep);
                        fadeTime.push(f.fadeTime);
                    }
                });
                fr.browse([new FileFilter("JSON","*.json")]);
            }
        }
    }
}
