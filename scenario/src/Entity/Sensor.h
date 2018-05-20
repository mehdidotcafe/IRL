//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_SENSOR_H
#define SCENARIO_SENSOR_H

#include "SensorsState.h"

class Sensor
{
public:
    Sensor::Sensor(int id, int pos_x, int pos_y);
    int getId();
    int getPosX();
    int getPosY();
    SensorsState getState();
private:
    int id;
    int pos_x;
    int pos_y;
    SensorsState state;
};


#endif //SCENARIO_SENSOR_H
