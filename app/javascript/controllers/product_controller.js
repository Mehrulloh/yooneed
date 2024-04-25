import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["status"];

    connect() {
        console.log(this.productId)
    }

    get productId() {
        return (this.element).dataset
    }

    order(e) {
        const value = e.target.value
        console.log(value)
    }
}
