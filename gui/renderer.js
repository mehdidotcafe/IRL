// This file is required by the index.html file and will
// be executed in the renderer process for that window.
// All of the Node.js APIs are available in this process.

const Map = require('./Map')
const Case = require('./Case')

var game = new Phaser.Game(1200, 600, Phaser.AUTO, 'test', null, true, false);

var BasicGame = function (game) { };

BasicGame.Boot = function (game) { };

var isoGroup, sorted;

function getNameFromType(c, map, y, x) {
  var types = {
    [Case.orientation.HORIZONTAL]: 'street-hori',
    [Case.orientation.VERTICAL]: 'street-verti',
    [Case.orientation.NONE]: 'home'
  }
  if (c.type == Case.type.STREET)
  {
    var ops = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1]
    ];
    var count = 0;

    ops.forEach(op => {
      var ny = y + op[0];
      var nx = x + op[1];

      if (ny < map.length && ny >= 0 && nx >= 0 && nx < map[ny].length && map[ny][nx].type === Case.type.STREET)
        ++count;
    })

    if (count > 2)
      return 'street-inter'
  }

  return types[c.orientation]
}

BasicGame.Boot.prototype =
{
    preload: function () {
        game.load.image('street-inter', './assets/imgs/cityTiles_089.png');
        game.load.image('street-verti', './assets/imgs/cityTiles_073.png');
        game.load.image('street-hori', './assets/imgs/cityTiles_081.png');
        game.load.image('home', './assets/imgs/cityTiles_066.png');

        game.time.advancedTiming = true;

        // Add and enable the plug-in.
        game.plugins.add(new Phaser.Plugin.Isometric(game));

        // This is used to set a game canvas-based offset for the 0, 0, 0 isometric coordinate - by default
        // this point would be at screen coordinates 0, 0 (top left) which is usually undesirable.
        game.iso.anchor.setTo(0.5, 0.2);


    },
    create: function () {
        console.log(Map.createFromFile);
        let map = Map.createFromFile('../map.json');
        let tileSizeWidth = 132;
        let tileSizeHeight = 101;

        // console.log(map);
        // Create a group for our tiles, so we can use Group.sort
        isoGroup = game.add.group();

        // Let's make a load of cubes on a grid, but do it back-to-front so they get added out of order.
        var cube;
        for (var y = 0; y < map.length; y++) {
          for (var x = 0; x < map[y].length; x++) {
            cube = game.add.isoSprite(Math.floor(x * (tileSizeWidth / 2)), Math.floor(y * (tileSizeHeight / 2)), 0, getNameFromType(map[y][x], map, y, x), 0, isoGroup);
            cube.anchor.set(0.5);
            // cube.oldZ = cube.z;
          }
        }

        // for (var xx = 256; xx > 0; xx -= 48) {
        //     for (var yy = 256; yy > 0; yy -= 48) {
        //         // Create a cube using the new game.add.isoSprite factory method at the specified position.
        //         // The last parameter is the group you want to add it to (just like game.add.sprite)
        //         cube = game.add.isoSprite(xx, yy, 0, 'cube', 0, isoGroup);
        //         cube.anchor.set(0.5)
        //
        //         // Store the old messed up ordering so we can compare the two later.
        //         cube.oldZ = cube.z;
        //
        //         // Add a slightly different tween to each cube so we can see the depth sorting working more easily.
        //         // game.add.tween(cube).to({ isoZ: 10 }, 100 * ((xx + yy) % 10), Phaser.Easing.Quadratic.InOut, true, 0, Infinity, true);
        //     }
        // }

        // Just a var so we can tell if the group is sorted or not.
        // sorted = false;

        // Toggle sorting on click/tap.
        // game.input.onDown.add(function () {
        //     sorted = !sorted;
        //     if (sorted) {
                game.iso.simpleSort(isoGroup);
        //     }
        //     else {
        //         isoGroup.sort('oldZ');
        //     }
        // }, this);

    },
    update: function () {

    },
    render: function () {
        game.debug.text("Click to toggle! Sorting enabled: " + sorted, 2, 36, "#ffffff");
        game.debug.text(game.time.fps || '--', 2, 14, "#a7aebe");
    }
};

game.state.add('Boot', BasicGame.Boot);
game.state.start('Boot');
