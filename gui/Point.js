class Point {
  static getFromLines(a, b) {
    const x1 = a.startX;
    const x2 = a.endX;
    const x3 = b.startX;
    const x4 = b.endX;

    const y1 = a.startY;
    const y2 = a.endY;
    const y3 = b.startY;
    const y4 = b.endY;

    const a1 = (y2-y1)/(x2-x1)
    const b1 = y1 - a1*x1
    const a2 = (y4-y3)/(x4-x3)
    const b2 = y3 - a2*x3

    return {
      startX: a1,
      endX: a2,
      startY: b1,
      endY: b2
    }
  }
}

module.exports = new Point
