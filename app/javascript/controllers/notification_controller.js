import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
       if (!this.isPreview) {
            setTimeout(() => {
                this.element.classList.remove('hidden')
                this.element.classList.add('transform', 'ease-out',
                    'duration-300',
                    'transition-y-2',
                    'opacity-0',
                    'sm:transition-y-0',
                    'sm:transition-x-2')

                setTimeout(() => {
                    this.element.classList.add('translate-y-0','opacity-100', 'sm:translate-x-0')
                },100)
            }, 100)
       }

       setTimeout(() => {
           // this.close()
       },3000)

    }

    close() {
        this.element.classList.remove('transform', 'ease-out',
            'duration-300',
            'transition-y-2',
            'opacity-0',
            'sm:transition-y-0',
            'sm:transition-x-2')

        this.element.classList.add('ease-in', 'duration-100')

        setTimeout(() => {
            this.element.classList.add('opacity-y-0')
        },100)

        setTimeout(() => {
            this.element.remove()
        },300)
    }

    get isPreview() {
        return document.documentElement.hasAttribute("data-turbolinks-preview")
    }
}
