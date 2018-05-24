//
// Created by reyre on 20/05/18.
//

#ifndef SCENARIO_MAP_H
#define SCENARIO_MAP_H

#include <vector>

#include "Street.h"
#include "Sensor.h"
#include "Piedestrian.h"
#include "Car.h"

class Map
{
public:
    Map(int, int);
    void setMap(std::vector<Street>, std::vector<Sensor>);
    Street &getStreetsById(int);
    int tileDispo(int, int);

    std::vector<Street> lstreet;
    std::vector<Sensor> lsensor;
    int street_nbr;
    int sensor_nbr;
    std::vector<Piedestrian*> lp;
    std::vector<Car*> lc;
    int findInterStreet(int, int, int);
    private:
};

#endif //SCENARIO_MAP_H
