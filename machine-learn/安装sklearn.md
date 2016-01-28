1. if you have Python 2 you can install all these requirements by issuing:


sudo apt-get install build-essential python-dev python-setuptools \
                     python-numpy python-scipy \
                     libatlas-dev libatlas3gf-base

If you have Python 3:


sudo apt-get install build-essential python3-dev python3-setuptools \
                     python3-numpy python3-scipy \
                     libatlas-dev libatlas3gf-base

On recent Debian and Ubuntu (e.g. Ubuntu 13.04 or later) make sure that ATLAS is used to provide the implementation of the BLAS and LAPACK linear algebra routines:


sudo update-alternatives --set libblas.so.3 \
    /usr/lib/atlas-base/atlas/libblas.so.3
sudo update-alternatives --set liblapack.so.3 \
    /usr/lib/atlas-base/atlas/liblapack.so.3

Note  

In order to build the documentation and run the example code contains in this documentation you will need matplotlib:


sudo apt-get install python-matplotlib


2.pip install --user --install-option="--prefix=" -U scikit-learn

或者 sudo apt-get install python-sklearn

pip3 install -U scikit-learn

没有安装源码包，如有需求，参考官网installation。


3.nosetests -v sklearn  测试sklearn

