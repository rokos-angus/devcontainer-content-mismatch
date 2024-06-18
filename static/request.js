function requestLargePayload() {
    fetch("/data").then(x => x.json()).then(x => console.log(x.length))
}