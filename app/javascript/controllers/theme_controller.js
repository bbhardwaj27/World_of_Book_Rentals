import { Controller } from "stimulus"

// Toggles data-theme on <html> between "light" and "dark" and remembers the choice.
// The initial theme is applied by an inline script in the layout <head> to avoid a flash.
export default class extends Controller {
  static targets = [ "switch" ]

  connect() {
    this.switchTarget.checked = document.documentElement.getAttribute("data-theme") === "dark"
  }

  toggle() {
    const theme = this.switchTarget.checked ? "dark" : "light"
    document.documentElement.setAttribute("data-theme", theme)
    try { localStorage.setItem("theme", theme) } catch (e) {}
  }
}
