package {
  import flash.display.Sprite;
  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.media.Sound;
  import flash.ui.Mouse;
  import the_shave.Hair;
  import the_shave.Razor;

  public class TheShave extends Sprite {
    private var hairs:Array = new Array();
    private var level_xml:XML;
    private var display_port:Sprite = new Sprite();
    private var razor:Razor = new Razor();
    private var number_of_hairs:int = 0;
    private var razor_is_shaving:Boolean = false;

    public function TheShave():void {
      this.cacheAsBitmap = true;
      Mouse.hide();
      razor.mouseEnabled = false;
      razor.cacheAsBitmap = true;
      display_port.cacheAsBitmap = true;

      addChild(display_port);
      addChild(razor);

      load_background();
      load_level(1);
      load_music();

      stage.addEventListener(MouseEvent.MOUSE_DOWN, apply_razor);
      stage.addEventListener(Event.ENTER_FRAME, on_enter_frame);

      //draw_random_hairs();
    }

    // Static
    public static function random_range(max:Number, min:Number = 0):Number {
      return Math.random() * (max - min) + min;
    }

    // Events
    private function on_enter_frame(e:Event):void {
      for (var i:int = 0; i < number_of_hairs; i += 1) {
        // If the hair[i] is touching the razor's hitbox AND the
        // razor is currently in "shaving mode", then cut the hair.
        if (  razor_is_shaving &&
              hairs[i].not_yet_cut() &&
              hairs[i].hitTestObject(razor.hitbox)  ) {
          hairs[i].cut_hair();
        }
      }
      update_mouse_cursor();
    }

    private function apply_razor(e:MouseEvent):void {
      stage.removeEventListener(MouseEvent.MOUSE_DOWN, apply_razor);
      razor.gotoAndPlay("shave");
      razor_is_shaving = true;
      stage.addEventListener(MouseEvent.MOUSE_UP, release_razor);
    }

    private function release_razor(e:MouseEvent):void {
      stage.removeEventListener(MouseEvent.MOUSE_UP, release_razor);
      razor.gotoAndPlay("unshave");
      razor_is_shaving = false;
      stage.addEventListener(MouseEvent.MOUSE_DOWN, apply_razor);
    }

    // Helpers
    private function update_mouse_cursor():void {
      razor.x = mouseX;
      razor.y = mouseY;
    }

    private function load_music():void {
      var url:String = "assets/audio/the_shave_sped_up.mp3";
      var urlRequest:URLRequest = new URLRequest(url);
      var sound:Sound = new Sound();
      sound.load(urlRequest);
      sound.play(0, 9999);
    }

    private function load_background():void {
      // Load background here.
    }

    private function load_level(level_number:uint):void {
      var level_url = "./levels/level_" + level_number + ".xml";
      var level_loader:URLLoader = new URLLoader();
      level_loader.load(new URLRequest(level_url));
      level_loader.addEventListener(Event.COMPLETE, process_level_XML);
    }

    private function process_level_XML(e:Event):void {
      level_xml = new XML(e.target.data);
      var number_of_hair_types = level_xml.hairs.length();
      for (var i:uint = 0; i < number_of_hair_types; i += 1) { // each type of hair
        var hair_type = level_xml.hairs[i].@type;
        if (hair_type == "beard") {
          var number_of_hairs = level_xml.hairs[i].hair.length();
          for (var j:uint = 0; j < number_of_hairs; j += 1) { // each individual hair of the current hair-type
            var hair_x = level_xml.hairs[i].hair[j].@x;
            var hair_y = level_xml.hairs[i].hair[j].@y;
            var hair_rotation = level_xml.hairs[i].hair[j].@rotation;
            var hair = new Hair(hair_x, hair_y, hair_rotation);
            hairs.push(hair);
            display_port.addChild(hair);
            this.number_of_hairs += 1;
          }
        }
      }
    }

    private function draw_random_hairs():void {
      for (var i:uint = 0; i < 300; i += 1) {
        var hair_startx = random_range(stage.stageWidth);
        var hair_starty = random_range(stage.stageHeight);
        var hair_start_rotation = random_range(360); // * Math.PI / 180;
        var hair = new Hair(hair_startx, hair_starty, hair_start_rotation);
        hairs.push(hair);
        addChild(hair);
      }
    }
  }
}
