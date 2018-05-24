//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_CAR_H
#define SCENARIO_CAR_H

#include "Street.h"
#include "Sensor.h"

class Car
{
public:
    Car(int id, int pos_x, int pos_y, Street &);
    int getId();
    int getPosX();
    int getPosY();

    int inRange;
    int id;
    int pos_x;
    int pos_y;
    Street &hstreet;
    Sensor &hsensor;
private:
};

#endif //SCENARIO_CAR_H
