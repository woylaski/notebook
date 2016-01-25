##左儿子右兄弟表示法

###简介

树的左儿子右兄弟（left son，right sibling）表示法又称为二叉树表示法或二叉链表表示法。每个结点除了data域外，还含有两个域，分别指向该结点的最左儿子和右邻兄弟。这种表示法常用二叉链表实现，因此又称为二叉链表表示法。但是实际应用中常用游标(静态链表)来代替链表。

对于普通情况下的树，我们会采用儿子节点法来存储，如下图

![tree-son](E:\dpdk\code0.2\superpm\doc\tree-son-store.png)

但在trie中，往往采用左儿子右兄弟的存储法更为快速，左儿子右兄弟就是说在树中每个结点有两个指针结点，一个指向其儿子，一个指向其兄弟。
如下图所示

![tree-left-son-right-sibling](E:\dpdk\code0.2\superpm\doc\left-son-right-sibling.png)

