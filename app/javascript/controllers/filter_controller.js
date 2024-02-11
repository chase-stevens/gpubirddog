import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "filterable" ]

  toggleConditionFilter(event) {
    if (event.target.checked) {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.condition == el.dataset.condition) {
          el.hidden = false
        }
      })
    }
    else {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.condition == el.dataset.condition) {
          el.hidden = true
        }
      })
    }
  }

  toggleChipFilter(event) {
    if (event.target.checked) {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.chip == el.dataset.chip) {
          el.hidden = false
        }
      })
    }
    else {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.chip == el.dataset.chip) {
          el.hidden = true
        }
      })
    }
  }

  toggleManufacturerFilter(event) {
    if (event.target.checked) {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.manufacturer == el.dataset.manufacturer) {
          el.hidden = false
        }
      })
    }
    else {
      this.filterableTargets.forEach(el => {
        if (event.target.dataset.manufacturer == el.dataset.manufacturer) {
          el.hidden = true
        }
      })
    }
  }

  setPriceFloorFilter(event) {
    if (event.target.value) {
      this.filterableTargets.forEach(el => {
        if (parseInt(event.target.value) > parseFloat(el.dataset.price)) {
          el.hidden = true;
        }
        else {
          el.hidden = false;
        }
      })
    }
    else {
      this.filterableTargets.forEach(el => {
        el.hidden = false;
      })
    }
  }

  setPriceCeilingFilter(event) {
    if (event.target.value) {
      this.filterableTargets.forEach(el => {
        if (event.target.value < el.dataset.price) {
          el.hidden = true
        }
      })
    }
    else {
      this.filterableTargets.forEach(el => {
        if (event.target.value < el.dataset.price) {
          el.hidden = false
        }
      })
    }
  }
}