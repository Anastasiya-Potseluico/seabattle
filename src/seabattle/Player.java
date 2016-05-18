package seabattle;

import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.CyclicBehaviour;
import jade.core.behaviours.OneShotBehaviour;
//import javafx.util.Pair;
import jade.core.behaviours.ReceiverBehaviour;
import jade.domain.DFService;
import jade.domain.FIPAAgentManagement.DFAgentDescription;
import jade.domain.FIPAAgentManagement.ServiceDescription;
import jade.domain.FIPAException;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jess.*;

import java.io.FileReader;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;

/**
 * Created by Анастасия on 04.05.2016.
 */
public class Player extends Agent {

    private static final int MAX_PASSES = 2;

    private int _currentEnemyHittedX = -1;
    private int _currentEnemyHittedY = -1;
    private Rete _ourField;
    private Rete _enemyField;
    private AID _me = null;
    private AID _enemy = null;
    private int drownedship = 0;

    @Override
    protected void setup() {
        // Изменить базу фактов в jess о состоянии поля противника
        FileReader program = null;
        _me = getAID();
        try {
            program = new FileReader(new File("seabattlerules.clp"));
            _enemyField = new Rete();
            Jesp parser = new Jesp(program, _enemyField);
            parser.parse(false);
            program.close();
            // Очистить базу фактов.
            _enemyField.reset();
            // Добавить в базу фактов пустые клетки.
            Deftemplate emptyTemplate = _enemyField.findDeftemplate("empty");
            Deftemplate endgameTemplate = _enemyField.findDeftemplate("notgameover");
            for (int i = 0 ; i < 10; i++) {
                for (int j = 0; j < 10; j++) {
                    Fact empty = new Fact(emptyTemplate);
                    empty.setSlotValue("x", new Value(i, RU.INTEGER));
                    empty.setSlotValue("y", new Value(j, RU.INTEGER));
                    _enemyField.assertFact(empty);
                }
            }
            Fact cell = new Fact(endgameTemplate);
            _enemyField.assertFact(cell);
            // Запустить выполнение.
            //_enemyField.run(MAX_PASSES);
        } catch (JessException|IOException e) {
            e.printStackTrace();
        }
        try {
            program = new FileReader(new File("ourfield.clp"));
            _ourField = new Rete();
            Jesp parser = new Jesp(program, _ourField);
            parser.parse(false);
            program.close();
            //_ourField.addUserfunction(new MarkShip());
            // Очистить базу фактов.
            _ourField.reset();
            Scanner fileReader = null;

            Deftemplate emptyTemplate = _ourField.findDeftemplate("empty");
            Deftemplate shipTemplate = _ourField.findDeftemplate("ship");
            Deftemplate endgameTemplate = _enemyField.findDeftemplate("notgameover");
            Deftemplate drownedshipTemplate = _ourField.findDeftemplate("drownedship");
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
                Fact cell;
                for(int j = 0; j < items.length; j ++) {
                    cell = (Integer.parseInt(items[j]) == 1) ? new Fact(shipTemplate) : new Fact(emptyTemplate);
                    cell.setSlotValue("x", new Value(i, RU.INTEGER));
                    cell.setSlotValue("y", new Value(j, RU.INTEGER));
                    _ourField.assertFact(cell);
                }
            }
            Fact cell = new Fact(endgameTemplate);
            _ourField.assertFact(cell);
            cell = new Fact(drownedshipTemplate);
            cell.setSlotValue("y", new Value(0, RU.INTEGER));
            _ourField.assertFact(cell);
            // Запустить выполнение.
            //_ourField.run(MAX_PASSES);
        } catch (JessException|IOException e) {
            e.printStackTrace();
        }
        while(_enemy == null) {
            DFAgentDescription agentDescription = new DFAgentDescription();
            agentDescription.setName(getAID());
            ServiceDescription myService = new ServiceDescription();
            myService.setType("service -name");
            myService.setName("my-service"+ _me.getName());
            agentDescription.addServices(myService);
            try {
                DFService.register(this, agentDescription);
            } catch (FIPAException e) {
                e.printStackTrace();
            }

            DFAgentDescription agentTemplate = new DFAgentDescription();
            ServiceDescription service = new ServiceDescription();
            myService.setType("service -name");
            agentTemplate.addServices(service);
            try {
                DFAgentDescription result[] = DFService.search(this, agentTemplate);
                for (int i = 0; i < result.length; i++) {
                    if (!result[i].getName().getName().equals(_me.getName())) {
                        _enemy = result[i].getName();
                    }
                }

            } catch (FIPAException e) {
                e.printStackTrace();
            }
        }
        addBehaviour(new GetResponseFromEnemy());
        //addBehaviour(new MakeFire());
        addBehaviour(new GetCoordinatesFromEnemy());
        addBehaviour(new FirstShot());
    }

    /*// Класс атаки на вражескую клетку
    class MakeFire extends OneShotBehaviour {

        private MessageTemplate _mt;

        @Override*/
        public void action111() {

            System.out.println("Action111");
            // Если нет убитых клеток на поле врага - отправить любую пустую клетку, иначе
            // Отправить две координаты на основании прави
            try {
                Deftemplate hittedTemplate = _enemyField.findDeftemplate("hitted");
                Deftemplate nothittedTemplate = _enemyField.findDeftemplate("nothitted");
                Fact cell;
                cell = new Fact(nothittedTemplate);
                _enemyField.assertFact(cell);
                _enemyField.run(MAX_PASSES);
                Iterator list = _enemyField.listFacts();
                int x,y;
                String rmsg = "";
                while(list.hasNext()) {
                    Fact temp = (Fact) list.next();
                    if(hittedTemplate.equals(temp.getDeftemplate())) {
                        x = Integer.parseInt(temp.getSlotValue("x").toString());
                        y = Integer.parseInt(temp.getSlotValue("y").toString());
                        rmsg = x + "," + y;
                    }
                }
                if (rmsg != "") {
                    // Отправить сообщение о выстреле
                    ACLMessage missMessage = new ACLMessage(ACLMessage.INFORM_REF);
                    missMessage.addReceiver(_enemy);
                    missMessage.setConversationId("hitCoordinates");
                    missMessage.setContent(rmsg);
                    this.send(missMessage);
                    System.out.println("Sent coordinates:" + rmsg);
                }
            } catch (JessException e) {
                e.printStackTrace();
            }
        }
   // }

    // Класс для получения сообщения с результатом атаки на вражескую клетку
    class GetResponseFromEnemy extends CyclicBehaviour {
        private MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                MessageTemplate.MatchConversationId("shotResult")
        );

        @Override
        public void action() {
            ACLMessage msg = myAgent.receive(this._mt);
            if (msg != null) {
                String fireState = msg.getContent();
                String[] content = fireState.split(",");
                System.out.print("GetMassage:" + fireState + " " + content[0] );
                String rmsg = "";
                int x,y;
                if (content.equals("over")) {
                    try {
                        Deftemplate notgameoverTemplate = _enemyField.findDeftemplate("notgameover");
                        Deftemplate gameoverTemplate = _enemyField.findDeftemplate("gameover");
                        Iterator list = _enemyField.listFacts();
                        while (list.hasNext()) {
                            Fact temp = (Fact) list.next();
                            if (notgameoverTemplate.equals(temp.getDeftemplate())) {
                                _enemyField.retract(temp);
                            }
                        }
                        Fact temp = new Fact(gameoverTemplate);
                        _enemyField.assertFact(temp);
                    } catch (JessException e) {
                        e.printStackTrace();
                    }
                    removeBehaviour(new GetResponseFromEnemy());
                    block();
                } else if (content.length == 3) {
                    x = Integer.parseInt(content[1]);
                    y = Integer.parseInt(content[2]);
                    try {
                        Deftemplate hittedTemplate = _enemyField.findDeftemplate("hitted");
                        Deftemplate missTemplate = _enemyField.findDeftemplate("miss");
                        Deftemplate hitTemplate = _enemyField.findDeftemplate("hit");
                        Deftemplate shipTemplate = _enemyField.findDeftemplate("ship");
                        Deftemplate emptyTemplate = _enemyField.findDeftemplate("empty");
                        Deftemplate nothittedTemplate = _enemyField.findDeftemplate("nothitted");
                        Deftemplate notgameoverTemplate = _enemyField.findDeftemplate("notgameover");
                        Fact cell = null;
                        Iterator list = _enemyField.listFacts();
                        while(list.hasNext()) {
                            Fact temp = (Fact) list.next();
                            if(hittedTemplate.equals(temp.getDeftemplate())) {
                                int x1,y1;
                                x1 = Integer.parseInt(temp.getSlotValue("x").toString());
                                y1 = Integer.parseInt(temp.getSlotValue("y").toString());
                                if(x == x1 && y == y1) {
                                    _enemyField.retract(temp);
                                }
                            }
                        }
                        switch (content[0]) {
                            case "miss":
                                cell = new Fact(missTemplate);
                                break;
                            case "hit":
                                cell = new Fact(hitTemplate);
                                break;
                            case "ship":
                                cell = new Fact(shipTemplate);
                                break;
                        }
                        cell.setSlotValue("x", new Value(x, RU.INTEGER));
                        cell.setSlotValue("y", new Value(y, RU.INTEGER));
                        _enemyField.assertFact(cell);
                        _enemyField.run(MAX_PASSES);
                        if (cell.getDeftemplate().equals(shipTemplate) || cell.getDeftemplate().equals(hitTemplate)) {
                            list = _enemyField.listFacts();
                            while (list.hasNext()) {
                                Fact temp = (Fact) list.next();
                                if (hittedTemplate.equals(temp.getDeftemplate()) || nothittedTemplate.equals(temp.getDeftemplate())) {
                                    _enemyField.retract(temp);
                                }

                            }
                            //addBehaviour(new MakeFire());
                            action111();
                        }

                    } catch (JessException e) {
                        e.printStackTrace();
                    }
                }
                addBehaviour(new GetResponseFromEnemy());
            } else {
                block();
            }
        }
    }
    // Класс для получения сообщения с результатом атаки на вражескую клетку
    class FirstShot extends CyclicBehaviour {
        private MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                MessageTemplate.MatchConversationId("FirstShot")
        );

        @Override
        public void action() {
            ACLMessage msg = myAgent.receive(this._mt);
            if (msg != null) {
                //addBehaviour(new MakeFire());
                action111();
                block();
            } else {
                block();
            }
        }
    }

    // Класс для получения сообщения с координатами, выбранными врагом для атаки
    class GetCoordinatesFromEnemy extends CyclicBehaviour {
        private  int _x;
        private  int _y;
        // Передаем координаты в формате x,y
        private MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.INFORM_REF),
                MessageTemplate.MatchConversationId("hitCoordinates")
        );

        @Override
        public void action() {
            _mt = MessageTemplate.and(
                    MessageTemplate.MatchPerformative(ACLMessage.INFORM_REF),
                    MessageTemplate.MatchConversationId("hitCoordinates")
            );
            ACLMessage msg = myAgent.receive(this._mt);
            if (msg != null) {
                String[] coordinates = msg.getContent().split(",");
                System.out.println("Message:" + msg.getContent() + " " + msg.getConversationId());
                if(coordinates.length == 2 && _enemy!= null && msg.getConversationId().equals("hitCoordinates")) {
                    int x = Integer.parseInt(coordinates[0]);
                    int y = Integer.parseInt(coordinates[1]);
                    System.out.println("Coordinates " + msg.getContent() + " gotten");
                    if(x < 10 && x > -1 && y < 10 && y > -1) {
                        try {
                            Deftemplate hittedTemplate = _ourField.findDeftemplate("hitted");
                            Deftemplate missTemplate = _ourField.findDeftemplate("miss");
                            Deftemplate hitTemplate = _ourField.findDeftemplate("hit");
                            Deftemplate drownedTemplate = _ourField.findDeftemplate("drowned");
                            Deftemplate drownedshipTemplate = _ourField.findDeftemplate("drownedship");
                            Fact cell;
                            cell = new Fact(hittedTemplate);
                            cell.setSlotValue("x", new Value(x, RU.INTEGER));
                            cell.setSlotValue("y", new Value(y, RU.INTEGER));
                            _ourField.assertFact(cell);
                            _ourField.run(MAX_PASSES);
                            Iterator list = _ourField.listFacts();
                            int x1,y1;
                            String rmsg = "";
                            boolean needHit = false;
                            boolean gameover = false;
                            while(list.hasNext()) {
                                Fact temp = (Fact) list.next();
                                if(!hittedTemplate.equals(temp.getDeftemplate()) && (missTemplate.equals(temp.getDeftemplate())
                                    || drownedTemplate.equals(temp.getDeftemplate()) || hitTemplate.equals(temp.getDeftemplate()))) {
                                    x1 = Integer.parseInt(temp.getSlotValue("x").toString());
                                    y1 = Integer.parseInt(temp.getSlotValue("y").toString());
                                    if (x1 == x && y1 == y) {
                                        if (temp.getDeftemplate().equals(hitTemplate)) {
                                            rmsg = "hit";
                                        } else if (temp.getDeftemplate().equals(missTemplate)) {
                                            rmsg = "miss";
                                            needHit = true;
                                        } else if (temp.getDeftemplate().equals(drownedTemplate)) {
                                            rmsg = "ship";
                                            drownedship++;
                                        }
                                        rmsg += "," + x + "," + y;
                                    }
                                }
                            }
                            if(drownedship == 10) {
                                rmsg = "over";
                                System.out.println(rmsg + " game over");
                            }
                            if (rmsg != "") {
                                // Отправить сообщение о выстреле
                                ACLMessage missMessage = new ACLMessage(ACLMessage.INFORM);
                                missMessage.addReceiver(_enemy);
                                missMessage.setConversationId("shotResult");
                                missMessage.setContent(rmsg);
                                _mt = MessageTemplate.and(
                                        MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                                        MessageTemplate.MatchConversationId("shotResult")
                                );
                                myAgent.send(missMessage);
                                System.out.println("Sent message:" + rmsg);
                                if (needHit && drownedship != 10) {
                                    action111();
                                    //addBehaviour(new MakeFire());
                                }
                                if (drownedship == 10) {
                                    removeBehaviour(new GetCoordinatesFromEnemy());
                                }
                            }
                        } catch (JessException e) {
                            e.printStackTrace();
                        }
                        addBehaviour(new GetCoordinatesFromEnemy());
                    } else {
                        System.out.println("Wrong coordinates");
                    }
                } else {
                    System.out.println("Only two coordinates are available to be sent!");
                    //coordinates.length == 3 && _enemy!= null
                }
            } else {
                block();
            }
        }
    }
    class MarkShip implements Userfunction {
        @Override
        public String getName() {
            return "markship";
        }

        @Override
        public Value call(ValueVector valueVector, Context context) throws JessException {

            ACLMessage reportSpam = new ACLMessage(ACLMessage.REQUEST);
            //reportSpam.addReceiver(_boxAgent);
            //reportSpam.setConversationId("markBoatAsShip");
            //reportSpam.setContent(valueVector.get(1).stringValue(context));
            //myAgent.send(reportSpam);
            System.out.println("Sent a ship message.");

            return Funcall.TRUE;
        }
    }
}
