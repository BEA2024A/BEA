<template>
  <plantilla>
  <div class="fondo">
    <div class="leonel">
      <img src="http://localhost/BEA/back/uploads/Leonel%20Me%cc%81dico2.png" alt="Leonel Médico"/>
      <div class="burbuja">
        <div :key="indiceDeTexto" v-html="textoActual" class="texto-animado" @click="redirigirAFormulario"></div>
      </div>
    </div>
  </div>
</plantilla>
</template>

<script>
import Plantilla from './plantilla.vue';
export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      listaDeTextos: [
      "GRACIAS POR SEGUIR CON NOSOTROS",
            "CUENTANOS COMO TE HAS SENTIDO",
            "CUANDO ESTÉS LISTO, PRESIONA <span class='enlace'>AQUÍ</span>",
      ],
      textoActual: "",
      indiceDeTexto: 0,
    };
  },
  methods: {
    cambiarTexto() {
      this.textoActual = this.listaDeTextos[this.indiceDeTexto];
      this.indiceDeTexto++;
      if (this.indiceDeTexto >= this.listaDeTextos.length) {
        this.indiceDeTexto = 2;
      }
      setTimeout(this.cambiarTexto, 3000);
    },
    redirigirAFormulario(event) {
      if (event.target.classList.contains('enlace')) {
        this.$router.push('/FormsSeguimiento');
      }
    },
    bloquearScroll() {
      document.body.style.overflow = 'hidden';
    },

  },
  mounted() {
    this.cambiarTexto();
    this.bloquearScroll();
  },

  
};
</script>

<style scoped>
.fondo {
  background-image: linear-gradient(to bottom, #ff5900, #c21c02);
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  position: relative;
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
  padding: 150px;
  color: aliceblue;
  font-size: 25px;
  z-index: 1;
  text-align: left;
  margin-bottom: 100px;
  transform: translateX(-35%);
  color:black;
  border-radius: 10px;
  box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
  background-color: white;
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

@media only screen and (max-width: 767px) {


.leonel img {
transform: translateX(20%);
width: 40%;
z-index: 2;
position: absolute;
bottom: 0;
margin-bottom: 70px;
}

.burbuja {
padding: 5px;
padding-top: 50px;
padding-bottom: 50px;
padding-left: 20px;
padding-right: 20px;
text-align: center;
transform: translateX(0);
margin-left: 10px;
margin-right: 10px;
font-size: 20px;
}
}

@media only screen and (min-width: 768px) and (max-width: 991px) {


.leonel img {
transform: translateX(20%);
width: 40%;
z-index: 2;
position: absolute;
bottom: 0;
margin-bottom: 70px;
}

.burbuja {
padding: 25px;
padding-top: 50px;
padding-bottom: 50px;
text-align: center;
transform: translateX(0);
margin-left: 10px;
margin-right: 10px;
font-size: 40px;
}

}

</style>
