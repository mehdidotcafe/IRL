//
// Created by reyre on 16/05/18.
//

#include "Loop.h"
#include "Json/jsonParser.h"
#include "Entity/Map.h"
#include "Entity/Gen.h"

Loop::Loop()
{
}

void Loop::run(Network &net, int nbr_street, std::string mappath, int nbr_sensor)
{
    std::string json_r;
    jsonParser jParser;
    Map map(nbr_street, nbr_sensor);
    map.setMap(jParser.getMap(nbr_street, mappath), jParser.getSensors(mappath));
    jParser.displayMap(map.lstreet);
    jParser.displaySensor(map.lsensor);
    Gen generator(map);

    while (1) // gestion d'erreur a la place de 1
    {
        generator.randomize(net, jParser);
        json_r = net.read_s();
        jParser.
        std::cout << json_r << std::endl;
        generator.move();
    }
}