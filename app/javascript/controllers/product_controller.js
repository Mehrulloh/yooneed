import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        // Call the set_status method when the controller connects
        this.set_status();
    }

    // Getter method for productId
    get productId() {
        return this.element.dataset.productId;
    }

    // Getter method for productStatus
    get productStatus() {
        return this.element.dataset.productStatus;
    }

    // Setter method for productStatus
    set productStatus(value) {
        this.element.dataset.productStatus = value;
    }

    // Method to set status and submit form
    set_status() {
        // Get the form element
        const form = this.element;
        // Log form for debugging
        console.log("Form:", form);

        // Get the submit button within the form
        const btn = form.querySelector("#submit");

        // Check if the submit button exists
        if (btn) {
            // If productStatus is null, set it to "accepted"
            if (this.productStatus === null) {
                this.productStatus = "accepted";
            }

            // Set the form ID
            form.id = this.productId;

            // Set the form status attribute
            form.dataset.productStatus = this.productStatus;

            // Submit the form
            form.submit();
        } else {
            console.error("Submit button element not found.");
        }
    }
}
