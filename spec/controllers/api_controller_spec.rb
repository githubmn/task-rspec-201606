require 'rails_helper'

describe ApiController do
  describe 'GET #index' do
    it 'request 404 Not Found' do
      get :index

      expect(response.status).to eq(404)
    end
  end

  describe 'POST #index' do
    context 'response' do
      it 'request 200 OK' do
        post :index

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "json the :index template" do
        post :index

        json = JSON.parse(response.body)
        expect(json).to eq({"result"=>[]})
      end
    end

    context "正常系：最強あり" do
      cards =
      [
        "D1 D10 S9 C5 C4", # ハイカード
        " C10 S10 S6 H4 H2", # ワンペア
        "H13 D13 C2 D2 H11", # ツーペア
        " S12 C12 D12 S5 C3", # スリー・オブ・ア・カインド
        " S8 S7 H6 H5 S4", # ストレート
        " H1 H12 H10 H5 H3", # フラッシュ
        " S10 H10 D10 S4 D4", # フルハウス
        " C10 D10 H10 S10 D5", # フォー・オブ・ア・カインド
        " C7 C6 C5 C4 C3" # ストレートフラッシュ
      ]

      results =
      [
        {"card" => " C7 C6 C5 C4 C3", "hand" => "ストレートフラッシュ", "best" => true},
        {"card" => " C10 D10 H10 S10 D5", "hand" => "フォー・オブ・ア・カインド"},
        {"card" => " S10 H10 D10 S4 D4", "hand" => "フルハウス"},
        {"card" => " H1 H12 H10 H5 H3", "hand" => "フラッシュ"},
        {"card" => " S8 S7 H6 H5 S4", "hand" => "ストレート"},
        {"card" => " S12 C12 D12 S5 C3", "hand" => "スリー・オブ・ア・カインド"},
        {"card" => "H13 D13 C2 D2 H11", "hand" => "ツーペア"},
        {"card" => " C10 S10 S6 H4 H2", "hand" => "ワンペア"},
        {"card" => "D1 D10 S9 C5 C4", "hand" => "ハイカード"}
      ]

      it "最強あり" do
        post :index, { cards: cards }

        json = JSON.parse(response.body)
        expect(json['result']).to eq(results)
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context "正常系：強弱なし" do
      cards =
      [
        " C10 D10 H10 S10 D5", # フォー・オブ・ア・カインド
        " C7 C6 C5 C4 C3", # ストレートフラッシュ
        " H1  H13 H12 H11 H10" # ストレートフラッシュ
      ]

      results =
      [
        {"card" => " C7 C6 C5 C4 C3", "hand" => "ストレートフラッシュ"},
        {"card" => " H1  H13 H12 H11 H10", "hand" => "ストレートフラッシュ"},
        {"card" => " C10 D10 H10 S10 D5", "hand" => "フォー・オブ・ア・カインド"}
      ]

      it "強弱なし" do
        post :index, { cards: cards }

        json = JSON.parse(response.body)
        expect(json['result']).to eq(results)
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context "正常系：1つのみ" do
      cards =
      [
        " C7 C6 C5 C4 C3" # ストレートフラッシュ
      ]

      results =
      [
        {"card" => " C7 C6 C5 C4 C3", "hand" => "ストレートフラッシュ"}
      ]

      it "1つのみ" do
        post :index, { cards: cards }

        json = JSON.parse(response.body)
        expect(json['result']).to eq(results)
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context "異常系：入力なし" do
      cards = []
      results = []

      it "入力なし" do
        post :index, { cards: cards }

        json = JSON.parse(response.body)
        expect(json['result']).to eq(results)
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end

    context "異常系：不正含む" do
      cards =
      [
        " S10 H10 D10 S4 D4", # フルハウス
        " C10 D10 H10 S10 D55", # フォー・オブ・ア・カインド：不正
        " C7 C6 C5 C4 C3" # ストレートフラッシュ
      ]

      results =
      [
        {"card" => " C7 C6 C5 C4 C3", "hand" => "ストレートフラッシュ", "best" => true},
        {"card" => " S10 H10 D10 S4 D4", "hand" => "フルハウス"},
        {"card" => " C10 D10 H10 S10 D55", "hand" => "format error"}
      ]

      it "不正含む" do
        post :index, { cards: cards }

        json = JSON.parse(response.body)
        expect(json['result']).to eq(results)
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end
  end

end