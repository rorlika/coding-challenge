require 'rails_helper'

describe Security::InputValidator do
  describe '.sanitize' do
    it 'sanitizes string inputs' do
      params = { key1: '<script>alert(1)</script>', key2: 'safe' }
      sanitized_params = Security::InputValidator.sanitize(params)
      expect(sanitized_params[:key1]).to eq('alert(1)')
      expect(sanitized_params[:key2]).to eq('safe')
    end

    it 'sanitizes nested hash inputs' do
      params = { outer: { inner: '<script>alert(1)</script>' } }
      sanitized_params = Security::InputValidator.sanitize(params)
      expect(sanitized_params[:outer][:inner]).to eq('alert(1)')
    end
  end
end