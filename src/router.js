import { createRouter, createWebHistory } from 'vue-router';
import Inicio from './components/Inicio.vue';
import Autoayuda from './components/autoayuda.vue';
import PrimeraCita from './components/PrimeraCita.vue';
import Horario from './components/Horario.vue';
import FormsPrimeraCita from './components/FormsPrimeraCita.vue';
import Seguimiento from './components/Seguimiento.vue';
import InicioSesion from './components/InicioSesion.vue';
import formsSeguimiento from './components/formsSeguimiento.vue';
import register from './components/register.vue';

import ps1 from './components/perfiles/ps1.vue';
import perfil_alumno from './components/perfiles/perfil_alumno.vue';

import inicioPsico from './components/inicioPsico.vue';
import perfil from './components/perfil.vue';
import HorarioPsico from './components/HorarioPsico.vue';
import Notas from './components/Notas.vue';
import NotasLeer from './components/NotasLeer.vue';
import NotasCrear from './components/NotasCrear.vue';
import insertar_psicologos from './components/insertar_psicologos.vue';


const routes = [
  {path: '/', name: 'Inicio', component: Inicio},
  {path: '/autoayuda', name: 'autoayuda', component: Autoayuda},
  {path: '/PrimeraCita', name: 'PrimeraCita', component: PrimeraCita},
  {path: '/Horario', name: 'Horario' , component: Horario},
  {path: '/FormsPrimeraCita', name: 'FormsPrimeraCita', component: FormsPrimeraCita},
  
  {path: '/Seguimiento', name: '/Seguimiento', component: Seguimiento},
  {path: '/formsSeguimiento', name: '/formnsSeguimiento', component: formsSeguimiento},
  {path: '/InicioSesion', name: '/InicioSesion', component: InicioSesion},
  {path: '/register', name: '/register', component: register},

  {path: '/ps1', name: '/ps1', component: ps1},
  {path: '/perfil_alumno', name: '/perfil_alumno', component: perfil_alumno},

  {path: '/inicioPsico', name: '/inicioPsico', component: inicioPsico},
  {path: '/perfil', name: '/perfil', component: perfil},
  {path: '/HorarioPsico', name: 'HorarioPsico' , component: HorarioPsico},
  {path: '/Notas', name: 'Notas', component: Notas},
  {path: '/NotasLeer', name: 'NotasLeer', component: NotasLeer},
  {path: '/NotasCrear', name: 'NotasCrear', component: NotasCrear},
  {path: '/insertar_psicologos', name: 'insertar_psicologos', component: insertar_psicologos},

];

const router = createRouter({
  history: createWebHistory(),
  routes
});


router.beforeEach((to, from, next) => {
 
  const rutasProtegidas = ['/horario', '/perfil_alumno', '/seguimiento', '/primeracita','/FormsPrimeraCita', '/formsSeguimiento', '/inicioPsico'  ]; 
  const usuarioEstaAutenticado = localStorage.getItem('usuario'); 
  
  if (rutasProtegidas.includes(to.path) && !usuarioEstaAutenticado) {
   
    next('/InicioSesion');
  } else {
   
    next();
  }
});

export default router;





