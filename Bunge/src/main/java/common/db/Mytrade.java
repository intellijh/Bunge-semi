package common.db;

import net.trade.db.Likey;
import net.trade.db.Trade;

public class Mytrade {

	private Trade trade = new Trade();
	private Likey likey =new Likey();
	public Mytrade() {
		
	}
	
	public Mytrade(Trade trade, Likey likey) {
		super();
		this.setTrade(trade);
		this.setLikey(likey);
	}
	public Trade getTrade() {
		return trade;
	}
	public void setTrade(Trade trade) {
		this.trade = trade;
	}

	public Likey getLikey() {
		return likey;
	}

	public void setLikey(Likey likey) {
		this.likey = likey;
	}
}
