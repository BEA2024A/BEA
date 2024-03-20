<template>
  <plantilla-psico>
    <div class="plantilla-psico">
      <div class="contenido">
        <div class="contenido-derecha">
          <div class="perfil">
            <img :src="perfil.imagen" alt="Foto de perfil" class="imagen-perfil">
            <h1>{{ perfil.nombre }}</h1>
            <p>ID: 00{{ perfil.ide }}</p>
            <p>Edad: {{ perfil.edad }}</p>
            <p>Carrera: {{ perfil.carrera }}</p>
            <p>Problemas principales: {{ perfil.problemas }}</p>
            <p>Historial médico: {{ perfil.historial }}</p>
            <p>Medicación actual: {{ perfil.medicacion }}</p>
            <p>Tratamientos anteriores: {{ perfil.tratamientosAnteriores }}</p>
            <p>Expectativas para la terapia: {{ perfil.expectativas }}</p>
          </div>
        </div>
        <div class="contenido-izquierda">
          <FullCalendar :options="calendarOptions" :events="events" @dateClick="handleDateClick" />
          <div class="comentarios">
            <h2>Comentarios del paciente</h2>
            <p>{{ perfil.comentarios }}</p>
          </div>
        </div>
      </div>
    </div>
  </plantilla-psico>
</template>

<script>
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import plantillaPsico from './plantillaPsico.vue'

export default {
  components: {
    plantillaPsico,
    FullCalendar,
  },
  data() {
    return {
      perfil: {
        nombre: 'Carlos González',
        ide: 456641,
        edad: 22,
        carrera: 'Ingenieria en Tecnologías de la Información y Negocios Digitales',
        problemas: 'Ansiedad y depresión',
        historial: 'Ha tenido episodios de ansiedad desde la adolescencia. Ha experimentado síntomas de depresión en los últimos dos años.',
        medicacion: 'Actualmente toma medicamentos recetados para la ansiedad.',
        tratamientosAnteriores: 'Ha recibido terapia cognitivo-conductual en el pasado.',
        expectativas: 'Espera encontrar herramientas para manejar mejor su ansiedad y depresión, así como mejorar su calidad de vida en general.',
        imagen: 'https://i.postimg.cc/05WbLPJJ/Dise-o-sin-t-tulo.png',
        comentarios: "Últimamente he estado experimentando mucha ansiedad en situaciones sociales. Me siento nervioso y tenso, y a veces evito encontrarme con amigos o familiares. Creo que esto está afectando mi vida social y mi bienestar emocional. Me gustaría hablar sobre estrategias para manejar esta ansiedad y sentirme más cómodo en estas situaciones."
      },
      calendarOptions: {
        plugins: [dayGridPlugin],
        initialView: 'dayGridMonth',
        weekends: false,
        locale: 'es'
      },
      events: [
        { title: 'Meeting', start: new Date() }
      ]
    };
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
    }
  },
};
</script>

<style scoped>
.plantilla-psico {
  display: flex;
}

.perfil {
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
  margin-top: 20px; 
  padding: 20px;
  margin-bottom: 20px;
  background-color: #f9f9f9; 
  border: 1px solid #ddd; 
  border-radius: 5px; 
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
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
  flex: 70%;
  padding-right: 60px;
  padding-left: 100px;
}
</style>
