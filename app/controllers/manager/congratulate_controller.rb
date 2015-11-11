class Manager::CongratulateController < ApplicationController
  layout "manager"

  def new
  end

  def invite_workers
  end

  def invite_workers2
    worker = params[:worker_email]

    worker.each do |w|
      if !w[1].to_s.blank?
        AdminMailer.invite_worker(w).deliver
      end
    end

    redirect_to "/manager/invite_parents"

  end

  def invite_parents
  end

  def invite_parents2
    parent = params[:parent_email]

    parent.each do |w|
      if !w[1].to_s.blank?
        AdminMailer.invite_parent(w).deliver
      end
    end

    redirect_to "/manager/login"

  end

end