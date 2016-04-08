part of go_game;

var Score = React.registerComponent(() => new _Score());

class _Score extends FluxComponent<ScoreActions, ScoreStore> {
  
  bool shouldComponentUpdate(nextProps, nextState) {
    return true;
  }

  render() {
    List children = new List();
    int blackCaptures = store.blackCaptured;
    int whiteCaptures = store.whiteCaptured;
    var blackRect = React.rect({
      'x': 0,
      'y': 10,
      'height': 100,
      'width': 300,
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    var whiteRect = React.rect({
      'x': 0,
      'y': 160,
      'height': 100,
      'width': 300,
      'fill': '#ffdc99',
      'stroke': 'darkGray',
      'strokeWidth': 1,
      'style': {'opacity': '.95',}
    });

    children.add(blackRect);
    children.add(whiteRect);

    children.add(React.text({
      'x': 30,
      'y': 65,
      'height': 100,
      'width': 300,
      'fontSize': 24
      }, '${blackCaptures} black stones captured'));

    children.add(React.text({
      'x': 30,
      'y': 215,
      'height': 100,
      'width': 300,
      'fontSize': 24
      }, '${whiteCaptures} white stones captured'));

    return React.svg({
      'version': '1.1',
      'xmlns': 'http://www.w3.org/2000/svg',
      'width': 300,
      'height': 300
    }, children);
  }
}
