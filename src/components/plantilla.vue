<template>
<div>
  <div v-if="mostrarModal" class="modal">
  <div class="modal-contenido">
    <!-- Botón para cerrar el modal -->
    <button class="cerrar-modal" @click="mostrarModal = false">X</button> <!-- Movido aquí -->
    <!-- Título del modal -->
    <h3 class="titulo-modal">Cambiar foto</h3>
    <!-- Opción para subir una foto nueva -->
    <div class="subir-foto">
      <label for="input-foto" class="subir-foto-label">+ Subir una foto nueva</label>
      <input type="file" id="input-foto" @change="handleFileChange" accept="image/*" style="display: none;">
    </div>
    <!-- Vista previa de la imagen -->
    <div class="vista-previa">
      <img v-if="!imagenSeleccionada" :src="usuario.foto_perfil" alt="Vista previa de la imagen" class="icono-usuario-modal">

      <img v-if="imagenSeleccionada" :src="imagenSeleccionada" alt="Vista previa de la imagen" class="icono-usuario-modal">
    </div>
    <!-- Botón para cancelar -->
    <button class="boton-cancelar" @click="mostrarModal = false" v-if="!imagenSeleccionada">Cancelar</button>
    <!-- Botón para aplicar los cambios -->
    <button class="boton-aplicar" @click="aplicarCambios" v-if="imagenSeleccionada">Aplicar</button>
  </div>
</div>



    <!-- Barra de Navegación -->
    <nav class="barra-navegacion">
      <!-- Logo -->
      <div class="logo">
        <router-link to="/" class="enlace-navegacion">
          <img src="https://i.ibb.co/TkHLsmX/anahuac-oaxaca.png" alt="Logo Anáhuac" />
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
      </div>

      <!-- Botón de Inicio de Sesión, solo visible si no hay usuario logueado -->
      <div class="boton-inicio-sesion" v-if="!usuario">
        <button @click="abrirEnlace('/iniciosesion')">
          <img src="https://cdn-icons-png.flaticon.com/512/58/58950.png" class="inicio-sesion-icono" />
        </button>
      </div>

      <!-- Botón de Usuario Logueado y Menú Desplegable -->
      <div v-if="usuario" class="usuario-menu-contenedor" @click="toggleUsuarioMenu" ref="menuUsuario">
  <div class="usuario-menu">
    <!-- Texto "Tu Perfil" al lado izquierdo de la imagen -->
    <div class="texto-usuario">{{ usuario.nombre }}</div>

    <img :src="usuario.foto_perfil" alt="Usuario" class="icono-usuario" :key="usuario.foto_perfil" />
          <!-- Mostrar notificaciones aquí -->
          <div class="notificaciones-contenedor">
            <div class="notificaciones" :style="{ backgroundColor: numNotificaciones === 0 ? 'grey' : 'red' }">{{
        numNotificaciones }} </div>
          </div>
        </div>
        <div class="menu-perfil">
          <div v-if="mostrarMenuUsuario" class="menu-usuario">
            <div class="notificacion-menu" v-if="notificaciones.length > 0"
              v-for="(notificacion, index) in notificaciones" :key="index" @click="eliminarNotificacion(index)">
              {{ notificacion }}
            </div>
            <div v-else class="texto-menu">No hay nuevas notificaciones.</div>
            <div class="opcion-menu" @click.stop="abrirModal">
              Subir imagen de perfil
            </div>
            <div class="opcion-menu" @click.stop="cerrarSesionYCerrarMenu">
              Cerrar sesión
            </div>
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
          <img src="https://www.anahuac.mx/oaxaca/sites/default/files/img/Inicial.png" alt="Logo Anáhuac" />
        </div>

        <!-- Información de contacto -->
        <div class="contacto-pie">
          <button class="boton-pie" @click="abrirMapa" target="_blank">
            <strong>Dirección:</strong> Blvd. Guadalupe Hinojosa de Murat No.
            1100.<br />San Raymundo Jalpan, Oaxaca C.P. 71248.
          </button>
          <p>
            <strong>Teléfono:</strong> (951) 50-1-62-50<br />Lada sin costo:
            800-737-26-24<br />E-mail: orientacionpsicologica.uao@anahuac.mx
          </p>
        </div>

        <!-- Enlaces a Aviso de Privacidad y Compendio Reglamentario como botones -->
        <div class="botones-pie">
          <button v-for="(enlace, texto) in enlacesPie" :key="texto" class="boton-pie" @click="abrirEnlace(enlace)">
            {{ texto }}
          </button>
        </div>

        <!-- Botones de redes sociales como botones -->
        <div class="botones-sociales-pie">
          <button v-for="(botonSocial, index) in botonesSociales" :key="index" class="boton-pie"
            @click="abrirEnlace(botonSocial.enlace)" target="_blank">
            <img :src="botonSocial.icono" alt="Icono de red social" />
          </button>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import axios from "axios";

export default {
  data() {
    return {
      mostrarModal: false,
      imagenSeleccionada: null,
      imagenParaEnviar: null,
      mostrarMenu: false,
      mostrarMenuUsuario: false,
      notificaciones: [],
      eventosUsuario: [],
      botonesSociales: [
        {
          icono:
            "https://www.anahuac.mx/oaxaca/sites/default/files/img/redFacebook_1.png",
          enlace: "https://www.facebook.com/anahuacoaxaca/",
        },
        {
          icono:
            "https://www.anahuac.mx/oaxaca/sites/default/files/img/redInstagram.png",
          enlace: "https://www.instagram.com/anahuacoaxaca",
        },
        {
          icono:
            "https://www.anahuac.mx/oaxaca/sites/default/files/img/redTwitter.png",
          enlace: "https://twitter.com/anahuacoaxaca",
        },
        {
          icono:
            "https://www.anahuac.mx/oaxaca/sites/default/files/img/redYoutube.png",
          enlace: "https://www.youtube.com/channel/UCk5xAk91c-F_lNKn6ceDVZQ",
        },
      ],
      enlacesPie: {
        "Aviso de Privacidad": "https://www.anahuac.mx/oaxaca/aviso-privacidad",
        "Compendio Reglamentario":
          "https://www.anahuac.mx/oaxaca/compendio-reglamentario",
      },
    };
  },
  computed: {
    ...mapGetters(["usuario"]),
    numNotificaciones() {
      return this.notificaciones.length;
    },
    urlRedireccion() {
      return this.usuario ? "/perfil_alumno" : "/iniciosesion";
    },
  },
  mounted() {
    if (this.usuario) {
      this.verificarEventosYNotificar();
      this.obtenerEventosUsuario();
    }
  },
  methods: {
    abrirModal() {
      this.mostrarModal = true;
      this.imagenSeleccionada = null;
    },
    handleFileChange(event) {
      const file = event.target.files[0];
      this.imagenSeleccionada = URL.createObjectURL(file);
      this.imagenParaEnviar = file;
    },
    enviarImagen() {
      // Crear un FormData para enviar la imagen al servidor
      const formData = new FormData();
      formData.append("imagen", this.imagenParaEnviar);
      formData.append("id_usuario", this.usuario.id);

      // Enviar la imagen al servidor utilizando Axios
      axios.post("http://localhost/bea/back/foto_perfil.php", formData)
        .then(response => {
          console.log(response.data);
          if (response.data.success) {
            // Actualizar el campo de foto de perfil en el store
            this.$store.commit('setFotoPerfil', response.data.imageUrl);
            // Cerrar el modal después de enviar la imagen
            this.mostrarModal = false;
          } else {
            // Manejar el caso en el que ocurra un error al subir la imagen
            console.error(response.data.message);
          }
        })
        .catch(error => {
          console.error(error);
          // Manejar el error en caso de que falle la petición
        });
    },
    eliminarNotificacion(index) {
  // Guardar la notificación eliminada en el almacenamiento local
  const notificacionEliminada = this.notificaciones[index];
  const notificacionesEliminadas = JSON.parse(localStorage.getItem('notificacionesEliminadas')) || [];
  notificacionesEliminadas.push(notificacionEliminada);
  localStorage.setItem('notificacionesEliminadas', JSON.stringify(notificacionesEliminadas));

  // Eliminar la notificación del array
  this.notificaciones.splice(index, 1);
  this.$router.push('/horario');
},

    obtenerEventosUsuario() {
      const idUsuario = this.usuario.id;
      axios
        .get(
          `http://localhost/BEA/back/obtenerEventos.php?idUsuario=${idUsuario}`
        )
        .then((response) => {
          this.eventosUsuario = response.data;
          this.verificarEventosYNotificar();
        })
        .catch((error) =>
          console.error("Hubo un error al obtener los eventos:", error)
        );
    },
    abrirEnlaceUsuario() {
      if (this.usuario) {
        window.location.href = this.urlRedireccion;
      } else {
        this.$router.push(this.urlRedireccion);
      }
    },
    ...mapActions(["cerrarSesion"]),
    abrirMapa() {
      window.location.href = "https://maps.app.goo.gl/te3G28WuD56cTgyHA";
    },
    abrirEnlace(url) {
      if (url === "/iniciosesion") {
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

      if (
        menuUsuario &&
        !menuUsuario.contains(e.target) &&
        !e.target.classList.contains("icono-usuario") &&
        !e.target.classList.contains("texto-usuario")
      ) {
        this.mostrarMenuUsuario = false;
      }
    },
    cerrarSesionYCerrarMenu() {
      this.cerrarSesion();
      this.mostrarMenuUsuario = false;
    },
    verificarEventosYNotificar() {
      this.eventosUsuario.forEach((evento) => {
        const eventoDate = new Date(evento.date);
        const unDiaAntes = new Date(eventoDate);
        unDiaAntes.setDate(eventoDate.getDate() - 1);

        const hoy = this.obtenerFechaActual();

        if (unDiaAntes.toISOString().slice(0, 10) === hoy) {
          this.enviarNotificacion(evento.title, "Mañana");
        }

        if (evento.date === hoy) {
          this.enviarNotificacion(evento.title, "Hoy");
        }
      });
    },
    enviarNotificacion(titulo, mensaje) {
      this.notificaciones.push(`${titulo}: ${mensaje}`);
    },
    obtenerFechaActual() {
      const fechaActual = new Date();
      const dia = fechaActual.getDate();
      const mes = fechaActual.getMonth() + 1;
      const año = fechaActual.getFullYear();
      return `${año}-${mes < 10 ? "0" + mes : mes}-${dia < 10 ? "0" + dia : dia}`;
    },
    aplicarCambios() {
      this.enviarImagen();
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



.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2;
}

.modal-contenido {
  position: relative; 
  background-color: white;
  padding: 50px;
  border-radius: 10px;
  width: 300px;
}

.cerrar-modal {
  position: absolute; 
  top: 10px; 
  right: 350px; 
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color:#000000;
  background-color: transparent;
  width: 30px; 
}

.titulo-modal {
  font-size: 20px;
  margin-bottom: 10px;
}

.icono-usuario-modal {
  width: 300px;
  height: 300px;
  border-radius: 50%;
  object-fit: cover;
}

.subir-foto {
  margin-bottom: 20px;
}

.subir-foto p {
  margin: 0;
  cursor: pointer;
}

.subir-foto :hover{
  color:#ff4006;
  cursor:pointer;
}

.subir-foto input {
  display: none;
}

.vista-previa {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 20px;
}

.icono-usuario {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  object-fit: cover;
}

.boton-cancelar,
.boton-aplicar {
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.boton-cancelar {
  background-color: #dd2915;
  color: white;
}

.boton-aplicar {
  background-color: #28b663;
  color: white;
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
  color: #d45c37;
}

/* BOTONES */
.boton-inicio-sesion {
  margin-right: 30px;
  transition: color 0.3s ease;
}

.inicio-sesion-icono {
  width: 25px;
  filter: invert(50%);
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

.usuario-menu-contenedor:hover .texto-usuario {
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
  transition: filter 0.3s ease;
  object-fit: cover;
  object-position: center; 
}

.notificaciones-contenedor {
  position: relative;
}

.notificaciones {
  color: white;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  position: absolute;
  bottom: -20px;
  left: calc(50% - 10px);
  /* Mitad del ancho del círculo */
  font-size: 12px;
  z-index: 1;
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
  margin-top: 17px;
}

.texto-menu {
  padding: 10px;
  cursor: pointer;
  transition: 0.3s ease;
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

.notificacion-menu {
  padding: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease, width 0.3s ease;
  position: relative;
}


.notificacion-menu::before {
  content: "ver";
  position: absolute;
  top: 0;
  left: 0;
  width: 0;
  height: 100%;
  background-color: #ff5900;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  transition: width 0.3s ease;
  overflow: hidden;
}


.notificacion-menu:hover::before {
  width: 100%;
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

.botones-sociales-pie {
  display: flex;
}

/* RESPONSIVIDAD*/

@media only screen and (max-width: 767px) {
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
    transform: translateX(10px);
  }

  .secciones-navegacion {
    display: none;
    flex-direction: column;
    background-color: #030303;
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

  .boton-inicio-sesion {
    transition: color 0.3s ease;
  }

  .inicio-sesion-icono {
    width: 25px;
    filter: invert(50%);
    transition: color 0.3s ease;
  }

  /** */

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
    margin-top: 17px;
  }

  .texto-usuario {
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

  .notificaciones {
    font-size: 10px;
    width: 15px;
    height: 15px;
    bottom: -3px;
    left: calc(50% - 8px);
    /* Mitad del ancho del círculo */
  }

  .usuario-menu-contenedor {
    margin-right: 10px;
  }



  .icono-usuario {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    transition: filter 0.3s ease;
    transform: translateX(-15px);
  }

  .menu-usuario {
    position: absolute;
    right: 0;
    top: 100%;
    background-color: white;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    width: 120px;
    z-index: 10;
    text-align: left;
    color: #000000;
    animation: slideIn 0.3s ease forwards;
    margin-top: 17px;
  }

  .notificaciones {
    font-size: 10px;
    width: 15px;
    height: 15px;
    bottom: -3px;
    left: calc(50% - 8px);
  }

  .botones-pie {
    margin-top: 20px;
  }

  .botones-sociales-pie {
    margin-top: 20px;
  }
}


@media only screen and (min-width:768px) and (max-width: 991px) {


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
    max-height: 40px;
    transform: translateX(25px);
  }

  .secciones-navegacion {
    display: none;
    flex-direction: column;
    background-color: #030303;
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


  .boton-inicio-sesion {
    transition: color 0.3s ease;
  }

  .inicio-sesion-icono {
    width: 25px;
    filter: invert(50%);
    transition: color 0.3s ease;
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
    margin-top: 17px;
  }

  .texto-usuario {
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

  .notificaciones {
    font-size: 10px;
    width: 15px;
    height: 15px;
    bottom: -3px;
    left: calc(50% - 8px);
    /* Mitad del ancho del círculo */
  }

  .usuario-menu-contenedor {
    margin-right: 10px;
  }



  .icono-usuario {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    transition: filter 0.3s ease;
    transform: translateX(-15px);
  }

  .menu-usuario {
    position: absolute;
    right: 0;
    top: 100%;
    background-color: white;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    width: 120px;
    z-index: 10;
    text-align: left;
    color: #000000;
    animation: slideIn 0.3s ease forwards;
    margin-top: 17px;
  }

  .notificaciones {
    font-size: 10px;
    width: 15px;
    height: 15px;
    bottom: -3px;
    left: calc(50% - 8px);
  }

  .botones-pie {
    margin-top: 20px;
  }

  .botones-sociales-pie {
    margin-top: 20px;
  }
}

</style>
