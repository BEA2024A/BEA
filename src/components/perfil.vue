<template>
  <plantilla-psico>
    <div class="plantilla-psico">
      <div class="container">
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="perfil">
            <img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="Foto de perfil" class="imagen-perfil">
            <h1>{{ perfil.NOMBRE }} {{ perfil.APELLIDO_PATERNO }} {{ perfil.APELLIDO_MATERNO }}</h1>
            <p>ID: 00{{ perfil.ID_ALUMNO }} </p>
            <p>Carrera: {{ perfil.CARRERA}}</p>
            <p>motivos de la cita: {{ perfil.MOTIVO }}</p>
            <p>Expectativas para la terapia: {{ perfil.EXPECTATIVA }}</p>
          </div>
        </div>
        <div class="contenido-izquierda">
          <div class="calendar-container">
        <FullCalendar :options="calendarOptions" />
      </div>
          <div class="comentarios">
            <h2>Comentarios del paciente</h2>
            <p>{{ comentarios.EXPECTATIVA }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  </plantilla-psico>
</template>

<script>
import FullCalendar from '@fullcalendar/vue3';
import dayGridPlugin from '@fullcalendar/daygrid';
import { mapGetters } from 'vuex';
import esLocale from '@fullcalendar/core/locales/es';
import axios from 'axios';
import plantillaPsico from './plantillaPsico.vue'
export default {
  components: {
    plantillaPsico,
    FullCalendar,
  },
  data() {
    return {
      perfil: {
        NOMBRE: "",
  APELLIDO_PATERNO: "",
    APELLIDO_MATERNO: "",
    CARRERA: "",
    ID_ALUMNO: null,
    MOTIVO: "",
  EXPECTATIVA: ""
      },

      comentarios:{
        EXPECTATIVA:''
      },
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
      },
      
    };
  },
  mounted() {
    this.cargarDatosAlumno();
    this.obtenerEventosUsuario();
    this.cargarComentarios();

  },
  methods: {
    handleDateClick(info) {
      console.log('Fecha clickeada:', info.dateStr);
      let eventTitle = prompt('Ingrese el título del evento para ' + info.dateStr);
      if (eventTitle) {
        this.events.push({
          title: eventTitle,
          start: info.date,
          allDay: true
        })
      }
    },
    cargarDatosAlumno() {
      const idAlumno = this.$route.params.id; 
      axios.get(`http://localhost/bea/back/notas-perfil.php?idAlumno=${idAlumno}`)
        .then(response => {
          this.perfil = response.data;
        })
        .catch(error => {
          console.error('Error al cargar los datos del alumno:', error);
        });
    },

    cargarComentarios() {
      const idAlumno = this.$route.params.id; 
    axios.get(`http://localhost/bea/back/cargarSeguimiento.php?idAlumno=${idAlumno}`)
      .then(response => {
        this.comentarios = response.data;
      })
      .catch(error => {
        console.error('Error al cargar los comentarios del alumno:', error);
      });
  },

    obtenerEventosUsuario() {
    const idAlumno = this.$route.params.id; 
    axios.get(`http://localhost/BEA/back/obtenerEventos.php?idUsuario=${idAlumno}`)
      .then(response => {
        this.calendarOptions.events = response.data;
      })
      .catch(error => console.error("Hubo un error al obtener los eventos:", error));
  },
  },
};
</script>

<style scoped>

.container {
  display: flex;
  justify-content: space-between;
  background-color: #ff5900;
  z-index: -9999;
}


.perfil {
  font-family: Arial, sans-serif;
    margin-right: 20px;
    margin-left: 20px;
    margin-top:20px;
    margin-bottom: 80px;
    width: 100%;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
    position: sticky;
    top: 0;
    text-align: justify;
    background-color: #fdfdfd;
}

.perfil p {
  margin-bottom: 10px;
  font-size: 1.2rem;
  color: #666;
  text-align: justify; 
}

.imagen-perfil {
  display: block;
  margin: 0 auto 20px auto;
  width: 100%;
  max-width: 200px;
  border-radius: 50%;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.perfil h1 {
  font-size: 2rem;
  margin-top: 0;
  color: #444;
  text-align: center;
}

.comentarios {
  margin-top: 50px; 
  margin-bottom: 80px;
  padding: 20px; 
  background-color: #f9f9f9; 
  border: 1px solid #ddd; 
  border-radius: 5px; 
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541); 
  background-color: #fbfdd5;
}

.comentarios h2 {
  font-size: 1.5rem; 
  margin-top: 0; 
  color: #333; 
  text-align: justify;
}

.comentarios p {
  font-size: 1.2rem;
  line-height: 1.5; 
  color: #666;
  text-align: justify;
}

.contenido {
  flex: 1;
  display: flex;
}

.contenido-derecha {
  flex: 30%;
}

.contenido-izquierda {
  margin-top: 20px;
  flex: 82%;
  padding-right: 60px;
  padding-left: 100px;
}

.calendar-container {
  max-width: 200%;
  border: 1px solid #ddd;
  border-radius: 10px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  transition: 0.3s ease;
  animation: slideIn 0.5s ease forwards;
  padding: 20px;
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


</style>