//
// Created by reyre on 16/05/18.
//

#include <sstream>
#include <boost/asio.hpp>
#include <boost/array.hpp>
#include <iostream>

#include "src/Loop.h"
#include "src/Network/Network.h"

int main(int ac, char **av)
{
    Loop mainLoop;

    if (ac == 6)
    {
        std::string host(av[1]);
        std::string map(av[3]);
        int port = atoi(av[2]);

        boost::asio::io_service ios;
        boost::asio::ip::tcp::socket socket(ios);

        Network net(host, port, socket);

        mainLoop.run(net, atoi(av[4]), map, atoi(av[5]));
    }
    else
    {
        std::cout << "./scenario <host> <port> <map> <nbr_street> <nbr_sensor>" << std::endl;
        return(-1);
    }
    return (1);
}