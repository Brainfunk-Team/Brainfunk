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

class MidsongEditorState extends MusicBeatState implements PsychUIEvent
{
	var tip:Array<String> = [
		"Press Shift to select an event.",
		"Press Escape to exit."
	];

	var emptyString:String = "(Empty!)";

	var text:Array<String> = [""];
	var stepStart:Array<Int> = [0];
	var stepEnd:Array<Int> = [0];
	var fadeStepStart:Array<Int> = [0];
	var fadeStepEnd:Array<Int> = [0];
	var fadeTime:Array<Float> = [0.1];

	var dialogue:Array<Dynamic> = [];
	var fade:Array<Dynamic> = [];

	var box:PsychUIBox = new PsychUIBox(FlxG.width-300, FlxG.height-300, 300, 300, ["Dialogue Settings", "Fade Settings"]);
	var box2:PsychUIBox = new PsychUIBox(FlxG.width-300, 300, 300, 300, ["Song Settings"]);
	var textInput:PsychUIInputText = new PsychUIInputText(FlxG.width-300, FlxG.height-290, 100, "");
	var songInput:PsychUIInputText = new PsychUIInputText(FlxG.width-300, 20, 100, "");
	var currentText:FlxText = new FlxText(0, 0, FlxG.width, "(Empty!)");
	var reloadSongButton:PsychUIButton = new PsychUIButton(FlxG.width-300, 40, "Reload Song", null, 80, 20);
	var saveButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-200, "Save JSON", null, 80, 20);
	var loadButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-180, "Load JSON", null, 80, 22);
	
	var newEventButton:PsychUIButton = new PsychUIButton(FlxG.width-300, FlxG.height-180, "New Event", null, 80, 24);
	
	//General variables

	var songPlaying:Boolean = false;

	override function create() {
		FlxG.camera.bgColor = FlxColor.fromHSL(0, 0, 0.5);
		add(box);
		add(box2);
		add(textInput);
		add(songInput);
		add(saveButton);
		add(loadButton);
		add(newEventButton);
		add(reloadSongButton);
		currentText.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, "center");
		currentText.screenCenter(XY);
		currentText.color = FlxColor.RED;
		add(currentText);
		FlxG.mouse.visible = true;
	}
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

	override function update() {
		if(FlxG.keys.justPressed.ESCAPE) {
			MusicBeatState.switchState(new states.editors.MasterEditorMenu());
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		if(FlxG.key.justPressed.SPACE) {

		}

		if(FlxG.key.justPressed.SHIFT) {
			
		}
	}

	public function UIEvent(id:String, sender:Dynamic) {
		if(id == PsychUIInputText.CHANGE_EVENT && (sender is PsychUIInputText)) {
			if (sender == textInput) {
				if (textInput.text.length > 0) {
					currentText.text = textInput.text;
					currentText.color = FlxColor.WHITE;
				}
				else {
					currentText.text = emptyString;
					currentText.color = FlxColor.RED;
				}
			}
		}
		if(id == PsychUIButton.CLICK_EVENT && (sender is PsychUIButton)) {
			if (sender == reloadSongButton) {
				trace("Clicked reload!");
			}
			if (sender == saveButton) {
				trace("Save clicked, dialogue saved: " + currentText.text + "At step: 0");
				for (i in 0...text.length) {
					dialogue.push({
						text: text[i],
						startStep: stepStart[i],
						endStep: stepEnd[i]
					});
				}

				for (i in 0...fadeStepStart.length) {
					fade.push({
						startStep: fadeStepStart[i],
						endStep: fadeStepEnd[i],
						fadeTime: fadeTime[i]
					});
				}

				var midsongData = {
					dialogue: dialogue,
					fade: fade
				};

				var jsonStr = Json.stringify(midsongData, "\t");
				var fileRef = new FileReference();
				fileRef.save(jsonStr, "midsong.json");
			}
		}
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
