FROM golang:1.16-buster

# Define working directory.
WORKDIR /go/src/td

ENV CXXFLAGS="-stdlib=libc++"
ENV CC="/usr/bin/clang"
ENV CXX="/usr/bin/clang++"
ADD ./sources.list /etc/apt/sources.list.save
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak \
    && mv /etc/apt/sources.list.save /etc/apt/sources.list

# 安装软件包
RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    cron \
    git \
    curl \
	# td
	make zlib1g-dev libssl-dev gperf cmake clang libc++-dev libc++abi-dev \
	# supervisor
    python-pip \
    rsyslog \
    && rm -rf /var/lib/apt/lists/* \
	&& [ -f "/etc/apt/sources.list.bak" ] && mv /etc/apt/sources.list.bak /etc/apt/sources.list; \
    pip install -U setuptools supervisor; \
    go version;

# 拷贝代码
ADD ./td /go/src/td

# 编译项目
RUN cd /go/src/td; \
	rm -rf .git; \
	rm -rf build; \
	mkdir build; \
	cd build; \
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..; \
	cmake --build . --target install
