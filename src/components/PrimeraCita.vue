<template>
    <div class="fondo">
      <div class="texto-centrado" :key="textoActual" ref="texto" v-html="textoActual">
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        listaDeTextos: [
          "HOLA",
          "GRACIAS POR COMUNICARTE A ACOMPAÑAMIENTO",
          "A CONTINUACIÓN VERÁS UN CUESTIONARIO",
          "TODA LA INFORMACIÓN ES 100% CONFIDENCIAL",
          "CUANDO ESTÉS LISTO, PRESIONA <a href='https://www.instagram.com/__carlosg14__/' >AQUÍ</a>",
        ],
        textoActual: "",
        indiceDeTexto: 0,
      };
    },
    methods: {
      cambiarTexto() {
        if (this.indiceDeTexto < this.listaDeTextos.length) {
          this.textoActual = this.listaDeTextos[this.indiceDeTexto];
          this.indiceDeTexto++;
        }
  
        //tiempo
        setTimeout(this.cambiarTexto, 3000);
      },
    },
    mounted() {
      // cambio de texto
      this.cambiarTexto();
    },
  };
  </script>
  
  <style scoped>
  .fondo {
    background-color: #ed6337;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }
  
  .texto-centrado {
    color: #fff;
    font-size: 24px;
    opacity: 0;
    animation: aparecer 1s forwards;
    font-style: italic;
  }
  
  .texto-centrado.animado {
    animation: aparecer 1s forwards;
  }
  
  @keyframes aparecer {
    to {
      opacity: 1;
    }
  }
  
  </style>