part of go_game;

var ScoreBox = React.registerComponent(() => new _ScoreBox());

class _ScoreBox extends FluxComponent<ScoreActions, ScoreStore> {
  
  getInitialState() {
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    int height = (avail / 5).round();
    int width = height * 3;
    
    return {
      'color': this.props['color'],
      'width': width,
      'height': height,
      'offset_box': this.props['offset_box']
    };
  }

  render() {
    List children = new List();
    String color = this.state['color'];

    int x = 0;
    int y = 0;

    int width = this.state['width'];
    int height = this.state['height'];
    
    if (this.state['offset_box'] == true) {
      y += height + 20;
    }

    int radius = (height / 8).round() - 1;

    int stones = store.blackCaptured;
    if (this.state['color'] == 'white') {
      stones = store.whiteCaptured;
    }

    var box = React.rect({
      'x': x,
      'y': y,
      'height': height,
      'width': width,
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    var watermark = (React.text({
      'x': x + 2,
      'y': y + height / 2 + 10,
      'height': 100,
      'width': 300,
      'fontSize': radius * 3
    }, '${color} capture tray'));

    children.add(watermark);
    children.add(box);

    int cx = x + radius + 1;
    int cy = y + radius + 1;
    int rows = 0;
    int gap = radius * 2 + 1;

    for(var i = 0; i < stones; i++) {
      children.add(React.circle({
        'cx': cx,
        'cy': cy,
        'r': radius,
        'fill': color,
        'opacity': '100'
      }));
      cx += gap;
      if (cx + radius > width) {
        cx = x + radius + 1;
        cy += gap;
        rows += 1;
      }
      if (cy + radius > y + height) {
        break;
      }
    }

    return React.g({}, children);
  }
}
