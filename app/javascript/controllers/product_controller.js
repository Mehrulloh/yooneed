import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["statusProduct"];

    connect() {

    }

    order(e) {
        const value = e.target.value
        console.log(value)
    }
}
