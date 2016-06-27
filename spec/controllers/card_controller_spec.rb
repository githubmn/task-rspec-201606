require 'rails_helper'

describe CardController do
  describe 'GET #index' do
    it 'request 200 OK' do
      get :index

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'POST #index' do
    it 'request 200 OK' do
      post :index

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the :index template" do
      post :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #calc' do
    it 'request 404 Not Found' do
      get :calc

      expect(response.status).to eq(404)
    end
  end

  describe 'POST #calc' do
    context 'response' do
      it 'request 200 OK' do
        post :calc

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the :show template" do
        post :calc

        expect(response).to render_template(:show)
      end
    end

    context "正常系" do
      arrays = [
        ["ストレートフラッシュ", " C7 C6 C5 C4 C3"],
        ["ストレートフラッシュ", " H1  H13 H12 H11 H10"],
        ["ストレートフラッシュ", " S9  S13  S12 S11 S10"],
        ["ストレートフラッシュ", " D9  D6  D7 D8 D5 "],
        ["フォー・オブ・ア・カインド", " C10 D10 H10 S10 D5"],
        ["フォー・オブ・ア・カインド", "D6 H6 S6 C6 S13"],
        ["フルハウス", " S10 H10 D10 S4 D4"],
        ["フルハウス", "H9 C9 S9 H1 C1"],
        ["フラッシュ", " H1 H12 H10 H5 H3"],
        ["フラッシュ", "S13 S12 S11 S9 S6"],
        ["ストレート", " S8 S7 H6 H5 S4"],
        ["ストレート", "D6 S5 D4 H3 C2"],
        ["スリー・オブ・ア・カインド", " S12 C12 D12 S5 C3"],
        ["スリー・オブ・ア・カインド", "C5 H5 D5 D12 C10"],
        ["ツーペア", "H13 D13 C2 D2 H11"],
        ["ツーペア", "D11 S11 S10 C10 S9"],
        ["ワンペア", " C10 S10 S6 H4 H2"],
        ["ワンペア", "H9 C9 H1 D12 D10"],
        ["ハイカード", "D1 D10 S9 C5 C4"],
        ["ハイカード", "C13 D12 C11 H8 H7"]
      ]

      arrays.each { |a|
        it a[0] do
          post :calc, card_id: a[1]

          expect(assigns(:card_id)).to eq(a[1])
          expect(assigns(:card_name)).to eq(a[0])

          expect(response).to be_success
          expect(response.status).to eq(200)
          expect(response).to render_template(:show)
        end
      }
    end

    context "異常系" do
      arrays = [
        ["nil", nil],
        ["空", ""],
        ["不足", "C1 C2 C3 C4"],
        ["超過", "C1 C2 C3 C4 C5 C6"],
        ["スーツが不正:A", "A1 C2 C3 C4 C5"],
        ["スーツが不正:CC", "CC1 C2 C3 C4 C5"],
        ["スーツがなし", "1 C2 C3 C4 C5"],
        ["数字が不正:15", "C15 C2 C3 C4 C5"],
        ["数字が不正:0", "C0 C2 C3 C4 C5"]
      ]

      arrays.each { |a|
        it a[0] do
          post :calc, card_id: a[1]

          expect(assigns(:card_id)).to eq(a[1])
          expect(assigns(:card_name)).to eq('format error')

          expect(response).to be_success
          expect(response.status).to eq(200)
          expect(response).to render_template(:show)
        end
      }
    end
  end

end