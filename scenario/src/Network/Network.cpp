//
// Created by reyre on 18/05/18.
//

#include <boost/asio.hpp>
#include <boost/array.hpp>
#include <iostream>

#include "Network.h"

Network::Network(std::string h, int p, boost::asio::ip::tcp::socket &socket) : socket(socket)
{
    this->host = h;
    this->port = p;

    boost::asio::ip::tcp::endpoint endpoint(boost::asio::ip::address::from_string(this->host), this->port);

    this->socket.connect(endpoint);
}

void Network::send_s(std::string message)
{
    boost::array<char, 4096> buf;
    std::copy(message.begin(),message.end(),buf.begin());
    boost::system::error_code error;

    socket.write_some(boost::asio::buffer(buf, message.size()), error);
}

std::string Network::read_s()
{
    boost::array<char, 4096> buf;
    boost::system::error_code error;

    size_t len = this->socket.read_some(boost::asio::buffer(buf), error);

    if (error == boost::asio::error::eof)
    {
        std::cout << "Error" << std::endl;
        exit(0);
    }
    else if (error)
        throw boost::system::system_error(error);
    std::string res;
    std::copy(buf.begin(), buf.end(), std::back_inserter(res));
    return (res);
}

Network::~Network()
{
    this->socket.close();
}