import { createRouter, createWebHistory } from 'vue-router';
import Inicio from './components/Inicio.vue';
import Autoayuda from './components/autoayuda.vue';
import PrimeraCita from './components/PrimeraCita.vue';
import Horario from './components/Horario.vue';
import FormsPrimeraCita from './components/FormsPrimeraCita.vue';
import Seguimiento from './components/Seguimiento.vue';

const routes = [
  {
    path: '/',
    name: 'Inicio',
    component: Inicio
  },
  {
    path: '/autoayuda',
    name: 'autoayuda',
    component: Autoayuda,
  },
  {
    path: '/PrimeraCita',
    name: 'PrimeraCita',
    component: PrimeraCita,
  },
  {
    path: '/Horario',
    name: 'Horario',
    component: Horario,

  },
  {
    path: '/FormsPrimeraCita',
    name: 'FormsPrimeraCita',
    component: FormsPrimeraCita,
  },
  {
    path: '/Seguimiento',
    name: 'Seguimiento',
    component: Seguimiento,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
