<template>
  <plantilla>
      <div class="fondo">
        <div class="texto-centrado" :key="textoActual" v-html="textoActual" @click="redirigirAFormulario">
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
          if (this.indiceDeTexto < this.listaDeTextos.length) {
            this.textoActual = this.listaDeTextos[this.indiceDeTexto];
            this.indiceDeTexto++;
          }
          setTimeout(this.cambiarTexto, 3000);
        },
        redirigirAFormulario() {
          if (event.target.classList.contains('enlace')) {
            this.$router.push('/formsSeguimiento');
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
    }
    
    .texto-centrado {
      color: #fff;
      font-size: 24px;
      opacity: 0;
      animation: aparecer 1s forwards;
      font-style: italic;
      cursor: pointer;
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
    