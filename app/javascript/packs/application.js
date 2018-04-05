import "bootstrap";

import { loadDynamicBannerText } from '../components/banner';
import '../plugins/datepicker';

if (document.querySelector(".field_search")) {
  loadDynamicBannerText();
}
