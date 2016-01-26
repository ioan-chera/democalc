#include "Demo.h"

Demo::Demo(const uint8_t *data, size_t size)
{
    if(size < 13)
        throw Exception() << "Invalid demo size " << size << " (must be at least 13)";

    mVersion = boundsChecked(data[0], 104, 110, "version");
    mSkill = boundsChecked(data[1], 0, 4, "skill");
    mEpisode = boundsChecked(data[2], 1, 4, "episode");
    mMap = boundsChecked(data[3], 1, 32, "map");
    mMultiRule = boundsChecked(data[4], 0, 2, "multiplayer rule");
    mRespawn = !!data[5];
    mFast = !!data[6];
    mNomonsters = !!data[7];
    mRecPlayer = boundsChecked(data[8], 0, 3, "recording player");

    mPlayers[0] = !!boundsChecked(data[9], 0, 1, "player 1 active");
    mPlayers[1] = !!boundsChecked(data[10], 0, 1, "player 2 active");
    mPlayers[2] = !!boundsChecked(data[11], 0, 1, "player 3 active");
    mPlayers[3] = !!boundsChecked(data[12], 0, 1, "player 4 active");

    mNumTics = (size - 13) / 4;
    mTics = new Tic[mNumTics];
    memcpy(mTics, data + 13, mNumTics * 4);
}

uint8_t Demo::boundsChecked(uint8_t value, uint8_t min, uint8_t max, const char *name)
{
    if(value < min || value > max)
        throw Exception() << "Invalid field " << name << " with value " << static_cast<int>(value) << " outside of range [" << static_cast<int>(min) << ", " << static_cast<int>(max) << "]";
    return value;
}