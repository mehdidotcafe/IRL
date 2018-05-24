#ifndef SCENARIO_JSONPARSER_H
#define SCENARIO_JSONPARSER_H

#include <vector>

#include "../Entity/Street.h"
#include "../Entity/Sensor.h"
#include "../Entity/Piedestrian.h"
#include "../Entity/Car.h"

class jsonParser
{
public:
    jsonParser();

    std::vector<Street> getMap(int, std::string);
    std::vector<Sensor> getSensors(std::string map);

    void changeSensorState(std::string, std::vector<Sensor>&);

    std::string CreateP(Piedestrian *, std::string);
    std::string CreateC(Car *, std::string);
    void displayMap(std::vector<Street> lstreets);
    void displaySensor(std::vector<Sensor>);
private:
};

#endif //SCENARIO_JSONPARSER_H
