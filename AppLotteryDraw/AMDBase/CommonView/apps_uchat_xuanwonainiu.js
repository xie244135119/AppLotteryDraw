

function __yl_loadScript(url) {
    var doc = document
    var script = document.createElement('script')
    var firstScript = document.getElementsByTagName('script')[0]
    script.src = url
    firstScript.parentNode.insertBefore(script, firstScript)
}
