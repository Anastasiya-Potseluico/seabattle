package seabattle;

import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.CyclicBehaviour;
import jade.core.behaviours.OneShotBehaviour;
//import javafx.util.Pair;
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

import java.io.FileReader;
import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by Анастасия on 04.05.2016.
 */
public class Player extends Agent{

    private static final int MAX_PASSES = 2;
    // 0 - неизвестная клетка
    // 1 - убитая клетка
    // -1 - пустая клетка
    private int[][] _enemyField = new int[10][10];
    // 0 - пустая клетка
    // 1 - клетка с кораблем
    private int[][] _playField = new int[10][10];

    private int _currentEnemyHittedX = -1;
    private int _currentEnemyHittedY = -1;
    private Rete ourField;
    private Rete enemyField;

    @Override
    protected void setup() {
        // Изменить базу фактов в jess о состоянии поля противника
        FileReader program = null;
        try {
            program = new FileReader(new File("seabattlerules.clp"));
            enemyField = new Rete();
            Jesp parser = new Jesp(program, enemyField);
            parser.parse(false);
            program.close();
            //enemyField.addUserfunction(new MarkShip());
            // Очистить базу фактов.
            enemyField.reset();
            // TODO: Добавить в базу фактов свои корабли.

            // Запустить выполнение.
            //enemyField.run(MAX_PASSES);
        } catch (JessException|IOException e) {
            e.printStackTrace();
        }
        try {
            program = new FileReader(new File("outfield.clp"));
            ourField = new Rete();
            Jesp parser = new Jesp(program, ourField);
            parser.parse(false);
            program.close();
            //ourField.addUserfunction(new MarkShip());
            // Очистить базу фактов.
            ourField.reset();
            // TODO: Добавить в базу фактов пустые клетки.

            // Запустить выполнение.
            //ourField.run(MAX_PASSES);
        } catch (JessException|IOException e) {
            e.printStackTrace();
        }

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
        addBehaviour(new GetResponseFromEnemy());
        addBehaviour(new MakeFire());
        addBehaviour(new SendResponseToEnemy());
        addBehaviour(new GetCoordinatesFromEnemy());
    }

    // Класс атаки на вражескую клетку
    class MakeFire extends OneShotBehaviour {

        private MessageTemplate _mt;
        private AID _enemyAgent = null; // Как его получить - ХЗ!!!!!!!!!!

        @Override
        public void action() {
            // Если нет убитых клеток на поле врага - отправить любую пустую клетку, иначе
            // Отправить две координаты на основании правил
            if(_currentEnemyHittedX == -1) {
                // Выбрать рандомный выстрел по пустым клеткам

            } else {
                // TODO: Выбрать по правилам новые x и y.
                String x = "3";
                String y = "3";
                // TODO: Нужно использовать jess и получить от туда факт hitted, перед каждым выстрелом его нужно очистить
                // Отослать сообщение об ударе
                ACLMessage missMessage = new ACLMessage(ACLMessage.INFORM);
                missMessage.addReceiver(_enemyAgent);
                missMessage.setConversationId("hitCoordinates");
                missMessage.setContent(x + "," + y);
                _mt = MessageTemplate.and(
                        MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                        MessageTemplate.MatchConversationId("hitCoordinates")
                );
                myAgent.send(missMessage);
                System.out.println("Sent coordinates" + x + "," + y);
            }
        }
    }

    // Класс для отправки результата атаки на свою клетку врагу
    class SendResponseToEnemy extends OneShotBehaviour {

        private AID _enemyAgent = null;
        private MessageTemplate _mt;

       /* public SendResponseToEnemy(AID enemyAgent) {
            super();
            _enemyAgent = enemyAgent;
        }*/

        // Метод для проверки попадания врага в свой корабль
        // из jess получаем факт по позиции можно написать правило и который поможет нам результат получить
        // TODO: не использовать массив интов , заменить его на правила jess'а
        // TODO: получить факт по координатам обновить базу фактов и отдать сообщение
        private void AnalyzeEnemyAttack(int x, int y) {
            if(x < 10 && x > -1 && y < 10 && y > -1) {
                if (_playField[x][y] == 1) {
                    // Отправить факт hit или ship
                } else {
                    // Отправить сообщение о промахе
                    ACLMessage missMessage = new ACLMessage(ACLMessage.INFORM);
                    missMessage.addReceiver(_enemyAgent);
                    missMessage.setConversationId("shotResult");
                    missMessage.setContent("miss");
                    _mt = MessageTemplate.and(
                            MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                            MessageTemplate.MatchConversationId("shotResult")
                    );
                    myAgent.send(missMessage);
                    System.out.println("Sent miss message");
                }
            } else {
                System.out.println("Wrong coordinates");
            }
        }

        @Override
        public void action() {

        }
    }

    // Класс для получения сообщения с результатом атаки на вражескую клетку
    class GetResponseFromEnemy extends CyclicBehaviour {
        MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                MessageTemplate.MatchConversationId("shotResult")
        );

        @Override
        public void action() {
            ACLMessage msg = myAgent.receive(_mt);
            if (msg != null) {
                String fireState = msg.getContent();
                System.out.print(fireState);
                switch (fireState) {
                    case "miss":
                        // TODO: Изменить базу фактов в jess о состоянии поля противника
                        break;
                    case "hit":
                        // TODO: Изменить базу фактов в jess о состоянии поля противника
                        break;
                    case "ship":
                        // Пометить клетки вокруг корабля как пустые
                        // TODO: Изменить базу фактов в jess о состоянии поля противника
                        break;
                }
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
        MessageTemplate _mt = MessageTemplate.and(
                MessageTemplate.MatchPerformative(ACLMessage.INFORM),
                MessageTemplate.MatchConversationId("hitCoordinates")
        );

        @Override
        public void action() {
            ACLMessage msg = myAgent.receive(_mt);
            if (msg != null) {
               // parse coordinates
                String[] coordinates = msg.getContent().split(",");
                if(coordinates.length == 2) {
                    _x = Integer.parseInt(coordinates[0]);
                    _y = Integer.parseInt(coordinates[1]);
                    System.out.println("Coordinates " + msg.getContent() + " gotten");
                } else {
                    System.out.println("Only two coordinates are available to be sent!");
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
