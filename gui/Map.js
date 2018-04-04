const Case = require('./Case')

class Map {
  addConn(node, remoteNode, distance) {
    node.conns.push(this.createNode(remoteNode, distance))
    remoteNode.conns.push(this.createNode(node, distance))
  }

  createConn(node, distance) {
    return {
      node: node,
      distance: distance,
      cars: [],
      pieds: []
    }
  }

  createNode() {
    return {
      conns: []
    }
  }

  createCase(type) {
    return {
      type: type
    }
  }

  insertStreet(map, streets) {
    streets.forEach(street => {
      for (var i = street.startY; i <= street.endY; i++) {
        for (var j = street.startX; j <= street.endX; j++) {
          map[i][j] = Case.new(Case.type.STREET, street.startY === street.endY ? Case.orientation.VERTICAL : Case.orientation.HORIZONTAL);
        }
      }
    })
    return map;
  }

  print(map) {
    var str = "";
    for (var i = 0; i < map.length; i++) {
      for (var j = 0; j < map[i].length; j++)
        process.stdout.write(map[i][j].type === Case.type.STREET ? 'S' : 'H');
      process.stdout.write('\n\r');
    }
  }

  initDefault(streets) {
    var maxX = streets.reduce((acc, value) => Math.max(acc, value.endX), 0)
    var maxY = streets.reduce((acc, value) => Math.max(acc, value.endY), 0)
    var map = [];

    for (var i = 0; i <= maxY; i++) {
      map[i] = [];
      for (var j = 0; j <= maxX; j++) {
        map[i][j] = Case.new(Case.type.HOUSE, Case.orientation.NONE);
      }
    }

    map = this.insertStreet(map, streets);
    return map;
  }

  createFromFile(file) {
    const conf = require(file)
    const streets = conf.streets;
    let map = this.initDefault(streets);

    return map;
  }
}

module.exports = new Map
