// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
// import {Socket} from "phoenix"
// import {LiveSocket} from "phoenix_live_view"
// import topbar from "../vendor/topbar"

// let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
// topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
// window.addEventListener("phx:page-loading-start", info => topbar.show())
// window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
// liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
// window.liveSocket = liveSocket

// Tailwind - support light mode, dark mode, as well as respecting the operating system preference:
// On page load or when changing themes, best to add inline in `head` to avoid FOUC
function updateTheme() {
    if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    } else {
        document.documentElement.classList.remove('dark');
    }
}

// wire up theme selection UI
const themeSelector = document.getElementById("theme-selector");
const lightThemeOption = document.getElementById("theme-option-light");
const darkThemeOption = document.getElementById("theme-option-dark");
const systemThemeOption = document.getElementById("theme-option-system");
const selectedTheme = document.getElementById("selected-theme");


// show the options when the dropdown is clicked
themeSelector.addEventListener('click', event => {
    // important not to propogate, otherwise the options will be hidden right away
    event.stopPropagation();
    document.getElementById('theme-options').classList.remove('invisible');
});

// hide the options on every other click event
document.addEventListener('click', event => {
    document.getElementById('theme-options').classList.add('invisible');
});

lightThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses light mode
    localStorage.theme = 'light';
    selectedTheme.innerText = 'Light';
    updateTheme();

});

darkThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses dark mode
    localStorage.theme = 'dark';
    selectedTheme.innerText = 'Dark';
    updateTheme()

});

systemThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses to respect the OS preference
    localStorage.removeItem('theme');
    selectedTheme.innerText = 'System';
    updateTheme();

});

// toggle the mobile menu visibility
const mobileMenuToggle = document.getElementById('mobile-menu-toggle');
const mobileMenu = document.getElementById('mobile-menu');
mobileMenuToggle.addEventListener('click', event => {
    // check visibility
    if (mobileMenu.classList.contains('hidden'))
    {
        mobileMenu.classList.remove('hidden');
    }
    else {
        mobileMenu.classList.add('hidden');
    }
});

// on page load, set theme
updateTheme();