#pragma once

#include "LidarDriver.h"

#ifndef RPLIDAR_MAXSAMPLES
#define RPLIDAR_MAXSAMPLES 8192
#endif

class RPLidar : public LidarDriver {
public:

    RPLidar();
    virtual ~RPLidar();

    bool        connect(const char* _portName, bool _verbose);
    void        disconnect();

    bool        printFirmware();

    bool        start(bool _verbose);
    bool        stop(bool _verbose);

    bool        getSamples(LidarSample* _samples, size_t& _count);

protected:
    void*  m_driver;
};