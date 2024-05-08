<template>
  <plantilla>
    <div class="fondo">
      <div class="formulario">
        <div class="leonel">
          <img src="http://localhost/BEA/back/uploads/Leonel%20Me%cc%81dico2.png" alt="Leonel Médico"/>
          <form @submit.prevent="enviarFormulario">

            <div class="contenedor">
            <div class="burbuja">
              <!-- Contenido de burbuja para pregunta y botón -->
              <div v-if="preguntaActual === 0">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <div v-if="preguntaActual === 0" class="campo-entrada">
              <select v-model="respuestas.carrera" required class="animacion-entrada entrada-carrera">
                <option disabled value="">Selecciona tu carrera</option>
                <option v-for="carrera in carreras" :key="carrera" :value="carrera">{{ carrera }}</option>
              </select>
            </div>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.carrera">Siguiente</button>
              </div>



              <div v-if="preguntaActual === 1">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <div v-if="preguntaActual === 1" class="campo-entrada">
              <select v-model="respuestas.semestre" required class="entrada-semestre">
                <option disabled value="">Elige un semestre</option>
                <option v-for="num in 12" :key="num" :value="num">{{ num }}</option>
              </select>
            </div>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.semestre">Siguiente</button>
              </div>

            
              <div v-if="preguntaActual === 2">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <div v-if="preguntaActual === 2" class="campo-entrada">
              <textarea v-model="respuestas.motivo" maxlength="500" required class="entrada-motivo" rows="5" placeholder="escribe tu respuesta aqui"></textarea>
            </div>
                <button @click="siguientePregunta" class="boton-siguiente" :disabled="!respuestas.motivo">Siguiente</button>
              </div>



              <div v-if="preguntaActual === 3">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
            <div v-if="preguntaActual === 3" class="campo-entrada">
              <textarea v-model="respuestas.expectativa" maxlength="500" required class="entrada-expectativa" rows="5" placeholder="escribe tu respuesta aqui"></textarea>
            </div>
                <button type="submit" class="boton-enviar" :disabled="!respuestas.expectativa">Enviar</button>
              </div>

            </div>

            </div>
          </form>
        </div>
      </div>
    </div>
  </plantilla>
</template>


<script>
import axios from 'axios';
import { mapGetters } from 'vuex';
import plantilla from './plantilla.vue';

export default {
  components:{
    plantilla,
  },
  data() {
 
    return {

      preguntas: [
        "¿Cuál es tu carrera?",
        "¿Qué semestre estás cursando?",
        "¿Por qué decidiste buscarnos?",
        "¿Qué esperas de lograr con nosotros?"
      ],
      respuestas: {
        carrera: '',
        semestre: null,
        motivo: '',
        expectativa: ''
      },
      preguntaActual: 0,
      carreras: [
        'Licenciatura en Derecho',
        'Licenciatura en Psicología',
        'Licenciatura en Ingeniería Civil',
        'Licenciatura en Ingeniería para la Dirección',
        'Licenciatura en Finanzas y Contaduría Pública',
        'Licenciatura en Administración y Dirección de Empresas',
        'Licenciatura en Mercadotecnia Estratégica',
        'Licenciatura en Negocios Internacionales',
        'Licenciatura en Comunicación',
        'Licenciatura en Diseño Multimedia',
        'Licenciatura en Diseño Industrial',
        'Licenciatura en Ingeniería Biomédica',
        'Licenciatura en Ingeniería Mecatrónica',
        'Licenciatura en Diseño Gráfico',
        'Licenciatura en Diseño de Moda e Innovación',
        'Ingeniería en Tecnologías de la Información y Negocios Digitales',
      ],
    };
  },
  computed: {
    ...mapGetters(['usuario']),
  },

  methods: {

   

    siguientePregunta() {
      if (this.preguntaActual < this.preguntas.length - 1) {
        this.preguntaActual++;
      } else {
        this.enviarFormulario();
      }
    },
    enviarFormulario() {
      const formData = new FormData();
      formData.append('ID_ALUMNO', this.usuario.id); 
      formData.append('CARRERA', this.respuestas.carrera);
      formData.append('SEMESTRE', this.respuestas.semestre);
      formData.append('MOTIVO', this.respuestas.motivo);
      formData.append('EXPECTATIVA', this.respuestas.expectativa);

      axios.post('http://localhost/BEA/back/citas.php', formData)
        .then(response => {
          this.enviarCorreoCita();
          this.$router.push('/agradecimiento');
        })
        .catch(error => {
          console.error('Error al enviar los datos:', error);
          alert('Ocurrió un error al enviar los datos.');
        });
    },

    enviarCorreoCita() {

  axios.get(`http://localhost/BEA/back/enviar_correo_cita.php?idUsuario=${this.usuario.id}`)
    .then(response => {
      console.log('Correo de cita enviado exitosamente');
    })
    .catch(error => {
      console.error('Error al enviar el correo de cita:', error);
      alert('Ocurrió un error al enviar el correo de cita.');
    });
}

  },
};
</script>


<style scoped>


.animacion-entrada {
    margin-bottom: 20px;
  }

.fondo {
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
 
}

.contenedor {
  display: flex;
  justify-content: center; /* Centrar horizontalmente */
  align-items: center; /* Centrar verticalmente */
  height: 100vh; /* Ajustar al alto de la ventana */
}

.pregunta-animada {
  animation: fadeIn 1s ease forwards;
}

.finalizado-animado {
  animation: fadeIn 1s ease forwards;
}

.pregunta-texto {
  font-size: 1.5em; 
  margin-bottom: 20px;
}

.campo-entrada {
  margin-bottom: 20px; /* Agregar un espacio entre el campo de entrada y el botón */
}



.boton-siguiente,
.boton-enviar {
  background-color: #423a38; 
  color: #fff;
  width: 30%;
  border: none;
  font-size: 18px;
  cursor: pointer;
  border-radius: 8px;
  transition: background-color 0.3s ease;
}

.boton-siguiente:hover,
.boton-enviar:hover {
  background-color: #625750;
}

.leonel img {
  width: 40%;
  transform: translateX(100%);
  z-index: -1;
  position: absolute;
  bottom: 0;
  margin-bottom: 70px;
}

.entrada-carrera {
  width: 80%;
  height: 100px;
  font-size: 15px;
  animation: fadeIn 1s ease forwards;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc; 
  resize: none; 
  border-radius: 10px;
}

.entrada-semestre {
  width: 80%;
  height: 100px;
  font-size: 15px;
  animation: fadeIn 1s ease forwards;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc; 
  resize: none; 
  border-radius: 10px;
  margin-bottom: 10px;
}



.entrada-motivo, .entrada-expectativa {
  width: 80%;
  height: 200px;
  font-size: 15px;
  animation: fadeIn 1s ease forwards;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ccc; 
  resize: none; 
  border-radius: 10px;
  margin-bottom: 10px;
}

.entrada-motivo::placeholder, .entrada-expectativa::placeholder {
  text-align: left; 
}

.leonel img {
  transform: translateX(20%);
  width: 40%;
  z-index: 2;
  position: absolute;
  bottom: 0;
  margin-bottom: 70px;
}

.burbuja {
  background-color: white;
  left: 0;
  padding: 100px; /* Reducir el espacio dentro de la burbuja */
  padding-left: 150px;
  padding-right: 150px;
  text-align: center; /* Centrar el contenido */
  color: aliceblue;
  font-size: 25px;
  z-index: 2;
  margin-bottom: 100px;
  transform: translateX(-50%);
  color:black;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
  height: auto; 
      width:  400px;
}


@keyframes fadeIn {
  to {
    opacity: 1;
  }
}

@media only screen and (max-width: 767px) {


.entrada-motivo, .entrada-expectativa {
  width: 80%;
  height: 100px;
}


.leonel img {
  transform: translateX(20%);
  z-index: 3;
}

.burbuja {
  padding: 30px; 
  padding-left: 0px;
  padding-right: 0px;
  font-size: 20px;
  z-index: 2;
  transform: translateX(0%);
  height: 300px; 
  width: 330px;
  align-items: center;
}

}

@media only screen and (min-width: 768px) and (max-width: 991px) {



.leonel img {
  transform: translateX(20%);
  z-index: 3;
}

.pregunta-texto {
  font-size: 1.5em; 
  margin-bottom: 40px;
}

.burbuja {
  padding: 60px; 
  padding-left: 90px;
  padding-right: 90px;
  font-size: 20px;
  z-index: 2;
  transform: translateX(0%);
  height: 400px; 
  width: 330px;
  align-items: center;
}

}


</style>