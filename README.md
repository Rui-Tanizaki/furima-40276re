## usersテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| nickname           | string     | null: false                    |
| name_first_kanji   | string     | null: false                    |
| name_first_kana    | string     | null: false                    | 
| name_last_kanji    | string     | null: false                    |
| name_last_kana     | string     | null: false                    |
| birth_date         | date       | null: false                    |

### Association
- has_many :user_items
- has_many :items

## itemsテーブル
| Column                      | Type       | Options                        |
| --------------------------- | ---------- | ------------------------------ |
| item_name                   | string     | null: false                    |
| item_info                   | text       | null: false                    |
| item_price                  | integer    | null: false                    |
| item_category_id            | integer    | null: false                    | 
| item_sales_status_id        | integer    | null: false                    |
| item_shipping_fee_status_id | integer    | null: false                    |
| prefecture_id               | integer    | null: false                    |
| item_scheduled_delivery_id  | integer    | null: false                    |
| user                        | references | null: false, foreign_key: true |

### Association
- has_one :user_item
- belongs_to :user

## ordersテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| order_postcode      | string     | null: false                    |
| prefecture_id       | integer    | null: false                    |
| order_city          | string     | null: false                    |
| order_address       | string     | null: false                    |
| order_building      | string     |                                |
| order_phone_number  | string     | null: false                    |
| user_item           | references | null: false, foreign_key: true |

### Association
- belongs_to :user_item

## user_itemsテーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true | 
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :order