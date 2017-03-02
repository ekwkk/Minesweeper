import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i < NUM_ROWS; i++)
    {
        for (int j = 0; j < NUM_COLS; j++)
        {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    
    
    for (int i = 0; i < 50; i++)
    {
        setBombs();
    }
}






public void setBombs()
{
    int randomRow = (int)(Math.random()*20);
    int randomCol = (int)(Math.random()*20);

    if (!bombs.contains(buttons[randomRow][randomCol]))
        bombs.add(buttons[randomRow][randomCol]);
}





public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}





public boolean isWon()
{
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            if (!bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked())
                    return false;
        }
    }

    return true;
}






public void displayLosingMessage()
{
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            if (bombs.contains(buttons[r][c]))
                buttons[r][c].clicked = true;
        }
    }


    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("T");
    buttons[9][14].setLabel(" ");
    buttons[9][15].setLabel(":(");


}





public void displayWinningMessage()
{
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel(" ");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("N");
    buttons[9][13].setLabel("!");
}






public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }



    public boolean isMarked()
    {
        return marked;
    }



    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    


    public void mousePressed () 
    {
        clicked = true;
        if (keyPressed)
            marked = !marked;

        if (!marked == false)
            clicked = false;
        else if (bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(r,c) > 0)
            setLabel(Integer.toString(countBombs(r,c)));
        else
        {
            if(c>0 && buttons[r][c-1].clicked == false)
                buttons[r][c-1].mousePressed();
            if(c<19 && buttons[r][c+1].clicked == false)
                buttons[r][c+1].mousePressed();
            if(c>0 && r<19 && buttons[r+1][c-1].clicked == false)
                buttons[r+1][c-1].mousePressed();
            if(r>0 && c>0 && buttons[r-1][c-1].clicked == false)
                buttons[r-1][c-1].mousePressed();
            if(r<19 && buttons[r+1][c].clicked == false)
                buttons[r+1][c].mousePressed();
            if(r>0 && buttons[r-1][c].clicked == false)
                buttons[r-1][c].mousePressed();
            if(r>0 && c<19 && buttons[r-1][c+1].clicked == false)
                buttons[r-1][c+1].mousePressed();
            if(r<19 && c<19 && buttons[r+1][c+1].clicked == false)
                buttons[r+1][c+1].mousePressed();
        }
    }



    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }



    public void setLabel(String newLabel)
    {
        label = newLabel;
    }






    public boolean isValid(int r, int c)
    {
        if ((r < NUM_ROWS) && (r >= 0) && (c < NUM_COLS) && (c >= 0))
            return true;
        return false;
    }



    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(row+1,col))
        {
            if (bombs.contains(buttons[row+1][col])){numBombs++;}
        }
        if (isValid(row-1,col))
        {
            if (bombs.contains(buttons[row-1][col])){numBombs++;}
        }
        if (isValid(row,col+1))
        {
            if (bombs.contains(buttons[row][col+1])){numBombs++;}
        }
        if (isValid(row,col-1))
        {
            if (bombs.contains(buttons[row][col-1])){numBombs++;}
        }
        if (isValid(row+1,col+1))
        {
            if (bombs.contains(buttons[row+1][col+1])){numBombs++;}
        }
        if (isValid(row+1,col-1))
        {
            if (bombs.contains(buttons[row+1][col-1])){numBombs++;}
        }
        if (isValid(row-1,col+1))
        {
            if (bombs.contains(buttons[row-1][col+1])){numBombs++;}
        }
        if (isValid(row-1,col-1))
        {
            if (bombs.contains(buttons[row-1][col-1])){numBombs++;}
        }
        return numBombs;
    }
    
}



