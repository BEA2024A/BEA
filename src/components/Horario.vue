<template>
  <plantilla>
    <div class="container">
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
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        headerToolbar: {
          left: 'prev,next',
          center: 'title',
          right: 'dayGridMonth,dayGridWeek,dayGridDay'
        },
        events: [
          {title: 'cita de prueba', date: '2024-04-03', color: '#ff5900'},
          {title: 'cita de prueba', date: '2024-04-04', color: '#ff5900'},
          {title: 'cita de prueba', date: '2024-04-05', color: '#ff5900'},
          {title: 'cita de prueba', date: '2024-04-06', color: '#ff5900'},
  
        ],
        locale: esLocale,
      }
    };
  },

  computed: {
    ...mapGetters(['usuario'])
  },

  mounted() {
    this.verificarEventosHoy();
  },
  methods: {
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


.calendar-container {
  max-width: 700px;
  border: 1px solid #ddd;
  border-radius: 8px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  flex: 2;
  margin-right: 50px;
  margin-top: 50px;
  margin-bottom: 50px;
  padding: 30px;
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}
.container {
  display: flex;
  justify-content: space-between;
  background-color: #ff5900;
}

.events-container {
  flex: 2;
  margin-right: 20px;
  margin-left: 20px;
}

.eventos{
  margin-top: 50px;
  padding-top:10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 10px;
  background-color: #ffffff;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}


.eventos:hover{
  transform: scale(1.02);
}

.botones:hover{
  transform: scale(1.02);
}

.calendar-container:hover{
  transform: scale(1.02);
}

.botones{
  margin-top: 50px;
  padding-top:10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 10px;
  background-color: #ffffff;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
}

.events-list {
  list-style-type:disc;
  text-align: justify;
  transform: translateX(32%);
}

.events-list li {
  margin-bottom: 10px;
}

.notifications-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #423a38;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: 0.3s ease;
}

.mail-notifications-button {
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #423a38;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: 0.3s ease;
}





.fc .fc-button-group > .fc-button {
  margin-right: 50px; 
}

.fc .fc-button-group > .fc-button:last-child {
  margin-right: 0;  
}


.fc .fc-button {
  padding: 8px 120px; 
}


.fc-header-toolbar {
  margin-bottom: 30px; 
}



@media (max-width: 639px) {

  .container {
  flex-direction: column;
  padding:10px;
  padding-right: 20px; 
}

.calendar-container {
  padding: 40px;
  border-radius: 8px;
  margin: 5px;
  padding-bottom: 100px;
}

.events-container{
  margin: 30px;
}

.events-list {
  list-style-type:none;
  text-align: center;
  transform: translateX(0%);
}

.eventos{
  margin-top: 0;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
}
.botones {
  margin-top: 20px;
  padding-top: 10px;
  padding-bottom: 25px;
  padding-left: 20px;
  padding-right: 20px;
}


/* Orden de visualización */
.calendar-container {
  order: 1;
}

.events-container {
  order: 2;
}

.botones {
  order: 3;
}


}

</style>