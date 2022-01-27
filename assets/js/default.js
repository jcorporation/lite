"use strict";

// clickable event handler
const clickBoxes = document.getElementsByClassName('clickable');
for (const box of clickBoxes) {
    const link = box.getElementsByTagName('a')[0];
    if (link) {
        box.addEventListener('click', function() {
            link.click();
        }, false);
    }
}

// horizontal scrollable tables
const tables = document.getElementsByTagName('table');
for (const table of tables) {
    const div = document.createElement('div');
    div.classList.add('table-responsive');
    table.parentNode.insertBefore(div, table);
    div.appendChild(table);
}
