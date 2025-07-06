_monitor Monitor {  //HOARE -problema de la pizzeria.

    _condvar ponerQueso;
    _condvar ponerSalsa;
    _condvar ponerMorron;
    _condvar prepararPizza;  

    _var int totales = 0;
    _var boolean ayudanteQuesolisto = false;
    _var boolean ayudanteMorronlisto = false;
    _var boolean ayudanteSalsalisto = false;


    _proc void colocarQueso(){
        ayudanteQuesolisto = true;
        _signal(prepararPizza); // Notificar que el ayudante de queso esta listo
        _wait(ponerQueso); // Esperar a que se le indique que ponga el queso
        System.out.println("poner queso");
        _signal(prepararPizza); // Notificar que el queso se ha puesto
        
    }

    _proc void colocarMorron(){
        ayudanteMorronlisto = true;
        _signal(prepararPizza);
        _wait(ponerMorron);
        System.out.println("poner morron");
        _signal(prepararPizza);

    }

    _proc void colocarSalsa(){
        ayudanteSalsalisto = true;
        _signal(prepararPizza);
        _wait(ponerSalsa);
        System.out.println("poner salsa");
        _signal(prepararPizza);

    }

    _proc void terminarPizza(int i){
        if(i==1){
            System.out.println("esperar a queso");
            while(!ayudanteQuesolisto){
                _wait(prepararPizza);
            }
            ayudanteQuesolisto = false; // Resetear el estado del ayudante
            System.out.println("llamar a queso");
            _signal(ponerQueso);
            _wait(prepararPizza); //esperar a que el queso se ponga
        }else if(i==2){
            System.out.println("esperar a morron");
            while(!ayudanteMorronlisto){
                _wait(prepararPizza);
            }
            ayudanteMorronlisto = false;
            System.out.println("llamar a morron");
            _signal(ponerMorron);
            _wait(prepararPizza);
        }else {
            System.out.println("esperar a salsa");
            while(!ayudanteSalsalisto){
                _wait(prepararPizza);
            }
            ayudanteSalsalisto = false;
            System.out.println("llamar a salsa");
            _signal(ponerSalsa);
            _wait(prepararPizza);
        }

        totales++;
        System.out.println("Pizza terminada. Total pizzas: " + totales);
    }


}

//Para compilar y hacer un Singal and Wait es de esta manera    m2jr -sw MonitorTest.m
