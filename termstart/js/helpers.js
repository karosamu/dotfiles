function getTime() {
    let date = new Date(),
        min = date.getMinutes(),
        hour = date.getHours();

    return (
        "" + (hour < 10 ? "0" + hour : hour) + ":" + (min < 10 ? "0" + min : min)
    );
}

window.onload = () => {
    document.getElementById("clock").innerHTML = getTime();

    setInterval(() => {
        document.getElementById("clock").innerHTML = getTime();
    }, 100);
};

function hideTerminal() {
    var terminal = document.getElementById("terminal-content");
    var titlebar = document.getElementById("titlebar")
    if (!terminal.classList.contains('closed')) {
        terminal.classList.add('closed')
        titlebar.classList.add('minimized')
        return
    }

    terminal.classList.remove('closed')
    titlebar.classList.remove('minimized')
}