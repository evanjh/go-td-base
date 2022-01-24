# go-td-base

[go-tdlib](https://github.com/zelenin/go-tdlib) with docker.

```bash
apt-get update
apt-get upgrade
apt-get install make git zlib1g-dev libssl-dev gperf php-cli cmake g++
git clone https://github.com/tdlib/td.git
cd td
git checkout v1.8.0
rm -rf build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
cmake --build . --target install
```