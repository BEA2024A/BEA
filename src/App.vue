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

/* Estilos para la barra de desplazamiento */
/* Cambiar la barra de desplazamiento */
::-webkit-scrollbar {
  width: 10px; /* Ancho de la barra de desplazamiento */
}

/* Cambiar el riel de la barra de desplazamiento */
::-webkit-scrollbar-track {
  background-color: transparent; /* Fondo transparente */
}

/* Cambiar el agarre de la barra de desplazamiento */
::-webkit-scrollbar-thumb {
  background-color: rgba(0, 0, 0, 0.3); /* Color semi-transparente para el agarre */
  border-radius: 5px; /* Borde redondeado del agarre */
}

/* Cambiar el color de fondo cuando se pasa el mouse sobre la barra de desplazamiento */
::-webkit-scrollbar-thumb:hover {
  background-color: rgba(0, 0, 0, 0.5); /* Color semi-transparente más oscuro */
}
</style>
