import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hidden", "results"]
  static values = { url: String }

  connect(){
    console.log("connect: this.element =", this.element)
    this.onDoClick = (e) => {
      if (!this.element.contains(e.target)) {
        console.log("e.target =", e.target)
        this.closeResults()
      }
    }
    document.addEventListener('click', this.onDoClick)
  }
  disconnect() {
    document.removeEventListener("click", this.onDoClick)
  }
  openResults() {
    this.resultsTarget.classList.remove('hidden')
  }
  closeResults() {
    this.resultsTarget.classList.add('hidden')
  }

  onInput() {
    const q = this.inputTarget.value.trim()
    if (q.length === 0) return

    const url = new URL(this.urlValue, window.location.origin)
    console.log(url)
    url.searchParams.set("keyword", q)

    fetch(url, { headers: { "Accept": "application/json" } })
      .then((res) => res.json())
      .then((items) => { this.renderList(items) })
      .catch((error) => { console.log("catch error:", error) })
  }

  renderList(items) {
    this.resultsTarget.innerHTML = ""
    if (!items || items.length === 0) return

    const frag = document.createDocumentFragment()
    items.forEach(item => {
      const li = document.createElement("li")
      li.className = "px-3 py-2 hover:bg-blue-100 cursor-pointer whitespace-nowrap overflow-hidden text-ellipsis"
      li.textContent = item.title
      li.addEventListener("click", () => this.choose(item))
      frag.appendChild(li)
    })
    this.resultsTarget.appendChild(frag)
  }

  choose(item) {
    this.inputTarget.value = item.title
  }
}