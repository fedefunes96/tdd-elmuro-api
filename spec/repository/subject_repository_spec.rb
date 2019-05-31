require 'date'
require 'rspec'
require 'spec_helper'
require_relative '../../app/model/health'
require_relative '../../app/model/subject'
require_relative '../../repositories/subject_repository'

describe 'SubjectRepository' do
  let(:repo) { SubjectRepository.new }
  let(:subject1) do
    subject1 = Subject.new 'Tecnicas de diseño', '75.15'
    subject1
  end
  let(:subject2) do
    subject1 = Subject.new 'Orga de compus', '66.20'
    subject1
  end
  let(:subject3) do
    subject1 = Subject.new 'Tecnicas 2', '75.15'
    subject1
  end

  it 'saves correctly' do
    repo.save(subject1)

    subject_ret = repo.find_by_code('75.15')

    expect(subject_ret.name).to eq('Tecnicas de diseño')
  end

  it 'updates correctly' do
    repo.save(subject1)
    repo.save(subject3)

    subject_ret = repo.find_by_code('75.15')

    expect(subject_ret.name).to eq('Tecnicas 2')
  end

  it 'deletes correctly' do
    repo.save(subject1)
    repo.delete(subject1)

    subject_ret = repo.find_by_code('75.15')

    expect(subject_ret).to eq(nil)
  end

  it 'deletes all correctly' do
    repo.save(subject1)
    repo.save(subject2)
    repo.delete_all

    expect(repo.find_by_code('75.15')).to eq(nil)
    expect(repo.find_by_code('66.20')).to eq(nil)
  end
end
