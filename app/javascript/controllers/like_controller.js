import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["count"]
  static values  = { liked: Boolean }

  connect() {
    this.element.addEventListener("turbo:fetch-request-error", this.revert.bind(this))
  }

  disconnect() {
    this.element.removeEventListener("turbo:fetch-request-error", this.revert.bind(this))
  }

  optimistic() {
    this.savedHTML = this.element.innerHTML
    const delta = this.likedValue ? -1 : 1
    this.countTarget.textContent = parseInt(this.countTarget.textContent) + delta
    const img = this.element.querySelector("img")
    if (img.src.includes("star-fill")) {
      img.src = img.src.replace("star-fill", "star-line")
    } else {
      img.src = img.src.replace("star-line", "star-fill")
    }
  }

  revert() {
    if (this.savedHTML) this.element.innerHTML = this.savedHTML
  }
}
