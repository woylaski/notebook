1、设置hugepage
 >cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 
 >或者 NUMA系统的
 >cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 cat /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages

 >echo 2048 >/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
 >或者NUMA系统的
 >echo 2048 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 echo 2048 > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages

 >cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 
 >或者NUMA系统的
 >cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 cat /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
 
 >mount -t hugetlbfs nodev /mnt/huge

2、释放hugepage
 >cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 
 >或者NUMA系统的
 >cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 cat /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages

 >echo0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 
 >或者NUMA系统的
 >echo 0 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 echo 0 > /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages

 >cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages 
 >或者NUMA系统的
 >cat /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
 cat /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages

 >umount /mnt/huge
