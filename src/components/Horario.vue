<template>
  <plantilla>
    

    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>

     




      
    </div>
  </plantilla>
</template>

<script>
import Plantilla from './plantilla.vue';

export default {
  components: {
    Plantilla,
  },
  
 
 
    
  }

</script>


<style scoped>



/* Contenido de la Página */
.contenido-pagina {
  padding: 30px;
}




</style>