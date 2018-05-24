//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_STREET_H
#define SCENARIO_STREET_H

#include <vector>
#include "Street.h"

class Street
{
public:

    Street(int, int, int, int, int, int);
    std::vector<Street> getMap();
    int id;
    int dir;
    int startX;
    int endX;
    int startY;
    int endY;

private:
};

#endif //SCENARIO_STREET_H
