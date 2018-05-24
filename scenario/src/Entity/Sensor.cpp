//
// Created by reyre on 20/05/18.
//

#include "Sensor.h"
#include "../Enum/SensorsState.h"

Sensor::Sensor(int id, int streetID, int pos_x, int pos_y)
{
    this->id = id;
    this->streetId = streetID;
    this->pos_x = pos_x;
    this->pos_y = pos_y;
    this->state = SensorsState::RED;
}

int Sensor::getId()
{
    return(this->id);
}

int Sensor::getPosX()
{
    return(this->pos_x);
}

int Sensor::getPosY()
{
    return(this->pos_y);
}

SensorsState Sensor::getState()
{
    return (this->state);
}
