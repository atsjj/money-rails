require 'spec_helper'

describe 'MoneyRails::ActionViewExtension' do
  describe '#currency_symbol' do
    subject { helper.currency_symbol }
    it { should be_a String }
    it { should include Money.default_currency.symbol }
  end

  describe '#humanized_money' do
    before(:each) do
      @default_currency = MoneyRails.default_currency
      @default_no_cents = MoneyRails.no_cents_if_whole
      
      MoneyRails.default_currency = :usd
    end
    
    context 'no_cents_if_whole value is true' do
      subject do
        MoneyRails.no_cents_if_whole = true
        helper.humanized_money Money.new(12500)
      end
      
      it { should be_a String }
      it { should_not include Money.default_currency.symbol }
      it { should_not include Money.default_currency.decimal_mark }
    end
    
    context 'no_cents_if_whole value is false' do
      subject do
        MoneyRails.no_cents_if_whole = false
        helper.humanized_money Money.new(12500)
      end
      
      it { should be_a String }
      it { should_not include Money.default_currency.symbol }
      it { should include Money.default_currency.decimal_mark }
    end
    
    context 'no_cents_if_whole value is nil' do
      subject do
        MoneyRails.no_cents_if_whole = nil
        helper.humanized_money Money.new(12500)
      end
      
      it { should be_a String }
      it { should_not include Money.default_currency.symbol }
      it { should include Money.default_currency.decimal_mark }
    end
    
    after(:each) do
      MoneyRails.default_currency = @default_currency
      MoneyRails.no_cents_if_whole = @default_no_cents
    end
  end

  describe '#humanized_money_with_symbol' do
    subject { helper.humanized_money_with_symbol Money.new(12500) }
    it { should be_a String }
    it { should_not include Money.default_currency.decimal_mark }
    it { should include Money.default_currency.symbol }
  end

  describe '#money_without_cents' do
    subject { helper.money_without_cents Money.new(12500) }
    it { should be_a String }
    it { should_not include Money.default_currency.symbol }
    it { should_not include Money.default_currency.decimal_mark }
  end

  describe '#money_without_cents_and_with_symbol' do
    subject { helper.money_without_cents_and_with_symbol Money.new(12500) }
    it { should be_a String }
    it { should_not include Money.default_currency.decimal_mark }
    it { should include Money.default_currency.symbol }
  end
end
