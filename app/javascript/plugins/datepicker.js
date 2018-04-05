import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";

flatpickr(".datepicker", {
  enableTime: true,
  dateFormat: "d/m/Y H:i",
});
