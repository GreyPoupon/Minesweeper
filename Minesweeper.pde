

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
// bombs = new ArrayList <MSButton> ();
private int gridSize = 20;
void setup ()
{
    size(800, 800);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[gridSize][gridSize];
    for(int r = 0; r < gridSize; r++)
    {
        for(int c = 0; c < gridSize; c++)
            buttons[r][c] = new MSButton(r, c);
    }
    for(int i = 0; i < 50; i++)
        setBombs();
}

public void setBombs()
{
    int row = (int)(Math.random()*20);
    int column = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][column]))
       bombs.add(buttons[row][column]);
    else
        setBombs();
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 40;
        height = 40;
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
        if(mouseButton == RIGHT && !marked && !clicked)
            marked = true;
        else if(mouseButton == RIGHT && marked && !clicked)
            marked = false;
        if(mouseButton == LEFT && !marked && !clicked)
        {
            clicked = true;
            if(bombs.contains(this))
                displayLosingMessage();
            else if(countBombs(r, c) > 0)
                setLabel(Integer.toString(countBombs(r, c)));
            else
            {
                if(isValid(r+1, c) && !buttons[r+1][c].isMarked())
                    buttons[r+1][c].mousePressed();
                if(isValid(r-1, c) && !buttons[r-1][c].isMarked())
                    buttons[r-1][c].mousePressed();
                if(isValid(r, c+1) && !buttons[r][c+1].isMarked())
                    buttons[r][c+1].mousePressed();
                if(isValid(r+1, c+1) && !buttons[r+1][c+1].isMarked())
                    buttons[r+1][c+1].mousePressed();
                if(isValid(r-1, c+1) && !buttons[r-1][c+1].isMarked())
                    buttons[r-1][c+1].mousePressed();
                if(isValid(r, c-1) && !buttons[r][c-1].isMarked())
                    buttons[r][c-1].mousePressed();
                if(isValid(r+1, c-1) && !buttons[r+1][c-1].isMarked())
                    buttons[r+1][c-1].mousePressed();
                if(isValid(r-1, c-1) && !buttons[r-1][c-1].isMarked())
                    buttons[r-1][c-1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill(200);
        else 
            fill(50);

        rect(x, y, width, height);
        fill(0);
        text(label, x + width/2, y + height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < gridSize && c >= 0 && c < gridSize)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs+= 1;
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs+= 1;
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs+= 1;
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs+= 1;
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs+= 1;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs+= 1;
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs+= 1;
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs+= 1;
        return numBombs;
    }
}



