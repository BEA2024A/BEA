<template>
  <plantilla-psico>
    <div class="plantilla-psico">
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
            <p>{{ comentarios.notas }}</p>
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
        notas:'Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, , en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32"'
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
.plantilla-psico {
  display: flex;
}

.perfil {
  font-family: Arial, sans-serif;
  margin-right: 20px;
  width: 100%; 
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  text-align: justify;
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
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
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
  padding: 50px;
  flex: 70%;
  padding-right: 60px;
  padding-left: 100px;
}

</style>