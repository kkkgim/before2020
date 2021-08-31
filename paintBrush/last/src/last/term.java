package last;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ItemListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.io.Serializable;
import java.util.Vector;
import java.awt.event.ActionEvent;
import java.awt.*;
import java.awt.event.*; 
import java.io.*;
import java.util.*; //����
import java.util.List;
import javax.swing.*;
import java.util.Vector;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JColorChooser;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JToolBar;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;

class Draw implements Serializable
{
	private int x, y, x1, y1;//��ǥ ����
	private int dist;//���� ����
	private int toolfill=0; //ä��� ����
	public int getfill() {return toolfill;}
	public void setfill(int toolfill) {this.toolfill = toolfill;}
	public int getDist() {return dist;}
	public void setDist(int dist) {this.dist = dist;}
	public int getX() {return x;}
	public void setX(int x) {this.x = x;}
	public int getY() {return y;}
	public void setY(int y) {this.y = y;}
	public int getX1() {return x1;}
	public void setX1(int x1) {this.x1 = x1;}
	public int getY1() {return y1;}
	public void setY1(int y1) {this.y1 = y1;}
}

public class term extends JFrame implements ActionListener ,MouseListener,MouseMotionListener
{
	int x, y, x1, y1; //���콺�� ���������� ������ �� ��ǥ��
	Vector vc = new Vector();//���� ����
	Vector vcolor = new Vector();//�� ����
	Vector undobuffer = new Vector();//�ǵ����� ���� ����
	Color Color1=Color.BLACK; //�ʱⰪ black���� ����
	Color Color2;//�÷������� ����� ����
	int dist = 0;
	int fillnum=0;//ä��� �ɼǿ��� �����ȴ�.
	int pointSize = 3;
	int width=0;//Ȯ��� ���, ��üȭ�鿡�� ���� ũ��
	JFileChooser chooser;//���� chooser
	JLabel imageLabel = new JLabel();
	private JPanel p = new JPanel();
	private BorderLayout bl = new BorderLayout();
	private FlowLayout fl = new FlowLayout(FlowLayout.RIGHT);
	
	public term(String title)
	{
		setBackground(new Color(255, 255, 255));
		start();
		getContentPane().setLayout(null);
		JPanel panel = new JPanel();
		panel.setBackground(new Color(255, 255, 255));
		panel.setBounds(0, 0, 834, 107);
		getContentPane().add(panel);
		panel.setLayout(null);
		chooser = new JFileChooser();
		panel.add(imageLabel);
		JMenuBar menuBar = new JMenuBar();
		menuBar.setBounds(0, 0, 49, 29);
		panel.add(menuBar);
		
		JMenu mnNewMenu = new JMenu("");
		menuBar.add(mnNewMenu);
		mnNewMenu.setIcon(new ImageIcon("C:\\Users\\Com\\eclipse-workspace\\last\\src\\last\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uBA54\uB274\uBC14 2.PNG"));
		
		JMenuItem menuopen = new JMenuItem("\uD30C\uC77C \uC5F4\uAE30");
		menuopen.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				FileDialog fidig= new FileDialog(new JFrame(),"����",FileDialog.LOAD);//���� ���̾�α� ����
				fidig.setVisible(true);
				
				String dir = fidig.getDirectory();//���丮�� �ޱ�
				String file = fidig.getFile();//���ϸ� �ޱ�
				
				if(dir== null|| file == null)//���丮��� ���ϸ��� null���̸�
					return;
				try
				{
					ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(new FileInputStream(new File(dir,file))));
					vc = (Vector<Draw>)(ois.readObject());//�޾ƿ� ������ ����
					vcolor=(Vector)ois.readObject();//�÷���������
					ois.close();//�ݱ�
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
			}
		});
		JMenuItem menuItem = new JMenuItem("\uC0C8\uB85C\uB9CC\uB4E4\uAE30");
		menuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				vc.clear();//���� �ʱ�ȭ
				vcolor.clear();//�÷����� �ʱ�ȭ
				undobuffer.clear();//���� �ʱ�ȭ
				x=y=x1=y1=dist=fillnum=0;//��ǥ��� ��簪 �ʱ�ȭ
				Color1=Color.BLACK;
				width=0;
				pointSize=3;//��Ʈ ������ �ʱ�ȭ
				repaint();//�ʱ�ȭ �� �ٽ� �׸���
			}
		});
		mnNewMenu.add(menuItem);
		mnNewMenu.add(menuopen);
		
		JMenuItem menusave = new JMenuItem("\uD30C\uC77C \uC800\uC7A5");
		menusave.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e)
			{
				FileDialog fidig = new FileDialog(new JFrame(), "����", FileDialog.SAVE);
				   fidig.setVisible(true);
				   String dir = fidig.getDirectory();
				   String file = fidig.getFile();
				   if(dir == null || file == null) 
				    return ;
				   try 
				   {
				    ObjectOutputStream ois =  new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream(new File(dir,file))));
				    ois.writeObject(vc);//���� ���� ����
				    ois.writeObject(vcolor);//�÷� ���� ����
				    ois.close();
				   }
				   catch(Exception ee)
				   {
					   ee.printStackTrace();
				   }
			}
		});
		mnNewMenu.add(menusave);
		
		JMenuItem menuchangesave = new JMenuItem("\uB2E4\uB978 \uC774\uB984\uC73C\uB85C \uC800\uC7A5");
		mnNewMenu.add(menuchangesave);
		
		JMenuItem menuprint = new JMenuItem("\uC778\uC1C4");
		mnNewMenu.add(menuprint);
		
		JMenuItem menuexit = new JMenuItem("\uB05D\uB0B4\uAE30");
		menuexit.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				  System.exit(0);//�ý��� ����
			}
			
		});
		mnNewMenu.add(menuexit);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.setBounds(0, 0, 834, 107);
		tabbedPane.setBackground(Color.WHITE);
		panel.add(tabbedPane);
		
		JPanel panel_4 = new JPanel();
		panel_4.setBackground(new Color(255, 255, 255));
		tabbedPane.addTab("����", null, panel_4, null);
		tabbedPane.setBackgroundAt(0, new Color(255, 255, 255));
		
		JPanel panel_2 = new JPanel();
		panel_2.setForeground(new Color(255, 218, 185));
		panel_2.setBackground(new Color(255, 255, 255));
		tabbedPane.addTab(" Ȩ ", null, panel_2, null);
		tabbedPane.setBackgroundAt(1, new Color(255, 255, 255));
		panel_2.setLayout(null);
		
		JButton pen = new JButton("");
		pen.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				dist=0;//��
			}
		});
		pen.setBounds(33, 10, 28, 28);
		panel_2.add(pen);
		pen.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\pencil_normal.jpg"));
		JButton eraser = new JButton("");
		eraser.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist= 10;//���찳
			}
		});
		eraser.setBounds(33, 40, 28, 28);
		panel_2.add(eraser);
		eraser.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\eraser_normal.jpg"));
		
		JButton back = new JButton("");
		back.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int i=vc.size();//���� ������ ��ŭ �޾ƿ���
				Draw d = (Draw)vc.elementAt(i-1); //������ ���Ͱ� ����
				undobuffer.add(d);//���Ͱ� ���ۿ� ����
				vc.remove(i-1);//������ ���Ͱ� �����
				repaint();
			}
		});
		back.setBounds(62, 40, 28, 28);
		panel_2.add(back);
		back.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\Undo.JPG"));
		
		JButton fill = new JButton("");
		fill.setBounds(62, 10, 28, 28);
		panel_2.add(fill);
		fill.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCC44\uC6B0\uAE30.PNG"));
		
		JButton pont = new JButton("");
		pont.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JLabel[] text = null;
				int i=0;
				text[i]=new JLabel();
				
			}
		});
		pont.setBounds(91, 10, 28, 28);
		panel_2.add(pont);
		pont.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\string_normal.jpg"));
		
		JButton front = new JButton("");
		front.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int i=undobuffer.size();//���� ������ �޾ƿ���
				Draw d = (Draw)undobuffer.elementAt(i-1);//������ �� �޾ƿ���
				vc.add(d);//���Ϳ� ����
				undobuffer.remove(i-1);//���۰� �����
				repaint();
			}
		});
		front.setBounds(91, 40, 28, 28);
		panel_2.add(front);
		front.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\Redo.JPG"));
		
		JButton line = new JButton("");
		line.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=1;
			}
		});
		line.setBounds(183, 10, 26, 26);
		panel_2.add(line);
		line.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC120.PNG"));
		
		JButton four = new JButton("");
		four.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=3;
			}
		});
		four.setBounds(183, 38, 26, 26);
		panel_2.add(four);
		four.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0AC\uAC01\uD615.PNG"));
		
		JButton round = new JButton("");
		round.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=6;
			}
		});
		round.setBounds(211, 38, 26, 26);
		panel_2.add(round);
		round.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uB465\uADFC\uC0AC\uAC01\uD615.PNG"));
		
		JButton three = new JButton("");
		three.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=4;
			}
		});
		three.setBounds(211, 10, 26, 26);
		panel_2.add(three);
		three.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0BC\uAC01\uD615.PNG"));
		
		JButton five = new JButton("");
		five.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=5;
			}
		});
		five.setBounds(239, 10, 26, 26);
		panel_2.add(five);
		five.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC624\uAC012.PNG"));
		
		JButton ovar = new JButton("");
		ovar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				dist=2;
			}
		});
		ovar.setBounds(239, 38, 26, 26);
		panel_2.add(ovar);
		ovar.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC6D0.PNG"));
		
		JButton fillc = new JButton("");
		fillc.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(fillnum==1)
					fillnum=0;//ä��� ����
				else
					fillnum=1;//ä��� ����
			}
		});
		fillc.setBounds(267, 38, 26, 26);
		panel_2.add(fillc);
		fillc.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCC44\uC6B4\uB3C4\uD615.PNG"));
		
		JButton star = new JButton("");
		star.setBounds(267, 10, 26, 26);
		panel_2.add(star);
		star.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uBCC4.PNG"));
		
		JSlider slider = new JSlider(JSlider.HORIZONTAL,0,100,50);

		slider.setBounds(375, 31, 115, 28);
		panel_2.add(slider);
		slider.setBackground(new Color(255, 218, 185));
		
		JButton black = new JButton("");
		black.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.BLACK;
			}
		});
		black.setBounds(525, 8, 20, 19);
		panel_2.add(black);
		black.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\black.jpg"));
		
		JButton blue = new JButton("");
		blue.setBounds(525, 29, 20, 19);
		panel_2.add(blue);
		blue.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Blue.jpg"));
		
		JButton pu = new JButton("");
		pu.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1 =new Color(128,000,128);
			}
		});
		pu.setBounds(547, 29, 20, 19);
		panel_2.add(pu);
		pu.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Wine.jpg"));
		
		JButton red = new JButton("");
		red.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.RED;
			}
		});
		red.setBounds(547, 8, 20, 19);
		panel_2.add(red);
		red.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Red.jpg"));
		
		JButton orange = new JButton("");
		orange.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.ORANGE;
			}
		});
		orange.setBounds(569, 8, 20, 19);
		panel_2.add(orange);
		orange.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Orange.jpg"));
		
		JButton bio = new JButton("");
		bio.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1 =new Color(238,130,238);
			}
		});
		bio.setBounds(569, 29, 20, 19);
		panel_2.add(bio);
		bio.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\violet.jpg"));
		
		JButton gray = new JButton("");
		gray.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.DARK_GRAY;
			}
		});
		gray.setBounds(591, 29, 20, 19);
		panel_2.add(gray);
		gray.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\gray.jpg"));
		
		JButton yellow = new JButton("");
		yellow.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.YELLOW;
			}
		});
		yellow.setBounds(591, 8, 20, 19);
		panel_2.add(yellow);
		yellow.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Yellow.jpg"));
		
		JButton green = new JButton("");
		green.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.GREEN;
			}
		});
		green.setBounds(613, 8, 20, 19);
		panel_2.add(green);
		green.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Green.jpg"));
		
		JButton grayy = new JButton("");
		grayy.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.gray;
			}
		});
		grayy.setBounds(613, 29, 20, 19);
		panel_2.add(grayy);
		grayy.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Gray2.jpg"));
		
		JButton pink = new JButton("");
		pink.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Color1=Color.PINK;
			}
		});
		pink.setBounds(635, 29, 20, 19);
		panel_2.add(pink);
		pink.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Pink.jpg"));
		
		JButton sky = new JButton("");
		sky.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			Color1 = new Color(135, 206, 235);
			}
		});
		sky.setBounds(635, 8, 20, 19);
		panel_2.add(sky);
		sky.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\Sky.jpg"));
		
		JButton colorchange = new JButton("");
		colorchange.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				JColorChooser chooser = new JColorChooser();//colorchooser�����
				Color selectedColor = chooser.showDialog(null,"Color",Color.YELLOW);
				Color1 = selectedColor;//���õȻ� �ֱ�
			}
		});
		colorchange.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC0C9\uD3B8\uC9D1.PNG"));
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
		panel_3.setBackground(new Color(255, 255, 255));
		tabbedPane.addTab("����", null, panel_3, null);
		tabbedPane.setBackgroundAt(2, new Color(255, 255, 255));
		panel_3.setLayout(null);
		
		JButton big = new JButton("");
		big.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				width=width+100;//width ũ�� �ø���
				Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
				Dimension frm = getSize();
				int xpos = (int) (screen.getWidth()/2+width);//width��ŭ �ø���
				int ypos = (int) (screen.getHeight()/2+width);//width��ŭ �ø���
				resize(xpos,ypos);//�缳��
				setLocation(273, 273);
				setVisible(true);
			}
		});
		big.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uD655\uB300.PNG"));
		big.setBounds(12, 10, 41, 58);
		panel_3.add(big);
		
		JButton small = new JButton("");
		small.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				width=width-100;//width ũ�� ����
				Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
				Dimension frm = getSize();
				int xpos = (int) (screen.getWidth()/2+width);//width��ŭ �ø���
				int ypos = (int) (screen.getHeight()/2+width);//width��ŭ �ø���
				resize(xpos,ypos);//�缳��
				setLocation(273, 273);
				setVisible(true);
			}
		});
		small.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uCD95\uC18C2.PNG"));
		small.setBounds(65, 10, 41, 58);
		panel_3.add(small);
		
		JButton sizeback = new JButton("");
		sizeback.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC6D0\uB798\uD06C\uAE30.PNG"));
		sizeback.setBounds(118, 5, 44, 68);
		panel_3.add(sizeback);
		
		JButton button = new JButton("");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
				Dimension frm = getSize();//������ޱ�
				int xpos = (int) (screen.getWidth());//xȭ��ũ��ޱ�
				int ypos = (int) (screen.getHeight());//yȭ��ũ��ޱ�
				resize(xpos,ypos);//������ �缳��
				setLocation(1, 1);
				setVisible(true);
			}
		});
		button.setIcon(new ImageIcon("C:\\Users\\Com\\Desktop\\\uC0C8 \uD3F4\uB354 (2)\\\uB3C4\uD615\\\uC804\uCCB4\uD654\uBA74.PNG"));
		button.setBounds(177, 5, 44, 68);
		panel_3.add(button);
		
		blue.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				Color1=Color.BLUE;
			}
		});
		Toolkit tk = Toolkit.getDefaultToolkit();
		Image img_buffer=null;
		Graphics buffer =null;
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(Color.WHITE);
		panel_1.setLocation(1, 1);
		getContentPane().add(panel_1);
		panel_1.setLayout(null);
		setTitle(title);
		setSize(849, 528);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
		Dimension frm = super.getSize();
		int xpos = (int) (screen.getWidth());
		int ypos = (int) (screen.getHeight());
		panel_1.setSize(xpos,ypos);//�г� ����� ȭ��ũ�⸸ŭ
		xpos = (int) (screen.getWidth()/ 2 - frm.getWidth() / 2);
		ypos = (int) (screen.getHeight() / 2 - frm.getHeight() / 2);
		super.setLocation(xpos, ypos);
		setVisible(true);
		
	}
	public void start() 
	{
	// window�� X��ư�� ������ window�� �����϶�
		this.addWindowListener(new WindowAdapter() 
		{
			public void windowClosing(WindowEvent e) 
			{
				
				System.exit(0);
			}
		});
	this.addMouseListener(this);
	this.addMouseMotionListener(this);//���콺�� �����̴� ���� �׷����� ����� ���� �̺�Ʈ
	}
	

	public void paint(Graphics g) 
	{
		   super.paint(g);//�гο� �׷��ش�.
		    for(int i = 0; i < vc.size(); ++i)
		    {    
		    	  Draw d = (Draw)vc.elementAt(i);
		    	  Color2=(Color) vcolor.elementAt(i);//�������� �ҷ��´�.
				  g.setColor(Color2);//���� ����
				 if(d.getfill()==1)//ä��� �����̶��
				 {
		    	  if(d.getDist() == 1)
		    		  g.drawLine(d.getX()-width/2,d.getY()-width/2,d.getX1()+width/2, d.getY1()+width/2);//width�� Ȯ�볪 ����Ѹ�ŭ Ŀ���ų� �۾����� ���� ����
		    	  else if(d.getDist() == 2)
		    		  g.fillOval(d.getX()-width/2, d.getY()-width/2, (d.getX1()+width/2) - (d.getX()-width/2),(d.getY1()+width/2 - (d.getY()-width/2)));
		    	  else if(d.getDist() == 3) 
		    		  g.fillRect(d.getX()-width/2, d.getY()-width/2, d.getX1()+width/2 - (d.getX()-width/2), (d.getY1()+width/2) - (d.getY()-width/2));
		    	  else if(d.getDist() == 4)//�ﰢ���϶�
		    		  g.fillPolygon(getArrayX(d.getX()-width/2,d.getX1()+width/2), getArrayY(d.getY()-width/2,d.getY1()+width/2), 3);
		    	  else if(d.getDist()==5)//5�����϶�
		    		  g.fillPolygon(getArrayX1(d.getX()-width/2,d.getX1()+width/2), getArrayY1(d.getY()-width/2,d.getY1()+width/2), 5);
		    	  else if(d.getDist()==6)//�ձ� �簢��
		    		  g.fillRoundRect(d.getX()-width/2, d.getY()-width/2, d.getX1()+width/2-(d.getX()-width/2), d.getY1()+width/2-(d.getY()-width/2), 40,40);
		    		  
				 }
				 else if(d.getfill()==0)//ä��� ������ �ƴϸ�
				 {
					 if(d.getDist() == 1)
				    	  g.drawLine(d.getX()-width/2,d.getY()-width/2,d.getX1()+width/2, d.getY1()+width/2);
					  else if(d.getDist() == 2)
					     g.drawOval(d.getX()-width/2, d.getY()-width/2, d.getX1()+width/2 - (d.getX()-width/2), d.getY1()+width/2 - (d.getY()-width/2));
					  else if(d.getDist() == 3) 
					     g.drawRect(d.getX()-width/2, d.getY()-width/2, d.getX1()+width/2 - (d.getX()-width/2), d.getY1()+width/2 - (d.getY()-width/2));
					   else if(d.getDist() == 4)//�ﰢ���϶�
					     g.drawPolygon(getArrayX(d.getX()-width/2,d.getX1()+width/2), getArrayY(d.getY()-width/2,d.getY1()+width/2), 3);
					   else if(d.getDist()==5)//5�����϶�
					     g.drawPolygon(getArrayX1(d.getX()-width/2,d.getX1()+width/2), getArrayY1(d.getY()-width/2,d.getY1()+width/2), 5);
					   else if(d.getDist()==6)//�ձ� �簢��
					     g.drawRoundRect(d.getX()-width/2, d.getY()-width/2, d.getX1()+width/2-(d.getX()-width/2), d.getY1()+width/2-(d.getY()-width/2), 40,40); 
				 }
		    }
	}
private int[] getArrayX(int x, int x1)//�ﰢ�� x��ǥ
{
	int xa[] = new int[3];
	if(x > x1)
	{
		xa[0] = x1;
		xa[1] = x1 + (x-x1) / 2;
		xa[2] = x;
	}
	else 
	{
		xa[0] = x; 
		xa[1] = x + (x1-x) / 2;
		xa[2] = x1;
	}
	return xa;
}
private int[] getArrayY(int y,int y1)//�ﰢ�� y��ǥ
{
	  int ya[] = new int[3];
	  if(y > y1)
	  {
		  ya[0] = y;
		  ya[1] = y1;
		  ya[2] = y;
	  }
	  else
	  {
		  ya[0] = y1;
		  ya[1] = y;
		  ya[2] = y1;
	  }
	  return ya;
}
private int[] getArrayX1(int x, int x1) //������ x��ǥ
{
	int[] xa = new int[5];
	if (y< y1) 
	{
		xa[0]= x / 2 +x1 / 2;
		xa[1]= x;
		xa[2]= (int) (x + ((x1 - x) / 2.618) / 2);
		xa[3]=	(int) (x1 - ((x1 - x) / 2.618) / 2);
		xa[4]=	x1;
	}
	return xa;
}
private int[] getArrayY1(int y, int y1) //������ y��ǥ
{
	int[] ya= new int[5];
	if (y< y1)
	{
		ya[0]=  y;
		ya[1]=	(int) (y + (y1 - y) / 2.618);
		ya[2]=	y1;
		ya[3]=	y1;
		ya[4]= (int) (y + (y1 - y) / 2.618);
	}
	else if (y>= y1)
	{
		ya[0]=y1;
		ya[1]=(int)(y1+(y-y1)/2.618);
		ya[2]=y;
		ya[3]=y;
		ya[4]=(int)(y1+(y-y1)/2.618);
	}
	return ya;
}	
		//���콺 ����� ���� �޼ҵ�
		public void mouseClicked(MouseEvent e) 
		{//���콺 ��ǥ����(������ ����)
			
		}
		public void mousePressed(MouseEvent e) 
		{ //��������
			x = e.getX();       //x�� ��ǥ���� ����
			y = e.getY();       //y�� ��ǥ���� ����
		}
			
		public void mouseReleased(MouseEvent e) 
		{ //��������
			x1 = e.getX();   //x1�� ��ǥ��
			y1 = e.getY();   //y1�� ��ǥ��
			
			this.repaint();  //�׸��� �ٽ� �׸��� 
			Draw d = new Draw();  //d ��ü����
			d.setDist(dist);  //dist �� ����
			 //������ �� ������
			d.setX(x);  
			d.setY(y);
			d.setX1(x1);
			d.setY1(y1);
			d.setfill(fillnum);//ä��Ⱚ �ֱ�
			vc.add(d); //vc�� ���� �����϶��
			vcolor.add(Color1);//�÷� ���� ����
		}
		
		public void mouseEntered(MouseEvent e) {}
		public void mouseExited(MouseEvent e) {}
		
		//���콺�� �����̴� ���� �׷����� ��� ���̱�
		public void mouseDragged(MouseEvent e)
		{
			
			x1 = e.getX();//x��ǥ ���ϱ�
			y1 = e.getY();//y��ǥ ���ϱ�
			
			this.repaint(); //�����̴� ���� ��������
			
			
			if(dist==10)//���찳
			{
				Draw d = new Draw();
				 d.setDist(1);
				 d.setX(x);
				 d.setY(y);
				 d.setX1(x1);
				 d.setY1(y1);
				 d.setfill(fillnum);//ä��Ⱚ �ֱ�
				 vcolor.add(Color.white);//�÷� ����
				 vc.add(d);//�׸������� ����
				 x = x1;
				 y = y1;
				 Color2 = Color1;//������ ����
			}
			
			if(dist==0)
			{ 	
				Draw d = new Draw();
				 d.setDist(1);
				 d.setX(x);
				 d.setY(y);
				 d.setX1(x1);
				 d.setY1(y1);
				 d.setfill(fillnum);//ä��� �� �ֱ�
				 vcolor.add(Color1);//�÷� ����
				 vc.add(d);//�׸������� ����
				 x = x1;
				 y = y1;
			}
		}

		public void mouseMoved(MouseEvent e) {}

	public static void main(String[] args) {
		term merry = new term("�¸��� �׸���");
	}
	@Override
	public void actionPerformed(ActionEvent arg0) {
		// TODO Auto-generated method stub
		
	}

}
