
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.*;

import javax.swing.ImageIcon;
import javax.swing.JPanel;
import javax.swing.Timer;

public class Board extends JPanel implements ActionListener{

	//create Board size parameters

	private final int BOARD_WIDTH = 300;
	private final int BOARD_HEIGHT = 300;
	private final int DOT = 10;
	private final int ALL_DOT = 900;

	private final int DOT_SIZE = 10;
	private final int RAND_POS = 30;


	private final int DELAY = 200; //delay time

	private final int x[] = new int[ALL_DOT];
	private final int y[] = new int[ALL_DOT];

	//apple's coords
	private int dots;
	private int apple_x;
	private int apple_y;

	//direction
	private boolean leftDirection = false;
	private boolean rightDirection = true;
	private boolean upDirection = false;
	private boolean downDirection = false;

	private Timer timer;
	//Image for whatever the picture we gonna show up on the screen

	public Board(){
		addKeyListener(new TAdapter());
		setBackground(Color.black);
		setFocusable(true);

		setPreferredSize(new Dimension(BOARD_WIDTH,BOARD_HEIGHT));
		loadImage();
		initGame();
	}


	//method loading Image
	public void loadImage(){
		ImageIcon id = new ImageIcon("whatever.png");
		//ball = id.getImage();

		ImageIcon target = new ImageIcon("apple.png");
		//apple = target.getImage();

		ImageIcon sh = new ImageIcon("head.png");
		//snake_head = sh.getImage();

	}

	private void initGame(){
		dots = 3;

		for(int i=0; i<dots; i++){
			x[i] = 50-i * 10;
			y[i] = 50;
		}

		locateApple();

		timer = new Timer(DELAY, this);
		timer.start();
	} 

	private void locateApple(){
		int rand = (int)(Math.random()*RAND_POS);
		apple_x = ((rand*DOT_SIZE));

		rand = (int)(Math.random()*RAND_POS);
		apple_y = ((rand*DOT_SIZE));
	}


	private class TAdapter implements KeyListener{
		
		@Override
		public void keyPressed(KeyEvent e){
			int key = e.getKeyCode();

			if((key == keyEvent.VK_LEFT) && (!rightDirection)){
				leftDirection = true;
				upDirection = false;
				downDirection = false;
			}

			if((key == keyEvent.VK_RIGHT) && (!leftDirection)){
				rightDirection = true;
				upDirection = false;
				downDirection = false;
			}

			if((key == keyEvent.VK_UP) && (!downDirection)){
				upDirection = true;
				rightDirection = false;
				leftDirection = false;
			}

			if((key == KeyEvent.VK_DOWN) && (!upDirection)){
				 downDirection = true;
				 rightDirection = false;
				 leftDirection = false;
			}
		}
		public void keyTyped(KeyEvent e){}
		public void keyReleased(KeyEvent e){}

	}

}

