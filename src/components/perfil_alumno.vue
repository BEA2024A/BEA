<template>
  <plantilla>
    <div class="contenido-pagina">
      <!-- Cabecera con animación de aparición -->
      <div class="cabecera" v-if="loaded">
        <!-- Lado izquierdo: Nombre y especialidad -->
        <div class="info-izquierda" ref="infoIzquierda">
          <h1>{{ usuario.nombre }} {{usuario.a_paterno }} {{ usuario.a_materno }}</h1>

          <p>id: 00{{ usuario.id }}</p>
        </div>
        <!-- Lado derecho: Imagen en círculo con sombra naranja -->
        <div class="imagen-derecha" ref="imagenDerecha">
          <div class="circulo-con-sombra">
            <img :src="imagenAlumno[0]" alt="Imagen del psicoterapeuta">
          </div>
        </div>

        <!-- Botón de scroll-down con el icono proporcionado -->
        <button class="boton-scroll" @click="scrollDown">
          <img class="icono-scroll" src="https://cdn-icons-png.freepik.com/512/9923/9923629.png" alt="Icono de scroll-down">
        </button>
      </div>

      
      <div class="informacion-psicoterapeuta" v-if="loaded" ref="informacionPsicoterapeuta">
        <div v-if="!usuario" class="overlay"></div>
      <div v-if="!usuario" class="modal-sesion">
        <h3>Necesitas iniciar sesión para ver tu calendario</h3>
        <button @click="$router.push('/inicioSesion')">Iniciar sesión</button>
        <button @click="$router.push('/')">Regresar al inicio</button>
      </div>

      <div class="container" v-else>
        <div class="events-container">
          <div class="eventos">
            <h2>Citas próximas</h2>
            <ul class="events-list">
              <li v-for="event in calendarOptions.events" :key="event.title">
                {{ event.title }} - {{ event.date }} - {{ event.time }} hrs
              </li>
            </ul>
          </div>
          <div class="botones">
            <button @click="activarNotificaciones" class="notifications-button">
              Activar notificaciones del sistema
            </button>
            <button @click="enviarCorreoRecordatorio" class="mail-notifications-button">
              Activar notificaciones por correo
            </button>
          </div>
        </div>
        <div class="calendar-container">
          <FullCalendar :options="calendarOptions" />
        </div>
      </div>
      </div>
      <!-- Botón Regresar al inicio -->
      <router-link to="/" class="boton-regresar" v-if="loaded">Regresar al inicio</router-link>
    </div>
  </plantilla>
</template>

<script>
import axios from 'axios';
import Plantilla from './plantilla.vue';
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import { mapGetters } from 'vuex';
import esLocale from '@fullcalendar/core/locales/es';

export default {
  components: {
    FullCalendar,
    Plantilla,
  },
  data() {
    return {
      imagenAlumno: [
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
        
      ],
      loaded: false, // Indicador de carga de la página
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next',
          center: 'title',
          right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        events: [],
        locale: esLocale,
      }
    };
  },
  computed: {
    ...mapGetters(['usuario'])
  },
  mounted() {
    setTimeout(() => {
      this.loaded = true;
    }, 500);
  },
  methods: {
    formatFormacion(formacion) {
      return formacion.split('\n').map(parrafo => `<p>${parrafo}</p>`).join('');
    },
    scrollDown() {
      window.scrollBy({
        top: window.innerHeight, // Cantidad de desplazamiento (una ventana completa)
        behavior: 'smooth' // Efecto de desplazamiento suave
      });
    },

    obtenerEventosUsuario() {
    const idUsuario = this.usuario.id; 
    axios.get(`http://localhost/BEA/back/obtenerEventos.php?idUsuario=${idUsuario}`)
      .then(response => {
        this.calendarOptions.events = response.data;
      })
      .catch(error => console.error("Hubo un error al obtener los eventos:", error));
  },

  activarNotificaciones() {
      if (!("Notification" in window)) {
        alert("Este navegador no soporta notificaciones del sistema");
      } else if (Notification.permission === "granted") {
        this.verificarEventosHoy(); 
      } else if (Notification.permission !== "denied") {
        Notification.requestPermission().then(permission => {
          if (permission === "granted") {
            this.verificarEventosHoy(); 
          }
        });
      }
    },
    verificarEventosHoy() {
      const hoy = new Date().toISOString().slice(0, 10); // Obtiene la fecha de hoy
      this.calendarOptions.events.forEach(evento => {
        if (evento.date === hoy) {
          this.enviarNotificacion(evento);
        }
      });
    },
    enviarNotificacion(evento) {
      new Notification("Evento Hoy", {
        body: `Recordatorio: ${evento.title}`,
      });
    },

    enviarCorreoRecordatorio() {
  const hoy = new Date().toISOString().slice(0, 10);
  const correoDestinatario = this.usuario.correo; 
  this.calendarOptions.events.forEach(evento => {
    if (evento.date === hoy) {
      axios.post('http://localhost/BEA/back/enviarCorreo.php', {
        correoDestinatario: correoDestinatario,
        mensaje: `¡Hola ${this.usuario.nombre}! tienes un Recordatorio: ${evento.title} el dia ${evento.date} a las ${evento.time} hrs`
      })
      .then(response => {
        console.log(response.data);
        alert('Correo enviado');
      })
      .catch(error => console.error(error));
    }
  });
},
    
  } 
};
</script>



<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0; /* Opacidad inicial */
  }
  to {
    opacity: 1; /* Opacidad final */
  }
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px); 
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes bounce{
  0% {transform: translateY(0);}
  40%{transform: translateY(-20px);}
  60%{transform: translateY(-10px);}
  80%{transform: translateY(-20px);}
  100%{transform: translateY(0);}
}


.cabecera {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100vh; /* Ajusta la altura al 100% del viewport */
  
}

.cabecera::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('https://8377358.fs1.hubspotusercontent-na1.net/hub/8377358/hubfs/custom-video-thumbnails/AOX%20-%20C%C3%A1psula%20de%20Oferta%20Educativa-thumb.jpeg?length=1920');
  background-size: cover;
  background-position: center;
  filter: brightness(0.5); /* Se aplica el filtro de oscuridad solo a la imagen de fondo */
}

/* Estilos para el contenido dentro de la cabecera */
.info-izquierda{
  z-index: 1;
  margin: 0 auto; 
  animation: slideIn 1s ease forwards; /* Animación de aparición */
}
.imagen-derecha {
  z-index: 1; 
  margin: 0 auto; 
  animation: slideIn 1s ease forwards;
}

.info-izquierda h1 {
  text-shadow: 0 0 20px rgba(0, 0, 0, 0.705); 
  color: aliceblue;
}

.info-izquierda h3 {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
  background-color: rgba(240, 248, 255, 0.603);
  display: inline-block;
  padding: 10px 20px;
  border-radius: 5px;
  margin-left: 10px;
}
.info-izquierda p{
  color:aliceblue;
}


.imagen-derecha {
  margin-left: 200px;
}

.circulo-con-sombra {
  width: 350px; 
  height: 350px; 
  border-radius: 50%; 
  overflow: hidden; 
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
}

.circulo-con-sombra img {
  width: 100%;
  height: 100%;
  object-fit: cover; 
}

.boton-scroll {
  position: absolute;
  bottom: 120px; /* Distancia desde la parte inferior */
  left: 50%; /* Centrar horizontalmente */
  transform: translateX(-50%); /* Centrar horizontalmente */
  right: 50%; 
  transform: translateY(-50%); /* Centrar horizontalmente */
  background-color: rgba(240, 248, 255, 0.603); /* Color de fondo */
  border: none; /* Sin borde */
  border-radius: 50%; /* Botón circular */
  width: 60px; /* Ancho del botón */
  height: 60px; /* Altura del botón */
  font-size: 24px; /* Tamaño del ícono */
  color: #000; /* Color del ícono */
  cursor: pointer; /* Cursor de puntero al pasar sobre el botón */
  transition: background-color 0.3s; /* Transición suave al cambiar de color */
  transition: transform 0.3s;
  animation: fadeIn 5s ease forwards;
  animation: bounce 2s infinite;
}
.icono-scroll {
  margin-top: 3px;
  width: 40px; /* Tamaño del icono */
  height: 40px; /* Tamaño del icono */
  transition: transform 0.3s;
}

.icono-scroll:hover{
  transform: scale(1.2);
}

.boton-scroll:hover {
  background-color: rgba(200, 220, 255, 0.8); /* Color de fondo al pasar el cursor */
  transform: scale(1.2);
}

.boton-regresar{
  display: inline-block;
  background-color: #ff5901;
  color: white;
  padding: 10px 20px;
  text-decoration: none;
  border-radius: 5px;
  margin-top: 20px;
  margin-bottom: 60px; /* Aumenta el margen inferior */
}

.boton-regresar:hover {
  background-color: #e04400;
}
</style>