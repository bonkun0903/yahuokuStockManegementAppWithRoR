<template>
  <v-app id="app">
    <v-data-table
      v-model="selected"
      :headers="headers"
      :items="products"
      :single-select="singleSelect"
      item-key="id"
      show-select
      sort-by="calories"
      class="elevation-1"
    >
      <template v-slot:top>
        <v-toolbar
          flat
        >
          <v-toolbar-title>ProductIndex</v-toolbar-title>
          <v-divider
            class="mx-4"
            inset
            vertical
          ></v-divider>
          <v-spacer></v-spacer>
          <v-switch
            v-model="singleSelect"
            label="Single select"
            class="pa-3"
          ></v-switch>
          <v-dialog
            v-model="dialog"
            max-width="500px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="primary"
                dark
                class="mb-2"
                v-bind="attrs"
                v-on="on"
              >
                Add Product
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="text-h5">{{ formTitle }}</span>
              </v-card-title>

              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.title"
                        label="商品タイトル"
                      ></v-text-field>
                    </v-col>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.start_price"
                        label="開始価格"
                      ></v-text-field>
                    </v-col>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.buyout_price"
                        label="即決価格"
                      ></v-text-field>
                    </v-col>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.period"
                        label="期間"
                      ></v-text-field>
                    </v-col>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.end_time"
                        label="終了時間"
                      ></v-text-field>
                    </v-col>
                    <v-col
                      cols="12"
                      sm="6"
                      md="4"
                    >
                      <v-text-field
                        v-model="editedItem.inventory_status"
                        label="在庫ステータス"
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="close"
                >
                  Cancel
                </v-btn>
                <v-btn
                  color="blue darken-1"
                  text
                  @click="save"
                >
                  Save
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <v-dialog v-model="dialogDelete" max-width="500px">
            <v-card>
              <v-card-title class="text-h5">Are you sure you want to delete this item?</v-card-title>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="closeDelete">Cancel</v-btn>
                <v-btn color="blue darken-1" text @click="deleteItemConfirm">OK</v-btn>
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:[`item.actions`]="{ item }">
        <v-icon
          small
          class="mr-2"
          @click="editItem(item)"
        >
          mdi-pencil
        </v-icon>
        <v-icon
          small
          @click="deleteItem(item)"
        >
          mdi-delete
        </v-icon>
      </template>
      <template v-slot:no-data>
        <v-btn
          color="primary"
          @click="initialize"
        >
          Reset
        </v-btn>
      </template>
    </v-data-table>
  </v-app>
</template>

<script>
  import axios from "axios"

  export default {
    data: () => ({
      singleSelect: false,
      selected: [],
      dialog: false,
      dialogDelete: false,
      headers: [
        {
          text: '編集/削除',
          align: 'start',
          sortable: false,
          value: 'actions',
        },
        { text: '管理番号', value: 'id', sortable: false },
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
      products: [],
      editedIndex: -1,
      editedItem: {
        title: '',
        start_price: 0,
        buyout_price: 0,
        period: 0,
        end_time: 0,
        // TODO 棚情報の変更を一覧でも行えるようにする。
        // shelf_id: 0
        inventory_status: 0,
      },
      defaultItem: {
        title: '',
        start_price: 0,
        buyout_price: 0,
        period: 0,
        end_time: 0,
        // TODO 棚情報の変更を一覧でも行えるようにする。
        // shelf_id: 0
        inventory_status: 0,
      },
    }),

    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'Add Product' : 'Edit Product'
      },
    },

    watch: {
      dialog (val) {
        val || this.close()
      },
      dialogDelete (val) {
        val || this.closeDelete()
      },
    },

    // DOM作成前に商品一覧を読みこみ
    created () {
      this.initialize()
    },

    methods: {
      initialize () {
        axios.get('/api/v1/products').then((response) => {
          this.products = response.data
        }).catch(() => {
          alert("エラー");
        });
      },

      editItem (item) {
        this.editedIndex = this.products.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialog = true
      },

      deleteItem (item) {
        this.editedIndex = this.products.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialogDelete = true
      },

      deleteItemConfirm () {
        this.products.splice(this.editedIndex, 1)
        this.closeDelete()
      },

      close () {
        this.dialog = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },

      closeDelete () {
        this.dialogDelete = false
        this.$nextTick(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        })
      },

      save () {
        if (this.editedIndex > -1) {
          Object.assign(this.products[this.editedIndex], this.editedItem)
          // ここでAPIを叩いて保存を行う
          // 作成
          // axios.post("/api/v1/products", { title: this.title }).then((response) => {
          //   this.products.unshift(response.data);
          //   this.title = "";
          // }).catch(() => {
          //   alert("エラー");
          // });

          // 更新
          axios.put(`/api/v1/products/1`, { title: 'axiosによって編集', shelf_id: 1 }).then((response) => {
          }).catch(() => {
            alert("エラー");
          });
        } else {
          this.products.push(this.editedItem)
        }
        this.close()
      },
    },
  }
</script>