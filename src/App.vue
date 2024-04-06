<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
}
</script>

<style>
body {
  font-family: "Kumbh Sans", sans-serif;
  font-optical-sizing: auto;
  font-style: normal;
  font-variation-settings: "YOPQ" 300;
  margin: 0;
  padding: 0;
  background-color: aliceblue;
}

#app {
  max-width: auto;
  margin: 0 auto;
  text-align: center;
}

::-webkit-scrollbar {
  width: 6px; /* Ancho de la barra de desplazamiento */
}


/*  riel de la barra de desplazamiento */
::-webkit-scrollbar-track {
  background-color: transparent; 
}

/*  agarre de la barra de desplazamiento */
::-webkit-scrollbar-thumb {
  background-color: #9e9e9e62;
  border-radius: 5px; 
}

/*  color de fondo cuando se pasa el mouse sobre la barra de desplazamiento */
::-webkit-scrollbar-thumb:hover {
  background-color:#c44501;
}
</style>
