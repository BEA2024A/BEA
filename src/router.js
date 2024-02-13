import { createRouter, createWebHistory } from 'vue-router';
import Inicio from './components/Inicio.vue';
import Autoayuda from './components/autoayuda.vue';
import PrimeraCita from './components/PrimeraCita.vue';

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
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;