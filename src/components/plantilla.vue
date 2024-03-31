<template>
  <div>
    <!-- Barra de Navegación -->
    <nav class="barra-navegacion">
      <!-- Logo -->
      <div class="logo">
        <router-link to="/" class="enlace-navegacion">
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
        <router-link to="/primeracita" class="enlace-navegacion">Primera Cita</router-link>
        <router-link to="/seguimiento" class="enlace-navegacion">Seguimiento</router-link>
        <router-link to="/horario" class="enlace-navegacion">Calendario</router-link>
        <router-link to="/autoayuda" class="enlace-navegacion">Autoayuda</router-link>

        <router-link to="/inicioPsico" class="enlace-navegacion">Inicio Psicologos</router-link>
      </div>
 <!-- Botón de Inicio de Sesión, solo visible si no hay usuario logueado -->
 <div class="boton-inicio-sesion" v-if="!usuario">
      <button @click="abrirEnlace('/iniciosesion')">Iniciar sesión</button>
    </div>
 
  <!-- Botón de Usuario Logueado y Menú Desplegable -->
<div v-if="usuario" class="usuario-menu">
  <img src="https://cdn-icons-png.flaticon.com/512/1361/1361728.png" alt="Usuario" class="icono-usuario" @click="toggleUsuarioMenu">
  <div v-if="mostrarMenuUsuario" class="menu-usuario">
    <div class="saludo">¡Hola {{ usuario.nombre }}!</div>
    <div class="opcion-menu" @click="abrirEnlace('/perfil_alumno')">Ver perfil</div>
    <div class="opcion-menu" @click="cerrarSesionYCerrarMenu">Cerrar sesión</div>
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
    textoBoton() {
      return this.usuario ? `Hola ${this.usuario.nombre}` : 'Iniciar sesión';
    },
    urlRedireccion() {
      return this.usuario ? '/ps1' : '/iniciosesion';
    }
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
    ...mapActions(['cerrarSesion']), // Mapea la acción de cerrar sesión desde Vuex
    abrirMapa() {
      window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
    },
    abrirEnlace(url) {
      // Modifica este método para manejar la redirección del botón de inicio de sesión
      // basado en si hay un usuario logueado o no
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
    cerrarSesionYCerrarMenu() {
      this.cerrarSesion(); // Acción de Vuex para cerrar sesión
      this.mostrarMenuUsuario = false; // Oculta el menú
    },
  },
};
</script>


<style scoped>
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


.usuario-menu {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  position: relative;
}

.icono-usuario {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  cursor: pointer;
  filter: invert(1);
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
}

.saludo {
  padding: 10px;
  margin-bottom: 5px;
  border-bottom: 1px solid #f0f0f0;
}

.opcion-menu {
  padding: 10px;
  cursor: pointer;
  transition: 0.3s ease;
}

.opcion-menu:hover {
  background-color: #ff5900;
  color: #f0f0f0;
}


@media only screen and (max-width: 600px) {
 .hamburguesa {
    display: block;
  }

  .secciones-navegacion {
    display: none;
    flex-direction: column;
    background-color: black;
    position: absolute;
    top: 60px;
    left: 0;
    width: 100%;
    z-index: 1;
  }

  .mostrar-menu {
    display: flex;
  }

  .enlace-navegacion {
    margin-right: 0;
    padding: 10px;
    text-align: center;
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
  }

  .enlace-navegacion:hover {
    color: #d45c37;
  }

  .boton-inicio-sesion {
    order: -1;
  }

  .boton-inicio-sesion button {
    background-color: #d45c37;
    color: white;
    border: none;
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }

  .boton-inicio-sesion button:hover {
    background-color: #a03722;
  }

  .logo img {
  max-height: 30px;
}
}

@media (min-width: 769px) {
  .hamburguesa {
    display: none;
  }

  .secciones-navegacion {
    display: flex;
  }

  .enlace-navegacion {
    margin-right: 30px;
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
  }
  .enlace-navegacion:hover {
    color: #d45c37;
  }
  .boton-inicio-sesion button {
    background-color: #d45c37;
    color: white;
    border: none;
    padding: 10px 15px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease;
  }
  .boton-inicio-sesion button:hover {
    background-color: #a03722;
  }
}
.contenido-pagina {
  padding: 10px;
}
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
@media (max-width: 768px) {
  .contenido-pie {
    flex-direction: column;
  }
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

@media only screen and (max-width: 600px) {
  
}
</style>