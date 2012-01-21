package {
  import flash.display.Sprite;
  import the_shave.Hair;
  
  public class TheShave extends Sprite {    
    private var hairs:Array = new Array();
    
    public function TheShave():void {
      draw_hairs();
    }
    
    private function draw_hairs():void {
      for (var i:uint = 0; i < 300; i += 1) {
        var hair_startx = random_range(stage.stageWidth);
        var hair_starty = random_range(stage.stageHeight);
        var hair = new Hair(hair_startx, hair_starty);
        hairs.push(hair);
        addChild(hair);
      }
    }
    
    private function random_range(max:Number, min:Number = 0):Number {
      return Math.random() * (max - min) + min;
    }
  }
}