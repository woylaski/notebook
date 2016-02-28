function printNode(node) {
    for (var i=0; i < node.length; i++) {
        printNode(node[i]);
    }
    if (node.length == undefined) {
        console.log(node.type, node.name);
    }
}

var menuTree = [
    [
        {
            "type": "conversation",
            "icon": "halle-berry.jpg",
            "name": "Halle Berry"
        },
        {
            "type": "conversation",
            "icon": "salma-hayek.jpg",
            "name": "Samla Hayek"
        }
    ],

    [
        {
            "type": "menu",
            "name": "contacts"
        },
        {
            "type": "menu",
            "name": "settings"
        }

    ]

]
