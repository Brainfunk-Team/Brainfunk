package states;

class CoolState extends MusicBeatState
{
    public function new()
    {
        super();
    }

    override public function create():Void
    {
        super.create();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        
        if (FlxG.keys.justPressed.ESCAPE)
        {
            destroy();
        }
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}