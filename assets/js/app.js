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

// highlight.min.js
import hljs from "../vendor/highlight.min.js"

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

// wire up theme selection UI
const lightThemeOption = document.getElementById('theme-option-light');
const darkThemeOption = document.getElementById('theme-option-dark');
const systemThemeOption = document.getElementById('theme-option-system');
const selectedOptionClass = 'bg-blue-600';

// Tailwind - support light mode, dark mode, as well as respecting the operating system preference:
// On page load or when changing themes, best to add inline in `head` to avoid FOUC
function updateTheme() {
    if ('theme' in localStorage && localStorage.theme === 'dark')
    {
        document.documentElement.classList.add('dark');
        // Indicate selected option
        indicate(darkThemeOption, [lightThemeOption, systemThemeOption], selectedOptionClass);
    }
    else if ('theme' in localStorage && localStorage.theme === 'light') {
        document.documentElement.classList.remove('dark');
        // Indicate selected option
        indicate(lightThemeOption, [darkThemeOption, systemThemeOption], selectedOptionClass);
    } else if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.classList.add('dark');
        // Indicate selected option
        indicate(systemThemeOption, [darkThemeOption, lightThemeOption], selectedOptionClass);
    } else {
        document.documentElement.classList.remove('dark');
        // Indicate selected option
        indicate(systemThemeOption, [darkThemeOption, lightThemeOption], selectedOptionClass);
    }
}

function indicate(selected, others, option) {
    selected.classList.add(option)
    others.forEach(element => {
        element.classList.remove(option)
    });
}

lightThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses light mode
    localStorage.theme = 'light';
    updateTheme();
});

darkThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses dark mode
    localStorage.theme = 'dark';
    updateTheme()
});

systemThemeOption.addEventListener('click', event => {
    // Whenever the user explicitly chooses to respect the OS preference
    localStorage.removeItem('theme');
    updateTheme();
});

// toggle the mobile menu visibility
const mobileMenuToggle = document.getElementById('mobile-menu-toggle');
const mobileMenu = document.getElementById('mobile-menu');
mobileMenuToggle.addEventListener('click', event => {
    // check visibility
    if (mobileMenu.classList.contains('hidden')) {
        mobileMenu.classList.remove('hidden');
    }
    else {
        mobileMenu.classList.add('hidden');
    }
});

// on page load, set theme
updateTheme();

// highlight js
window.addEventListener('DOMContentLoaded', (event) => {
    console.log('DOM fully loaded and parsed');
    hljs.highlightAll();
});