import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('.field_search', {
    strings: ["Procurando Animação de Festas de crianças?", "Procurando Wedding Planner?", "Procurando Banda?", "Procurando Bartender?", "Procurando Brindes e lembrancinhas?", "Procurando Buffet completo?", "Procurando Churrasqueiro?", "Procurando Decoração?", "Procurando Djs?", "Procurando Fotografo?", "Procurando Garçons e Copeiras?", "Procurando Segurança?"],
    typeSpeed: 50,
    attr: 'placeholder',
    loop: true,
    smartBackspace: true,
    backSpeed: 80,
  });
}

export { loadDynamicBannerText };
