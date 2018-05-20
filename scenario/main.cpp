//
// Created by reyre on 16/05/18.
//

#include <sstream>

#include "src/Loop.h"
#include "src/Network/Network.h"

int main(int ac, char **av)
{
    Loop mainLoop;

    if (ac == 4)
    {
        std::string host(av[1]);
        int port = atoi(av[2]);

        Network net(host, port);

        mainLoop.run(net);
    }
    else
    {
        std::cout << "./scenario <host> <port> <map>" << std::endl;
        return(-1);
    }
    return (1);
}