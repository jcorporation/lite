"use strict";

const clickBoxes = document.getElementsByClassName('clickable');
for (const box of clickBoxes) {
    const link = box.getElementsByTagName('a')[0];
    if (link) {
        box.addEventListener('click', function(event) {
            link.dispatchEvent(event);
        }, false);
    }
}
