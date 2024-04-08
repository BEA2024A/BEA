<template>
  <div>
    <!-- Barra de Navegación -->
    <nav class="barra-navegacion">
      <!-- Logo -->
      <div class="logo">
        <router-link to="/inicioPsico" class="enlace-navegacion">
          <img src="https://i.ibb.co/TkHLsmX/anahuac-oaxaca.png" alt="Logo Anáhuac">
        </router-link>
      </div>

      <!-- Botón Hamburguesa para dispositivos móviles -->
      <div class="hamburguesa" @click="toggleMenu">
        <div class="linea"></div>
        <div class="linea"></div>
        <div class="linea"></div>
      </div>

      <!-- Secciones -->
      <div class="secciones-navegacion" :class="{ 'mostrar-menu': mostrarMenu }">
        <router-link to="/HorarioPsico" class="enlace-navegacion">Horarios</router-link>
        <router-link to="/insertar_psicologos" class="enlace-navegacion">agregar nuevo psicologo</router-link>
        <router-link to="/agregarAdministrador" class="enlace-navegacion">agregar nuevo administrador</router-link>  
      </div>
 
      <!-- Botón de Inicio de Sesión, solo visible si no hay usuario logueado -->
 <div class="boton-inicio-sesion" v-if="!usuario">
      <button @click="abrirEnlace('/iniciosesion')">
        <img src="https://cdn-icons-png.flaticon.com/512/58/58950.png" class="inicio-sesion-icono">
      </button>
    </div>
 
 <!-- Botón de Usuario Logueado y Menú Desplegable -->
<div v-if="usuario" class="usuario-menu-contenedor" @click="toggleUsuarioMenu" ref="menuUsuario">
  <div class="usuario-menu">
    <!-- Texto "Tu Perfil" al lado izquierdo de la imagen -->
    <div class="texto-usuario">{{ usuario.nombre }}</div>
    <img src="https://cdn-icons-png.flaticon.com/512/1361/1361728.png" alt="Usuario" class="icono-usuario">
  </div>
  <div class="menu-perfil">
  <div v-if="mostrarMenuUsuario" class="menu-usuario">
    <div class="opcion-menu" @click.stop="cerrarSesionYCerrarMenu">Cerrar sesión</div>
  </div>
</div>
</div>

    </nav>

    <!-- Contenido de la Página -->
    <slot></slot>

    <!-- Pie de Página -->
    <footer class="pie-pagina">
      <div class="contenido-pie">
        <!-- Imagen a la derecha -->
        <div class="derecha-pie">
          <img src="https://www.anahuac.mx/oaxaca/sites/default/files/img/Inicial.png" alt="Logo Anáhuac">
        </div>

        <!-- Información de contacto -->
        <div class="contacto-pie">
          <button class="boton-pie" @click="abrirMapa" target="_blank">
            <strong>Dirección:</strong> Blvd. Guadalupe Hinojosa de Murat No. 1100.<br>San Raymundo Jalpan, Oaxaca C.P. 71248.
          </button>
          <p><strong>Teléfono:</strong> (951) 50-1-62-50<br>Lada sin costo: 800-737-26-24<br>E-mail: orientacionpsicologica.uao@anahuac.mx</p>
        </div>

        <!-- Enlaces a Aviso de Privacidad y Compendio Reglamentario como botones -->
        <div class="botones-pie">
          <button v-for="(enlace, texto) in enlacesPie" :key="texto" class="boton-pie" @click="abrirEnlace(enlace)">{{ texto }}</button>
        </div>

        <!-- Botones de redes sociales como botones -->
        <div class="botones-sociales-pie">
          <button v-for="(botonSocial, index) in botonesSociales" :key="index" class="boton-pie" @click="abrirEnlace(botonSocial.enlace)" target="_blank">
            <img :src="botonSocial.icono" alt="Icono de red social">
          </button>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';

export default {
  data() {
    return {
      mostrarMenu: false,
      mostrarMenuUsuario: false,
      botonesSociales: [
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redFacebook_1.png', enlace: 'https://www.facebook.com/anahuacoaxaca/' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redInstagram.png', enlace: 'https://www.instagram.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redTwitter.png', enlace: 'https://twitter.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redYoutube.png', enlace: 'https://www.youtube.com/channel/UCk5xAk91c-F_lNKn6ceDVZQ' },
      ],
      enlacesPie: {
        'Aviso de Privacidad': 'https://www.anahuac.mx/oaxaca/aviso-privacidad',
        'Compendio Reglamentario': 'https://www.anahuac.mx/oaxaca/compendio-reglamentario',
      },
    };
  },
  computed: {
    ...mapGetters(['usuario']),
    
    urlRedireccion() {
      return this.usuario ? '/perfil_alumno' : '/iniciosesion';
    }
  },

  mounted() {
    // Añade el listener cuando el componente se monta
    document.addEventListener('click', this.handleOutsideClick);
  },
  beforeDestroy() {
    // Remueve el listener cuando el componente se destruya
    document.removeEventListener('click', this.handleOutsideClick);
  },

  methods: {
    abrirEnlaceUsuario() {
      if (this.usuario) {
        window.location.href = this.urlRedireccion;
      } else {
        // Si no hay usuario logueado, redirige a la página de inicio de sesión
        this.$router.push(this.urlRedireccion);
      }
    },
    ...mapActions(['cerrarSesion']), 
    abrirMapa() {
      window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
    },
    abrirEnlace(url) {
      if (url === '/iniciosesion') {
        this.abrirEnlaceUsuario();
      } else {
        window.location.href = url;
      }
    },
    toggleMenu() {
      this.mostrarMenu = !this.mostrarMenu;
    },
    toggleUsuarioMenu() {
      this.mostrarMenuUsuario = !this.mostrarMenuUsuario;
    },
    handleOutsideClick(e) {
      
      const menuUsuario = this.$refs.menuUsuario;
      
      if (menuUsuario && !menuUsuario.contains(e.target) && !e.target.classList.contains('icono-usuario') && !e.target.classList.contains('texto-usuario')) {
        this.mostrarMenuUsuario = false;
      }
    },
    cerrarSesionYCerrarMenu() {
      this.cerrarSesion(); 
      this.mostrarMenuUsuario = false;
    },
  },
};
</script>


<style scoped>

@keyframes slideIn {
  from {
    opacity: 1;
    transform: translateY(-5px); 
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/*BARRA */

.barra-navegacion {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  background-color: black;
  color: white;
}

.logo img {
  max-height: 40px;
}

.hamburguesa {
  display: none;
  cursor: pointer;
}

.linea {
  height: 3px;
  width: 25px;
  background-color: white;
  margin: 6px 0;
}


.secciones-navegacion {
    display: flex;
  }

  .enlace-navegacion {
    margin-right: 30px;
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
    padding-left: 30px;
    padding-right: 30px;
    padding-top: 18px;
    padding-bottom: 18px;
  }

  .enlace-navegacion:hover {
    color:#d45c37;
  }

/* BOTONES */
  .boton-inicio-sesion{
    margin-right: 30px;
    transition: color 0.3s ease;
  } 

.inicio-sesion-icono{
  width: 25px;
  filter:invert(50%);
  transition: color 0.3s ease;
}

  .usuario-menu {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  position: relative;
  cursor: pointer;
}

.usuario-menu-contenedor {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  position: relative;
  cursor: pointer;
  margin-right: 20px;
}

.usuario-menu-contenedor:hover .texto-usuario,
.usuario-menu-contenedor:hover .icono-usuario {
  filter: invert(0.5) saturate(0); 
}

.texto-usuario {
  color: white; 
  margin-right: 10px; 
  font-weight: bold; 
  transition: 0.3s ease;
 
}

.icono-usuario {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  filter: invert(1);
  transition: filter 0.3s ease;
}


.menu-usuario {
  position: absolute;
  right: 0;
  top: 100%;
  background-color: white;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  width: 150px;
  z-index: 10;
  text-align: left;
  color: #000000;
  animation: slideIn 0.3s ease forwards;
  margin-top:17px ;
}


.opcion-menu {
  padding: 10px;
  cursor: pointer;
  transition: 0.3s ease;
}

.opcion-menu:hover {
  background-color: #00000046;
  color: #f0f0f0;
  
}

/* PIE DE PAGINA */

.pie-pagina {
  background-color: black;
  color: white;
  padding: 30px;
}
.contenido-pie {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}

.derecha-pie img {
  max-height: 80px;
}
.contacto-pie p {
  margin: 10px;
}
.botones-pie {
  display: flex;
  flex-direction: column;
}
.boton-pie {
  background-color: #000000;
  color: white;
  border: none;
  text-align: center;
  cursor: pointer;
  border-radius: 5px;
  margin-bottom: 10px;
}
.botones-sociales-pie img {
  max-height: 35px;
  margin-right: 5px;
}
.botones-sociales-pie button {
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}




/* RESPONSIVIDAD*/


@media (max-width: 639px) {
  .contenido-pie {
    flex-direction: column;
    align-items: center;
  }



  .enlace-navegacion,
  .usuario-menu-contenedor {
    margin: 10px 0;
  }

  .hamburguesa {
    display: block;
    order: -1;
  }



  .logo img {
  max-height: 30px;
  transform: translateX(10px)
}

  .secciones-navegacion {
    display: none;
    flex-direction: column;
    background-color:#030303 ;
    position: absolute;
    top: 75px;
    left: 0;
    width: 100%;
    z-index: 99;
    animation: slideIn 0.5s ease forwards;
    align-items: center;

  }

  .mostrar-menu {
    display: flex;
  }

  .usuario-menu {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  position: relative;
  cursor: pointer;
}
/*******/

.boton-inicio-sesion{

    transition: color 0.3s ease;
  } 

.inicio-sesion-icono{
  width: 25px;
  filter:invert(50%);
  transition: color 0.3s ease;
}



/** */
.usuario-menu-contenedor {
  justify-content: center;
}

.usuario-menu-contenedor:hover .texto-usuario,
.usuario-menu-contenedor:hover .icono-usuario {
  filter: invert(0.5) saturate(0); 
}



.icono-usuario {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  filter: invert(1);
  transition: filter 0.3s ease;
  transform: translateX(-20px);
}


.menu-usuario {
  position: absolute;
  right: 0;
  top: 100%;
  background-color: white;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  width: 150px;
  z-index: 10;
  text-align: left;
  color: #000000;
  animation: slideIn 0.3s ease forwards;
  margin-top:17px ;
}

.texto-usuario{
    display: none;
}


.opcion-menu {
  padding: 10px;
  cursor: pointer;
  transition: 0.3s ease;
}

.opcion-menu:hover {
  background-color: #00000046;
  color: #f0f0f0;
  
}


}





</style>

