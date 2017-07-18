class PairsController < ApplicationController
  def index
    @pairs = Pair.all
  end

  def show
  end

  def create
    @pair = Pair.create(pair_params)
    magic_match
  end

  def magic_match
    @students = []

    @users = User.all
    @users.each do |user|
      @students << user unless user.admin == true
    end

    loop do
     if @students.length % 2 != 0
       pair = @students.combination(3).to_a.sample
       @pair = Pair.create(pair_params)
       @pair.users = pair
       pair.each do |student|
         @students.delete(student)
       end
     else
       pair = @students.combination(2).to_a.sample
       @pair = Pair.create(pair_params)
       @pair.users = pair
       pair.each do |student|
         @students.delete(student)
        end
     end
       if @students.length == 0
      break
       end
     end
   end



   private
   def pair_params
     params.require(:pair).permit(:date)
   end
end
