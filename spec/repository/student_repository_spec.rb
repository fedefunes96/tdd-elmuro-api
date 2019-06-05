require 'date'
require 'rspec'
require 'spec_helper'
require_relative '../../app/model/student'
require_relative '../../repositories/student_repository'

describe 'StudentRepository' do
  let(:repo) { StudentRepository.new }
  let(:student1) do
    student = Student.new('Juan Perez', 'juanperez')
    student
  end
  let(:student2) do
    student = Student.new('Juan Ignacio Perez', 'juanperez')
    student
  end
  let(:student3) do
    student = Student.new('Martin Fenebre', 'martinfene')
    student
  end

  it 'saves correctly' do
    repo.save(student1)

    student_ret = repo.find_by_username('juanperez')

    expect(student_ret.name).to eq('Juan Perez')
  end

  it 'updates correctly' do
    repo.save(student1)
    repo.save(student2)

    student_ret = repo.find_by_username('juanperez')

    expect(student_ret.name).to eq('Juan Ignacio Perez')
  end

  it 'deletes correctly' do
    repo.save(student1)
    repo.delete(student1)

    student_ret = repo.find_by_username('juanperez')

    expect(student_ret).to eq(nil)
  end

  it 'deletes all correctly' do
    repo.save(student1)
    repo.save(student3)
    repo.delete_all

    expect(repo.find_by_username('juanperez')).to eq(nil)
    expect(repo.find_by_username('martinfene')).to eq(nil)
  end
end
