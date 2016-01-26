#ifndef __democalc__Demo__
#define __democalc__Demo__

#include <sstream>
#include <stdlib.h>
#include <string>

class Demo
{
public:

    struct Tic
    {
        int8_t go, strafe, turn;
        uint8_t use;
    };

    class Exception
    {
    public:
        std::string message() const { return mStream.str(); }

        template <typename T> Exception& operator << (T stuff)
        {
            mStream << stuff;
            return *this;
        }

        Exception() = default;

        Exception(Exception &moved) : mStream(std::move(moved.mStream))
        {
        }

    private:
        std::ostringstream mStream;
    };

    Demo(const uint8_t *data, size_t size);
    ~Demo()
    {
        delete []mTics;
    }

    Tic operator[] (size_t index) const
    {
        if(index >= mNumTics)
            throw Exception() << "Index " << index << " out of bounds (size is " << mNumTics << ")";
        return mTics[index];
    }

private:

    int mVersion, mSkill, mEpisode, mMap, mMultiRule;
    bool mRespawn, mFast, mNomonsters;
    int mRecPlayer;
    bool mPlayers[4];

    Tic *mTics;
    size_t mNumTics;

    static uint8_t boundsChecked(uint8_t value, uint8_t min, uint8_t max, const char *name);
};

#endif /* defined(__democalc__Demo__) */
