#
# 課題１
# テキストボックスで入力データとしてカードの情報を受け付け、ポーカーの役の名前を表示するWeb
# ページを作成してください。
#
# 【入力データの仕様】
# 5枚のカードを半角スペースで区切った文字列が入力されるものとします。
# 例: S1 H3 H4 D9 C13
#
# 【出力データの仕様】
# ユーザーがテキストボックスに入力データを入力し、データをPOSTしたら、入力したカードと役の名前
# を画面に表示してください。
# 例:
#  入力: S8 S7 H6 H5 S4
#  出力:
#   S8 S7 H6 H5 S4
#   ストレート
#
# GET: http://localhost:3000/card
#
class CardController < ApplicationController
  include CardHelper
  def index
  end

  def calc
    @card_id = params[:card_id]
    @card_name = get_hand_name(@card_id)

    render 'show'
  end

end
