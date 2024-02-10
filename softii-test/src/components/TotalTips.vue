<template>
    <div class="main-container">
        <div class="left-module">
            <div class="total-tips-container">
                <div class="value">
                    <label for="totalTips">Total de Propinas</label><br>
                    <input id="totalTips" type="text" v-model="totalTips" :class="{ active: isActiveTotal }"
                        v-number="number" :disabled="disabled">
                    <button @click="enableTotal"><svg-icon type="mdi" :path="path"></svg-icon></button>
                </div>
            </div>
            <div class="tips-split-container">
                <h2>¿Entre cuantas personas se dividirá la propina?</h2>

                <div class="content">
                    <div class="input">
                        <input id="tipSplit" type="text" v-model="tipSplit" :class="{ active: isActiveSplit }" disabled>
                        <button @click="enableSplit"><svg-icon type="mdi" :path="path"></svg-icon></button>
                    </div>
                    <div class="split">
                        <span>${{ splitTip }} x Persona</span>
                    </div>
                </div>
            </div>
            <div class="payment-method-container">

                <div class="title">
                    <h2><svg-icon type="mdi" :path="walletIcon"></svg-icon></h2>
                    <h2>Elige método de pago</h2>
                </div>

                <div class="payment-methods">
                    <button @click="listData('Efectivo')">
                        <svg-icon type="mdi" :path="cashIcon"></svg-icon><br>
                        Efectivo
                    </button>
                    <button @click="listData('Tarjeta')">
                        <svg-icon type="mdi" :path="cardIcon"></svg-icon><br>
                        Tarjeta
                    </button>
                    <button @click="listData('Otro')">
                        <svg-icon type="mdi" :path="otherIcon"></svg-icon><br>
                        Otro
                    </button>
                </div>

            </div>
        </div>

        <div class="midle-module">
            <NumberKeyboard @keyValue="getValue" :inputToEdit="inputData" :newPayment="paymentMethod" />
        </div>

        <div class="right-module">
            <PaymentsList @totalPayments="getTotalPayments" :paymentData="paymentDataObj" :newPayments="paymentsAux" />
        </div>
    </div>
    <div class="total-container">

        <div class="texts">
            <div class="total-to-pay">
                <div class="text">
                    <h2>
                        Total a Pagar
                    </h2>
                </div>
                <div class="value">
                    <h2>
                        {{ totalPayed }}
                    </h2>
                </div>
            </div>

            <div class="total-for-pay">
                <div class="text">
                    <h2>
                        Restante por Pagar
                    </h2>
                </div>
                <div class="value">
                    <h2>
                        {{ totalTips - totalPayed }}
                    </h2>
                </div>

            </div>
        </div>

        <div class="cta">
            <button @click="saveTips()" :disabled="sendIsDisabled">
                Pagar {{ totalPayed }} en Propinas
            </button>
        </div>
    </div>
</template>

<script lang="ts">

import { defineComponent } from 'vue'
import { ref } from "vue";
import SvgIcon from '@jamescoyle/vue-icon'
import { mdiPencil } from '@mdi/js'
import { mdiWalletBifoldOutline } from '@mdi/js';
import { mdiCashMultiple } from '@mdi/js';
import { mdiCreditCardOutline } from '@mdi/js';
import { mdiCashFast } from '@mdi/js';
import { directive as VNumber } from '@coders-tm/vue-number-format'
import NumberKeyboard from './NumberKeyboard.vue';
import PaymentsList from './PaymentsList.vue';


/*const cashValue = ref('');
const path = mdiPencil;
const disabled = ref(true);*/

export default defineComponent({

    components: {
        SvgIcon,
        NumberKeyboard,
        PaymentsList
    },
    data() {
        return {
            path: mdiPencil,
            walletIcon: mdiWalletBifoldOutline,
            cashIcon: mdiCashMultiple,
            cardIcon: mdiCreditCardOutline,
            otherIcon: mdiCashFast,
            isActiveTotal: ref(false),
            isActiveSplit: ref(false),
            disabled: ref(true),
            sendIsDisabled: ref(true),
            totalTips: 0,
            tipSplit: 0,
            splitTip: 0,
            inputData: "",
            paymentDataObj: {},
            payments: [],
            paymentsAux: {},
            paymentMethod: "",
            totalToPay: 0,
            totalPayed: 0,
            number: {
                decimal: '.',
                separator: ',',
                prefix: '$',
                precision: 2,
            },
        }
    },
    directives: {
        number: VNumber,
    },
    methods: {
        enableTotal() {

            this.isActiveTotal = !this.isActiveTotal;

            if (this.isActiveTotal) {
                this.inputData = "total"
            } else {
                this.inputData = "payment";
            }

        },
        enableSplit() {

            this.isActiveSplit = !this.isActiveSplit;

            if (this.isActiveSplit) {
                this.inputData = "split"
            } else {
                this.inputData = "payment"
            }

        },
        calculateSplit() {

            if (this.tipSplit == 0) {
                this.splitTip = this.totalTips;
            } else {
                this.splitTip = Math.floor(this.totalTips / this.tipSplit);
            }

        },
        getTotalPayments(message) {
            this.payments = message.paymentlist;
            this.totalPayed = message.totalpaymets;

            if(message.type == "saved") {
                this.totalTips = 0;
                this.tipSplit = 0;

            }

            this.payments.length > 0 ? this.sendIsDisabled = false : this.sendIsDisabled = true;

        },
        getValue(message) {

            if (message.type == "fill") {

                switch (message.field) {
                    case "total":
                        this.totalTips = message.value;
                        this.isActiveTotal = false;
                        this.calculateSplit();
                        this.inputData = ""
                        break;

                    case "split":
                        this.tipSplit = message.value;
                        this.isActiveSplit = false;
                        this.calculateSplit();
                        this.inputData = ""
                        break;

                    default:
                        break;
                }

            } else {


                this.totalToPay = message.value;
                this.sendPayment(this.paymentMethod)

            }

        },
        listData(paymentType) {
            this.paymentMethod = paymentType;
        },
        sendPayment(paymentType) {

            if (this.totalTips != 0 && this.totalTips > this.totalPayed && this.totalToPay != 0) {

                this.tipSplit == 0 ? this.tipSplit = 1 : this.tipSplit;

                switch (paymentType) {
                    case "Efectivo":

                        this.paymentDataObj = { icon: this.cashIcon, type: paymentType, split: this.tipSplit, tip: this.totalToPay }

                        break;
                    case "Tarjeta":

                        this.paymentDataObj = { icon: this.cardIcon, type: paymentType, split: this.tipSplit, tip: this.totalToPay }

                        break;
                    case "Otro":

                        this.paymentDataObj = { icon: this.otherIcon, type: paymentType, split: this.tipSplit, tip: this.totalToPay }

                        break;
                    default:
                        break;
                }
            }

        },
        saveTips() {
            
            let counter = 0;

            for (let i = 0; i < this.payments.length; i++) {

                let paymentMethodIt;

                if (this.payments[i].type == "Efectivo") {
                    paymentMethodIt = 1;
                } else if (this.payments[i].type == "Tarjeta") {
                    paymentMethodIt = 2;
                } else {
                    paymentMethodIt = 3;
                };

                this.fetchSave(this.totalTips, this.payments[i].split, this.payments[i].tip, paymentMethodIt, i);

                counter++;

                if (counter == this.payments.length) {
                    this.payments = [];
                    this.paymentsAux = { status: "payment", payments: this.payments };

                }

            }
        },
        fetchSave(totalTips, tipsplit, tipvalue, paymentmethod, paymentindex) {

            let url = "http://localhost:4000/api/tips";
            let data = {
                "total_tips": totalTips,
                "tip_split": tipsplit,
                "tip_value": tipvalue,
                "payment_method": paymentmethod
            }
            let headers = {
                method: "POST",
                body: JSON.stringify(data),
                headers: {
                    'Content-Type': 'application/json'
                }
            }

            fetch(url, headers)
                .then(response => response.json())
                .then(data => console.log(data));
        }
    }
})

</script>

<style scoped></style>