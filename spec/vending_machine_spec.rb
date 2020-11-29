require './lib/vending_machine'

RSpec.describe 'VendingMachine' do
  let(:drinks) do
    [
      { name: :cola, price: 100 },
      { name: :oolong, price: 100 },
      { name: :rooibos, price: 100 },
      { name: :redbull, price: 200 },
      { name: :beer, price: 300 }
    ].map { |drink| Drink.new(**drink) }
  end
  let(:vending_machine) { VendingMachine.new(drinks) }

  context '飲み物購入ボタンを押した場合' do
    subject { vending_machine.push_button(drink) }

    context '100円を入れた場合' do
      before do
        vending_machine.insert(100)
      end

      context 'コーラのボタンを押した場合' do
        let(:drink) { :cola }

        it 'コーラがでる' do
          is_expected.to eq [:cola, 0]
        end
      end

      context '烏龍茶のボタンを押した場合' do
        let(:drink) { :oolong }

        it '烏龍茶がでる' do
          is_expected.to eq [:oolong, 0]
        end
      end

      context 'ルイボスのボタンを押した場合' do
        let(:drink) { :rooibos }

        it 'ルイボスがでる' do
          is_expected.to eq [:rooibos, 0]
        end
      end

      context 'レッドブルのボタンを押した場合' do
        let(:drink) { :redbull }

        it 'レッドブルは金額不足で買えない' do
          is_expected.to eq nil
        end
      end

      context 'ビールのボタンを押した場合' do
        let(:drink) { :beer }

        it 'ビールが出ない' do
          is_expected.to eq nil
        end
      end
    end

    context '200円入れた場合' do
      before do
        vending_machine.insert(100)
        vending_machine.insert(100)
      end

      context 'レッドブルのボタンを押した場合' do
        let(:drink) { :redbull }

        it 'レッドブルがでる' do
          is_expected.to eq [:redbull, 0]
        end
      end

      context 'コーラのボタンを押した場合' do
        let(:drink) { :cola }

        it 'コーラと100円のお釣りが出てくる' do
          is_expected.to eq [:cola, 100]
        end
      end

      context 'ビールのボタンを押した場合' do
        let(:drink) { :beer }

        it '何も出ない' do
          is_expected.to eq nil
        end
      end
    end

    context '300円入れた場合' do
      before do
        vending_machine.insert(100)
        vending_machine.insert(100)
        vending_machine.insert(100)
      end

      context 'ビールのボタンを押した場合' do
        let(:drink) { :beer }

        it 'ビールがでる' do
          is_expected.to eq [:beer, 0]
        end
      end
    end

    context '何も入れていない場合' do
      let(:drink) { nil }

      it '何もでない' do
        is_expected.to eq nil
      end
    end
  end

  context 'お金を入れたがキャンセルボタンを押した場合' do
    subject { vending_machine.cancel }

    context '10円の場合' do
      before do
        vending_machine.insert(10)
      end

      it '10円が返ってくる' do
        is_expected.to eq [nil, 10]
      end
    end

    context '50円の場合' do
      before do
        vending_machine.insert(50)
      end

      it '50円が返ってくる' do
        is_expected.to eq [nil, 50]
      end
    end

    context '100円の場合' do
      before do
        vending_machine.insert(100)
      end

      it '100円が返ってくる' do
        is_expected.to eq [nil, 100]
      end
    end

    context '500円の場合' do
      before do
        vending_machine.insert(500)
      end

      it '500円が返ってくる' do
        is_expected.to eq [nil, 500]
      end
    end
  end
end
