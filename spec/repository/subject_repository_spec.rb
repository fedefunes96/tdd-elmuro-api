require 'date'
require 'rspec'
require 'spec_helper'
require_relative '../../app/model/subject'
require_relative '../../repositories/subject_repository'

describe 'SubjectRepository' do
  let(:repo) { SubjectRepository.new }
  let(:subject1) do
    subject1 = Subject.new('Tecnicas de diseño', '7515', 'NicoPaez', 30, true, false)
    subject1
  end
  let(:subject2) do
    subject1 = Subject.new('Orga de compus', '6620', 'NicoPaez', 15, true, false)
    subject1
  end
  let(:subject3) do
    subject1 = Subject.new('Tecnicas 2', '7515', 'NicoPaez', 10, true, false)
    subject1
  end

  it 'saves correctly' do
    repo.save(subject1)

    subject_ret = repo.find_by_code('7515')

    expect(subject_ret.name).to eq('Tecnicas de diseño')
  end

  it 'updates correctly' do
    repo.save(subject1)
    repo.save(subject3)

    subject_ret = repo.find_by_code('7515')

    expect(subject_ret.name).to eq('Tecnicas 2')
  end

  it 'deletes correctly' do
    repo.save(subject1)
    repo.delete(subject1)

    subject_ret = repo.find_by_code('7515')

    expect(subject_ret).to eq(nil)
  end

  it 'deletes all correctly' do
    repo.save(subject1)
    repo.save(subject2)
    repo.delete_all

    expect(repo.find_by_code('7515')).to eq(nil)
    expect(repo.find_by_code('6620')).to eq(nil)
  end
end
