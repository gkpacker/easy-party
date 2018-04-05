import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
require("flatpickr/dist/themes/airbnb.css");
const Portuguese = require("flatpickr/dist/l10n/pt.js").default.pt;

flatpickr(".datepicker", {
  enableTime: true,
  altInput: true,
  altFormat: "j F, Y",
  dateFormat: "d/m/Y H:i",
  minDate: "today",
  "locale": Portuguese
});
