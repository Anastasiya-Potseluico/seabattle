package seabattle;

import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.CyclicBehaviour;
import jade.core.behaviours.OneShotBehaviour;
import javafx.util.Pair;
import jdk.nashorn.internal.runtime.Debug;
import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.Behaviour;
import jade.core.behaviours.TickerBehaviour;
import jade.domain.DFService;
import jade.domain.FIPAAgentManagement.DFAgentDescription;
import jade.domain.FIPAAgentManagement.ServiceDescription;
import jade.domain.FIPAException;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jess.*;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by Анастасия on 04.05.2016.
 */
public class Player extends Agent{

    // 0 - неизвестная клетка
    // 1 - убитая клетка
    // -1 - в такой клетке точно ничего не может быть
    private int[][] _playField = new int[10][10];
    private int[][] _enemyField = new int[10][10];
    private int _myKilledShipCount = 0;
    private HashMap<Integer, Integer> _damagedShip = new HashMap<>();

    @Override
    protected void setup() {
        Scanner fileReader = null;
        try {
            File inputFile = new File("field1.txt");
            inputFile.setReadable(true);
            System.out.println(inputFile.exists());
            boolean ok = inputFile.canRead();
            fileReader = new Scanner(inputFile);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        for(int i = 0; i < 10; i ++) {
            String result = fileReader.nextLine();
            String items[] = result.split(" ");
            for(int j = 0; j < items.length; j ++) {
                _playField[i][j] = Integer.parseInt(items[j]);
                _enemyField[i][j] = 0;
            }
        }
        addBehaviour(new EnemyFire());
        addBehaviour(new MyFire());
    }

    class MyFire extends OneShotBehaviour {

        private AID _enemyAgent = null;
        private int _hitXCoordinate = -1;
        private int _hitYCoordinate = -1;

        @Override
        public void action() {
            // check coordinate x, y, check game over.
        }

    }

    class EnemyFire extends CyclicBehaviour {
        MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.REQUEST),
                MessageTemplate.MatchConversationId("getLatestMessages")
        );
        @Override
        public void action() {
            ACLMessage msg = myAgent.receive(_mt);
            if (msg != null) {
                Long timestamp = Long.parseLong(msg.getContent());
                System.out.print(timestamp);
            } else {
                block();
            }
            // check coordinate x, y, check game over.
        }
    }

}
