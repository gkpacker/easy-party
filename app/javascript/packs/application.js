import "bootstrap";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { loadDynamicBannerText } from '../components/banner';

if (document.querySelector(".field_search")) {
  loadDynamicBannerText();
}

flatpickr(".datepicker", {
  enableTime: true,
  dateFormat: "d-m-Y H:i",
});
