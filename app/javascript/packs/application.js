import "bootstrap";

import { loadDynamicBannerText } from '../components/banner';
import '../plugins/datepicker';
import '../plugins/dropzone';

if (document.querySelector(".field_search")) {
  loadDynamicBannerText();
}
