<template>
    <div class="header-container">
        <div class="title">
            <h1>Pago de Propinas</h1>
        </div>
        <div class="value">
            <label for="cashValue">Efectivo en caja</label><br>
            <input id="cashValue" type="text" v-model="cashValue" disabled>
        </div>
    </div>
    <hr>
</template>

<script setup lang="ts">
import {ref} from "vue";
const cashValue = ref('$5,500.00')

</script>

<style scoped>
</style>