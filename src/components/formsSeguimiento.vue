<template>
  <plantilla>
    <div class="fondo">
      <div class="formulario">
        <div class="leonel">
          <img src="http://localhost/BEA/back/uploads/Leonel%20Me%cc%81dico2.png" alt="Leonel Médico"/>
          <form @submit.prevent="enviarFormulario">

            
            
            
            <div class="contenedor">
            <div class="burbuja" >
              
              <div v-if="preguntaActual === 0">
                <p class="pregunta-texto">{{ preguntas[preguntaActual] }}</p>
                <div v-if="preguntaActual === 0" class="campo-entrada">
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
        "¿Como te has sentido desde tu ultima cita?"
      ],
      respuestas: {
        expectativa: ''
      },
      preguntaActual: 0,
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
      formData.append('EXPECTATIVA', this.respuestas.expectativa);

      axios.post('http://localhost/BEA/back/seguimiento.php', formData)
        .then(response => {
          this.$router.push('/agradecimiento');
        })
        .catch(error => {
          console.error('Error al enviar los datos:', error);
          alert('Ocurrió un error al enviar los datos.');
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
  justify-content: center; 
  align-items: center; 
  height: 100vh; 
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
  margin-bottom: 20px; 
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
  padding: 100px; 
  padding-left: 100px;
  padding-right: 100px;
  text-align: center; 
  color: aliceblue;
  font-size: 25px;
  z-index: 2;
  margin-bottom: 100px;
  transform: translateX(-30%);
  color:black;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
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
  height: 300px; 
  width: 330px;
  align-items: center;
  transform: translateX(0%);
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