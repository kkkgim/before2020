package lim;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ItemListener;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.io.Serializable;
import java.awt.event.ActionEvent;

class Draw implements Serializable {
	private int x, y, x1, y1;
	private int dist;

	public int getDist() {
		return dist;
	}
	public void setDist(int dist) {
		this.dist = dist;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public int getX1() {
		return x1;
	}
	public void setX1(int x1) {
		this.x1 = x1;
	}
	public int getY1() {
		return y1;
	}
	public void setY1(int y1) {
		this.y1 = y1;
	}
}

public class Pass extends JFrame{
	public Pass() {
		getContentPane().setLayout(null);
		JPanel panel = new JPanel();
		panel.setBackground(new Color(255, 218, 185));
		panel.setBounds(0, 0, 834, 107);
		getContentPane().add(panel);
		panel.setLayout(null);
		
		JMenuBar menuBar = new JMenuBar();
		menuBar.setBounds(0, 0, 49, 29);
		panel.add(menuBar);
		
		JMenu mnNewMenu = new JMenu("");
		menuBar.add(mnNewMenu);
		mnNewMenu.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uBA54\uB274\uBC14 2.PNG"));
		
		JMenuItem menuopen = new JMenuItem("\uD30C\uC77C \uC5F4\uAE30");
		mnNewMenu.add(menuopen);
		
		JMenuItem menusave = new JMenuItem("\uD30C\uC77C \uC800\uC7A5");
		mnNewMenu.add(menusave);
		
		JMenuItem menuchangesave = new JMenuItem("\uB2E4\uB978 \uC774\uB984\uC73C\uB85C \uC800\uC7A5");
		mnNewMenu.add(menuchangesave);
		
		JMenuItem menuprint = new JMenuItem("\uC778\uC1C4");
		mnNewMenu.add(menuprint);
		
		JMenuItem menuexit = new JMenuItem("\uB05D\uB0B4\uAE30");
		mnNewMenu.add(menuexit);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(0, 0, 834, 107);
		tabbedPane.setBackground(Color.WHITE);
		panel.add(tabbedPane);
		
		JPanel panel_4 = new JPanel();
		panel_4.setBackground(new Color(255, 218, 185));
		tabbedPane.addTab("편집", null, panel_4, null);
		
		JPanel panel_2 = new JPanel();
		panel_2.setForeground(new Color(255, 218, 185));
		panel_2.setBackground(new Color(255, 218, 185));
		tabbedPane.addTab(" 홈 ", null, panel_2, null);
		panel_2.setLayout(null);
		
		JButton pen = new JButton("");
		pen.setBounds(33, 10, 28, 28);
		panel_2.add(pen);
		pen.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\pencil_normal.jpg"));
		JButton eraser = new JButton("");
		eraser.setBounds(33, 40, 28, 28);
		panel_2.add(eraser);
		eraser.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\eraser_normal.jpg"));
		
		JButton back = new JButton("");
		back.setBounds(62, 40, 28, 28);
		panel_2.add(back);
		back.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\Undo.JPG"));
		
		JButton fill = new JButton("");
		fill.setBounds(62, 10, 28, 28);
		panel_2.add(fill);
		fill.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCC44\uC6B0\uAE30.PNG"));
		
		JButton pont = new JButton("");
		pont.setBounds(91, 10, 28, 28);
		panel_2.add(pont);
		pont.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\string_normal.jpg"));
		
		JButton front = new JButton("");
		front.setBounds(91, 40, 28, 28);
		panel_2.add(front);
		front.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\Redo.JPG"));
		
		JButton line = new JButton("");
		line.setBounds(183, 10, 26, 26);
		panel_2.add(line);
		line.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC120.PNG"));
		
		JButton four = new JButton("");
		four.setBounds(183, 38, 26, 26);
		panel_2.add(four);
		four.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0AC\uAC01\uD615.PNG"));
		
		JButton round = new JButton("");
		round.setBounds(211, 38, 26, 26);
		panel_2.add(round);
		round.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uB465\uADFC\uC0AC\uAC01\uD615.PNG"));
		
		JButton three = new JButton("");
		three.setBounds(211, 10, 26, 26);
		panel_2.add(three);
		three.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0BC\uAC01\uD615.PNG"));
		
		JButton five = new JButton("");
		five.setBounds(239, 10, 26, 26);
		panel_2.add(five);
		five.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC624\uAC012.PNG"));
		
		JButton ovar = new JButton("");
		ovar.setBounds(239, 38, 26, 26);
		panel_2.add(ovar);
		ovar.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC6D0.PNG"));
		
		JButton fillc = new JButton("");
		fillc.setBounds(267, 38, 26, 26);
		panel_2.add(fillc);
		fillc.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCC44\uC6B4\uB3C4\uD615.PNG"));
		
		JButton star = new JButton("");
		star.setBounds(267, 10, 26, 26);
		panel_2.add(star);
		star.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uBCC4.PNG"));
		
		JSlider slider = new JSlider();
		slider.setBounds(375, 31, 115, 28);
		panel_2.add(slider);
		slider.setBackground(new Color(255, 218, 185));
		
		JButton black = new JButton("");
		black.setBounds(525, 8, 20, 19);
		panel_2.add(black);
		black.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\black.jpg"));
		
		JButton blue = new JButton("");
		blue.setBounds(525, 29, 20, 19);
		panel_2.add(blue);
		blue.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Blue.jpg"));
		
		JButton pu = new JButton("");
		pu.setBounds(547, 29, 20, 19);
		panel_2.add(pu);
		pu.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Wine.jpg"));
		
		JButton red = new JButton("");
		red.setBounds(547, 8, 20, 19);
		panel_2.add(red);
		red.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Red.jpg"));
		
		JButton orange = new JButton("");
		orange.setBounds(569, 8, 20, 19);
		panel_2.add(orange);
		orange.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Orange.jpg"));
		
		JButton bio = new JButton("");
		bio.setBounds(569, 29, 20, 19);
		panel_2.add(bio);
		bio.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\violet.jpg"));
		
		JButton gray = new JButton("");
		gray.setBounds(591, 29, 20, 19);
		panel_2.add(gray);
		gray.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\gray.jpg"));
		
		JButton yellow = new JButton("");
		yellow.setBounds(591, 8, 20, 19);
		panel_2.add(yellow);
		yellow.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Yellow.jpg"));
		
		JButton green = new JButton("");
		green.setBounds(613, 8, 20, 19);
		panel_2.add(green);
		green.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Green.jpg"));
		
		JButton grayy = new JButton("");
		grayy.setBounds(613, 29, 20, 19);
		panel_2.add(grayy);
		grayy.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Gray2.jpg"));
		
		JButton pink = new JButton("");
		pink.setBounds(635, 29, 20, 19);
		panel_2.add(pink);
		pink.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Pink.jpg"));
		
		JButton sky = new JButton("");
		sky.setBounds(635, 8, 20, 19);
		panel_2.add(sky);
		sky.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Sky.jpg"));
		
		JButton colorchange = new JButton("");
		colorchange.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0C9\uD3B8\uC9D1.PNG"));
		colorchange.setBounds(703, 0, 41, 70);
		panel_2.add(colorchange);
		
		JLabel lblNewLabel = new JLabel("      \uC120 \uAD75\uAE30 \uC870\uC808");
		lblNewLabel.setBounds(375, 10, 115, 21);
		panel_2.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("\uB3C4\uAD6C");
		lblNewLabel_1.setBounds(129, 31, 28, 15);
		panel_2.add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("\uB3C4\uD615");
		lblNewLabel_2.setBounds(305, 31, 28, 15);
		panel_2.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("\uC0C9");
		lblNewLabel_3.setBounds(585, 53, 14, 15);
		panel_2.add(lblNewLabel_3);
		
		JPanel panel_3 = new JPanel();
		panel_3.setBackground(new Color(255, 218, 185));
		tabbedPane.addTab("보기", null, panel_3, null);
		panel_3.setLayout(null);
		
		JButton big = new JButton("");
		big.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uD655\uB300.PNG"));
		big.setBounds(12, 10, 41, 58);
		panel_3.add(big);
		
		JButton small = new JButton("");
		small.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
			}
		});
		small.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCD95\uC18C2.PNG"));
		small.setBounds(65, 10, 41, 58);
		panel_3.add(small);
		
		JButton sizeback = new JButton("");
		sizeback.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC6D0\uB798\uD06C\uAE30.PNG"));
		sizeback.setBounds(118, 5, 44, 68);
		panel_3.add(sizeback);
		
		JButton button = new JButton("");
		button.setIcon(new ImageIcon("C:\\Users\\cic\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC804\uCCB4\uD654\uBA74.PNG"));
		button.setBounds(177, 5, 44, 68);
		panel_3.add(button);
		blue.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
			}
		});
		
		JPanel panel_1 = new JPanel();
		panel_1.setBounds(0, 103, 834, 386);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		setTitle("그림판");
		setSize(849, 528);
		setVisible(true);
	}
	public static void main(String[] args) {
		new Pass();
	}

}
