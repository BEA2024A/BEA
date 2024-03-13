import { createRouter, createWebHistory } from 'vue-router';
import Inicio from './components/Inicio.vue';
import Autoayuda from './components/autoayuda.vue';
import PrimeraCita from './components/PrimeraCita.vue';
import Horario from './components/Horario.vue';
import FormsPrimeraCita from './components/FormsPrimeraCita.vue';
import Ansiedad from './components/Ansiedad.vue';
import Depresion from './components/Depresion.vue';
import Estres from './components/Estres.vue';
import FatigaMental from './components/FatigaMental.vue';
import Seguimiento from './components/Seguimiento.vue';
import InicioSesion from './components/InicioSesion.vue';
import formsSeguimiento from './components/formsSeguimiento.vue';
import contraseña from './components/contraseña.vue';
import register from './components/register.vue';
import ps1 from './components/psicologos/ps1.vue';

import inicioPsico from './components/inicioPsico.vue';
import perfil from './components/perfil.vue';


const routes = [
  {path: '/', name: 'Inicio', component: Inicio},
  {path: '/autoayuda', name: 'autoayuda', component: Autoayuda},
  {path: '/PrimeraCita', name: 'PrimeraCita', component: PrimeraCita},
  {path: '/Horario', name: 'Horario' , component: Horario},
  {path: '/FormsPrimeraCita', name: 'FormsPrimeraCita', component: FormsPrimeraCita},
  {path: '/Ansiedad', name: 'Ansiedad', component: Ansiedad},
  {path: '/Estres', name: 'Estres', component: Estres},
  {path: '/Depresion', name: 'Depresion', component: Depresion},
  {path: '/FatigaMental', name: 'FatigaMental', component: FatigaMental },
  {path: '/Seguimiento', name: '/Seguimiento', component: Seguimiento},
  {path: '/formsSeguimiento', name: '/formnsSeguimiento', component: formsSeguimiento},
  {path: '/InicioSesion', name: '/InicioSesion', component: InicioSesion},
  {path: '/contraseña', name: '/contraseña', component: contraseña},
  {path: '/register', name: '/register', component: register},
  {path: '/ps1', name: '/ps1', component: ps1},

  {path: '/inicioPsico', name: '/inicioPsico', component: inicioPsico},
  {path: '/perfil', name: '/perfil', component: perfil},

];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;
