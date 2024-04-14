<template>
  <plantilla>
    <div class="fondo">
      <div class="leonel">
        <img v-if="!usuarioYaRegistrado" src="https://i.postimg.cc/0QYjnHzx/Leonel-Me-dico-removebg-preview.png" alt="Leonel Médico"/>
        <div class="burbuja">


          <div v-if="usuarioYaRegistrado" class="overlay"></div>
          <div v-if="usuarioYaRegistrado" class="modal-sesion">
            <h3>Ya has agendado tu primera cita anteriormente</h3>
            <button @click="$router.push('/seguimiento')">Administra tu seguimiento</button>
            <button @click="$router.push('/')">Volver al inicio</button>
          </div>


          <div :key="indiceDeTexto" v-if="!usuarioYaRegistrado" v-html="textoActual" class="texto-animado" @click="redirigirAFormulario"></div>
        </div>
      </div>
    </div>
  </plantilla>
</template>


<script>
import axios from 'axios';
import Plantilla from './plantilla.vue';
import { mapGetters } from 'vuex';

export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      listaDeTextos: [
        "HOLA" ,
        "GRACIAS POR COMUNICARTE A ACOMPAÑAMIENTO",
        "A CONTINUACIÓN VERÁS UN CUESTIONARIO",
        "TODA LA INFORMACIÓN ES 100% CONFIDENCIAL",
        'CUANDO ESTÉS LISTO, PRESIONA <span class="enlace">AQUÍ</span>',
      ],
      textoActual: "",
      indiceDeTexto: 0,
      usuarioYaRegistrado: false, // Nuevo estado para controlar si el usuario ya tiene una cita
    };
  },
  computed: {
    ...mapGetters(['usuario'])
  },
  methods: {
    cambiarTexto() {
      this.textoActual = this.listaDeTextos[this.indiceDeTexto];
      this.indiceDeTexto++;
      if (this.indiceDeTexto >= this.listaDeTextos.length) {
        this.indiceDeTexto = 4; // Mantener el último mensaje visible
      }
      setTimeout(this.cambiarTexto, 3000);
    },
    redirigirAFormulario(event) {
      if (event.target.classList.contains('enlace')) {
        this.$router.push('/FormsPrimeraCita');
      }
    },
    verificarCita() {
      // Suposición: El ID del usuario está disponible y es el correcto
      axios.get(`http://localhost/BEA/back/verificarCita.php?idUsuario=${this.usuario.id}`)
        .then(response => {
          if (response.data.hasCita) {
            this.usuarioYaRegistrado = true; // Cambia el estado basado en la respuesta del backend
          }
        })
        .catch(error => console.error("Error al verificar la cita:", error));
    }
  },
  mounted() {
    this.cambiarTexto();
    if (this.usuario) {
      this.verificarCita();
    }
  },
};
</script>


<style scoped>
.fondo {
  background-color: #ff5900;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
}



.modal-sesion {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: white;
  padding: 50px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.2);
  text-align: center;
  z-index: 3; 
  animation: fedeIn 0.5s ease forwards;
  color:black;
  font-size: 20px;
}

.modal-sesion button {
  margin-top: 20px;
  padding: 10px;
}

.overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.712);
  z-index: 3;
}

.leonel img {
  width: 30%;
  transform: translateX(60%);
  z-index: 2;
  position: absolute;
  bottom: 0;
  margin-bottom: 70px;
}

.burbuja {
  position: absolute;
  width: 100vw;
  bottom: -10px;
  left: 0;
  padding: 100px;
  background-color: #0000006b;
  color: aliceblue;
  font-size: 30px;
  z-index: 1;
  text-align: left;
  margin-bottom: 70px;
}

.texto-animado {
  animation: fadeIn 1s ease forwards;
}

@keyframes fadeIn {
  0% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}

</style>
