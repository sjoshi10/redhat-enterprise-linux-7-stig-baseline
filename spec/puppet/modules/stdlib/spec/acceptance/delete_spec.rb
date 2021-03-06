# -*- encoding : utf-8 -*-
#! /usr/bin/env ruby -S rspec
require 'spec_helper_acceptance'

describe 'delete function', :unless => UNSUPPORTED_PLATFORMS.include?(fact('operatingsystem')) do
  describe 'success' do
    it 'should delete elements of the array' do
      pp = <<-EOS
      $output = delete(['a','b','c','b'], 'b')
      if $output == ['a','c'] {
        notify { 'output correct': }
      }
      EOS

      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stdout).to match(/Notice: output correct/)
      end
    end
  end
end
