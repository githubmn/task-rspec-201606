#
# 課題2
# 入力データとして１組以上のカードの情報を受け付け、入力したカードとポーカーの役の名前、それらの
# 中で最も強い役を返すAPIを作成してください。
#
# 【入力データの仕様】
# 5枚のカードを半角スペースで区切った文字列配列を含むJSONが入力されるものとします。
# 例:
#  {
#   "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ]
#  }
#
# 【出力データの仕様】
# 入力データがPOSTされたら、カード(card)、役の名前(hand)、最も強い役(best)を含む、次のような
# JSONを返してください。
# 同じ役の場合は強弱はないものとします。
#
# POST: http://localhost:3000/api
# content-type: application/json
# raw: { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7" ] }
#
class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  include ApiHelper
  def index
    hands = get_hands(params[:cards])

    render json: { result: hands }
  end

end
