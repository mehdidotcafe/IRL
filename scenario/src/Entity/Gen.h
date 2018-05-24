//
// Created by reyre on 16/05/18.
//

#ifndef IRL_GEN_H
#define IRL_GEN_H

#include "Map.h"
#include "../Network/Network.h"
#include "../Json/jsonParser.h"

class Gen
{
public:
    Gen(Map&);
    void randomize(Network & net, jsonParser&);
    void move(Map& m,Network &net,jsonParser &jparse);

    Map map;

private:
};

#endif //IRL_GEN_H
