<template>
  <div class="container">
    <template>
      <v-data-table
        :headers="headers"
        :items="products"
        :items-per-page="5"
        class="elevation-1"
      ></v-data-table>
    </template>
    <!-- <v-form 
      v-model="valid"
      @submit.prevent="createProduct"
    >
      <v-container>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="title"
              :rules="nameRules"
              :counter="10"
              label="Add any task"
              required
            ></v-text-field>
          </v-col>
          <v-col>
            <v-btn
              class="mr-4"
              type="submit"
            >
              submit
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-form> -->
    <ul>
      <li v-for="(product, index) in products" :key="product.id">
        <!-- <input
          type="checkbox"
          v-on:change="doneChange(index, product.id, product.done)"
          v-model="product.done"
        > -->
        <span>{{ product.title }}</span>
        <span>{{ product.shelf_id }}</span>
        <button v-on:click="deleteProduct(index, product.id)">削除</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios"

export default {
  data: function () {
    return {
      headers: [
        {
          text: '管理番号',
          align: 'start',
          sortable: false,
          value: 'id',
        },
        { text: '商品タイトル', value: 'title' },
        { text: '画像', value: 'image' },
        { text: '開始価格', value: 'start_price' },
        { text: '即決価格', value: 'buyout_price' },
        { text: '個数', value: 'count' },
        { text: '期間', value: 'period' },
        { text: '終了時間', value: 'end_time' },
        { text: '作成日', value: 'created_at' },
        { text: '更新日', value: 'updated_at' },
        { text: '棚番号', value: 'shelf_id' },
        { text: '在庫ステータス', value: 'inventory_status' },
        { text: 'ZIPファイル出力', value: 'zip_exported' },
        { text: '在庫シール出力', value: 'inventory_seal_exported' }
      ],
 //productリスト
      products: [],
      //テキストボックスの値
      title: "",
    }
  },
  //一覧読み込み
  mounted () {
    axios.get('/api/v1/products').then((response) => {
      this.products = response.data
      }).catch(() => {
        alert("エラー");
      });
  },
  methods: {
    //Product作成
    createProduct() {
      axios.post("/api/v1/products", { title: this.title }).then((response) => {
        this.products.unshift(response.data);
        this.title = "";
      }).catch(() => {
        alert("エラー");
      });
    },
    //checkボックスで発火する済んだかどうかのやつ
    doneChange(index, donechange_id, done_flg) {
      axios.put(`/api/v1/products/${donechange_id}`, { done: done_flg }).then((response) => {
      }).catch(() => {
        alert("エラー");
      });
    },
    //Product削除
    deleteProduct(index, delete_id) {
      axios.delete(`/api/v1/products/${delete_id}`).then((response) => {
        this.products.splice(index, 1);
      }).catch(() => {
        alert("エラー");
      });
    }
  }
}
</script>

<style lang="scss" scoped>
  // ul {
  //   list-style: none;
  //   li {
  //     span.done {
  //       //チェックボックスで発火する取り消し線
  //       text-decoration: line-through;
  //     }
  //   }
  // }
</style>