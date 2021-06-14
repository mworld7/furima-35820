# テーブル設計

## users テーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| email         | string | null: false |
| password      | string | null: false |
| nickname      | string | null: false |
| name          | string | null: false |
| birthday      | data   | null: false |

### Association

- has_many :items
- has_many :purchasers

## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| title        | string     | null: false                    |
| category     | string     | null: false                    |
| condition    | string     | null: false                    |
| postage_by   | string     | null: false                    |
| ship_from    | string     | null: false                    |
| shipping_date| date       | null: false                    |
| price        | integer    | null: false                    |
| image        |            |                                |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :purchasers

## purchasers テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| card_info     | integer    | null: false                    |
| security_code | integer    | null: false                    |
| expiring_date | date       | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| building      | string     | null: false                    |
| phone         | string     | null: false                    |
| purchaser     | references | null: false, foreign_key: true |

### Association

- belongs_to :purchaser