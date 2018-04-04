class Case {
  constructor() {
    this.type = {
      STREET: 1,
      HOUSE: 2
    }

    this.orientation = {
      NONE: 0,
      VERTICAL: 1,
      HORIZONTAL: 2
    }
  }

  new(type, orientation) {
    return {
      type: type,
      orientation: orientation,
      cars: [],
      pieds: []
    }
  }
}

module.exports = new Case
