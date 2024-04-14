<template>
    <plantilla>
    <div class="fondo">
      <div class="leonel">
        <img src="https://i.postimg.cc/0QYjnHzx/Leonel-Me-dico-removebg-preview.png" alt="Leonel Médico"/>
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
          'GRACIAS POR CONTESTAR',
          'TU PSICOLOGO ASIGNADO TE MANDARA UN CORREO LO ANTES POSIBLE',
            'RECUERDA QUE EL CAMBIO EMPIEZA POR TI',
            'PUEDES IR A LA SECCION DE AUTOAYUDA PARA APOYARTE EN ESTE PROCESO',
          'SI QUIERES IR A LA SECCION DE AUTOAYUDA PRESIONA <span class="enlace">AQUÍ</span>',
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
          this.indiceDeTexto = 4;
        }
        setTimeout(this.cambiarTexto, 3000);
      },
      redirigirAFormulario(event) {
        if (event.target.classList.contains('enlace')) {
          this.$router.push('/autoayuda');
        }
      },
    },
    mounted() {
      this.cambiarTexto();
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
  