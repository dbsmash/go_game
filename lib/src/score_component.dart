part of go_game;

var Score = React.registerComponent(() => new _Score());

class _Score extends FluxComponent<ScoreActions, ScoreStore> {

  getInitialState() {
    int avail = [window.innerHeight, window.innerWidth].reduce(min);
    int height = (avail / 5).round();
    int width = height * 3;
    
    return {
      'width': width,
      'height': height
    };
  }

  render() {
    List children = new List();

    var blackBox = ScoreBox({
      'actions': this.actions, 
      'store': this.store,
      'color': 'black',
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    var whiteBox = ScoreBox({
      'actions': this.actions, 
      'store': this.store,
      'color': 'white',
      'offset_box': true,
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    children.add(blackBox);
    children.add(whiteBox);

    return React.svg({
      'version': '1.1',
      'xmlns': 'http://www.w3.org/2000/svg',
      'width': this.state['width'],
      'height': this.state['height'] * 5
    }, children);
  }
}
