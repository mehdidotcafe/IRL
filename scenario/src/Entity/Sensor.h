//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_SENSOR_H
#define SCENARIO_SENSOR_H

#include "../Enum/SensorsState.h"

class Sensor
{
public:
    Sensor(int id, int, int pos_x, int pos_y);
    int getId();
    int getPosX();
    int getPosY();
    SensorsState getState();

    int id;
    int streetId;
    int pos_x;
    int pos_y;
    SensorsState state;

    private:
};


#endif //SCENARIO_SENSOR_H
