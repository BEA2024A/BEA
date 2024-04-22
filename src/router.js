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

import inicioPsico from './components/inicioPsico.vue';
import perfil from './components/perfil.vue';
import HorarioPsico from './components/HorarioPsico.vue';
import Notas from './components/Notas.vue';

import insertar_psicologos from './components/insertar_psicologos.vue';
import agregarAdministrador from './components/agregarAdministrador.vue';

import agradecimiento from './components/agradecimiento.vue';

import Materiales from './components/Materiales.vue';




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

  { path: '/ps1/:id', name: 'ps1', component: ps1, props: true },


  {path: '/inicioPsico', name: 'inicioPsico', component: inicioPsico},
  {path: '/perfil/:id', name: 'perfil', component: perfil, props: true},
  {path: '/HorarioPsico', name: 'HorarioPsico' , component: HorarioPsico},
  {path: '/Notas/:id', name: 'Notas', component: Notas, props: true},

  {path: '/insertar_psicologos', name: 'insertar_psicologos', component: insertar_psicologos},
  {path: '/agregarAdministrador', name: 'agregarAdministrador', component: agregarAdministrador},

  {path: '/agradecimiento', name: 'agradecimeinto', component:agradecimiento},

  {path:'/Materiales', name: 'materiales', component:Materiales},


];

const router = createRouter({
  history: createWebHistory(),
  routes
});


router.beforeEach((to, from, next) => {
  const rutasProtegidas = ['/horario', '/seguimiento', '/primeracita', '/FormsPrimeraCita', '/formsSeguimiento', '/inicioPsico'];
  const rutasAdministrativas = ['/agregarAdministrador', '/insertar_psicologos']; // Rutas exclusivas para el administrador
  const estadoAlmacenado = localStorage.getItem('vuex') ? JSON.parse(localStorage.getItem('vuex')) : null;

  // Determinar si el usuario está autenticado y su ID
  const usuarioEstaAutenticado = estadoAlmacenado && estadoAlmacenado.usuario && estadoAlmacenado.usuario.id;
  const idUsuario = estadoAlmacenado && estadoAlmacenado.usuario && estadoAlmacenado.usuario.id; 

  // Verificar acceso a rutas protegidas
  if (rutasProtegidas.includes(to.path) && !usuarioEstaAutenticado) {
    next('/InicioSesion');
  } else if (rutasAdministrativas.includes(to.path) && idUsuario !== '123456') {
    // Si intenta acceder a una ruta administrativa y no es el admin, redirigir a inicio 
    next('/InicioSesion');
  } else {
    next();
  }
});

export default router;





