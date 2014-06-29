class Admin::DebtsController < Admin::BaseController

  

  def index
    @debt_portfolio_positions = Debt.all
  end

  def show
    id = params[:id] # retrieve the creditor's user_ID from URI route
    @debt_portfolio_position = Debt.find(id) # value object holding the portfolio of debts for a creditor
    # will render app/views/admin/debts/show.html.haml by default
  end

  def journals
    creditor_id = params[:creditor_id] 
    debtor_id = params[:debtor_id]
    @creditor_name = User.find_by_id(creditor_id).name
    @journals_for_display_for_contract = Journal.get_journals_for_display_for_contract(creditor_id, debtor_id)
    # will render app/views/admin/debts/journals.html.haml by default
  end

  
  private

  def debt_params
    params.require(:debt).permit(:creditor_id, :debt_portfolio_position)
  end
  
end
