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
    this.savedCount = parseInt(this.countTarget.textContent)
    this.savedLiked = this.likedValue

    this.countTarget.textContent = this.savedCount + (this.likedValue ? -1 : 1)
    this._setStarState(!this.likedValue)
    this.likedValue = !this.likedValue
  }

  revert() {
    if (this.savedCount === undefined) return
    this.countTarget.textContent = this.savedCount
    this._setStarState(this.savedLiked)
    this.likedValue = this.savedLiked
  }

  _setStarState(liked) {
    const img = this.element.querySelector("img")
    if (!img) return
    if (liked) {
      img.src = img.src.replace("star-line", "star-fill")
    } else {
      img.src = img.src.replace("star-fill", "star-line")
    }
  }
}
