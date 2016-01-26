## 在内核启动时保留内存和cpu

### 设置hugepage内存
- 保留1024个2MB的hugepage
  添加kernel启动参数
  >hugepages=1024

- 设置每个hugepage 1GB大小,保留4个hugepage
  >default_hugepagesz=1G hugepagesz=1G hugepages=4
 
### 让cpu不参与系统调度
  添加内核启动参数
  >isolcpus=2,4,6