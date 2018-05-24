//
// Created by reyre on 20/05/18.
//

#include <vector>

#include "Map.h"
#include "Street.h"
#include "Sensor.h"

Map::Map(int nbr_street, int nbr_sensor)
{
    this->street_nbr = nbr_street;
    this->sensor_nbr = nbr_sensor;
}

void Map::setMap(std::vector<Street> lstreet, std::vector<Sensor> lsensors)
{
    this->lstreet = lstreet;
    this->lsensor = lsensors;
}

Street &Map::getStreetsById(int id)
{
    for(int i = 0; i < this->lstreet.size(); i++)
    {
        if (id == this->lstreet[i].id)
            return (this->lstreet[i]);
    }
}

int Map::findInterStreet(int x, int y, int idS)
{
    for(int i = 0; i < this->lstreet.size(); i++)
    {
        if ( ((this->lstreet[i].startX >= x && this->lstreet[i].endX <= x) &&
                (this->lstreet[i].startY >= y && this->lstreet[i].endY <= y)) && idS != this->lstreet[i].id)
            return (lstreet[i].id);
    }
    return (-1);
}

int map::tileDispo(int x, int y)
{
    int res = 0;

    for(int i = 0; i < this->lc.size(); i++)
    {
        if (lc.pos_x == x || lc.pos_y == y)
            res++;
    }
    if (res >= 4)
        return (0);
    return (1);
}
