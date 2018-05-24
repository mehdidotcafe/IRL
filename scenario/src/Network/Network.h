//
// Created by reyre on 18/05/18.
//

#ifndef IRL_NETWORK_H
#define IRL_NETWORK_H

#include <boost/asio.hpp>
#include <boost/array.hpp>
#include <iostream>

class Network
{
public:
    Network(std::string h, int p, boost::asio::ip::tcp::socket &socket);
    ~Network();

    void send_s(std::string message);
    std::string read_s();

private:
    std::string host;
    int port;
    boost::asio::ip::tcp::socket &socket;
};

#endif //IRL_NETWORK_H
