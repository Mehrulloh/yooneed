import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.test()
    }

    test() {
        console.log("Hello World")
    }
}