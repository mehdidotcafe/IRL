//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_PIEDESTRIAN_H
#define SCENARIO_PIEDESTRIAN_H

#include "Street.h"
#include "Sensor.h"

class Piedestrian
{
public:
    Piedestrian(int id, int pos_x, int pos_y, Street &, Sensor &);
    int getId();
    int getPosX();
    int getPosY();

    int id;
    int pos_x;
    int pos_y;
    Street &hstreet;
    Sensor &hsensor;
private:
};

#endif //SCENARIO_PIEDESTRIAN_H
