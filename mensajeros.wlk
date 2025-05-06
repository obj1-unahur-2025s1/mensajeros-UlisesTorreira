object paquete {
  var estaPago = false
  var destino = laMatrix
  method estaPago() = estaPago
  method pagarPaquete() {estaPago = true}
  method puedeEntregarse(unMensajero){
    return
    destino.dejaPasar(unMensajero) and self.estaPago()}
}

object paquetito {
  method estaPago() = true
  method puedeEntregarse(unMensajero) = true 
}

object paqueton {
  const destinos = []

  method agregarDestino(unDestino){
    destinos.add(unDestino)
  }
  method precio() = 100 * destinos.size()
  method pagar(unImporte) {importePagado = importePagado + unImporte}
  method estaPago() {
    return
    importePagado >= self.precioTotal() 
  }
  method puedeEntregarse(unMensajero) {}
}

object puenteDeBrooklyn {
  method dejarPasar(unMensajero){
    return
    unMensajero.peso() < 1000
  }
  
}

object laMatrix {
  method dejarPasar(unMensajero){
    return
    unMensajero.puedeLlamar()
  }  
}

object roberto {
  var transporte = bicicleta
  method peso() = 90 + transporte.peso()
  method puedeLlamar() = false
  method cambiarTransporte(nuevoTransporte){
    transporte = nuevoTransporte
  }
}

object chuckNorris {
  method peso() = 80
  method puedeLlamar() = true
}

object neo {
  var tieneCredito = true
  method peso() = 0
  method puedeLlamar() = tieneCredito
  method cargarCredito() { tieneCredito = true}
  method agotarCredito() {tieneCredito  = false}  
}

object bicicleta {
  method peso() = 5
}

object camion {
  var acoplados = 1
  method cantidadAcoplados(unaCantidad) {acoplados = unaCantidad}
  method peso() = acoplados * 500
}

object empresaMensajeria {
  const mensajeros = #{}
  method mensajeros() = mensajeros
  //Contratar a un mensajero
  method contratar(unMensajero){
    mensajeros.add(unMensajero)
  }
  //Despedir a un mensajero
  method despedir(unMensajero){
    mensajeros.remove(unMensajero)
  }
  //Despedir a todos los mensajeros
  method despedirTodos(){
    mensajeros.clear()
  }
  //Analizar si la mensajeriaa es grande (si tiene mas de dos mensajeros)
  method esGrande() = mensajeros.size() > 2
  //Consultar si el paquete puede ser entregado por el primer empleado de la empresa  
  method puedeEntregarsePaquete() {
    return
    paquete.puedeEntregarse(mensajeros.first())
  }
  //Saber el peso del último mensajero de la empresa
  method pesoUltimoMensajero() = mensajeros.last().peso()
  //Hacer al menos un test por cada punto de los anteriores que demuestre
  method puedeEntregarse(unPaquete){
    return
    mensajeros.any({m => unPaquete.puedeEntregarse()})
  }

  method losQuePuedenEntregar(unPaquete){
    return
    mensajeros.filter({m => unPaquete.puedeEntregarse()})
  }

  method tieneSobrePeso() {
    return
    self.pesosDeLosMensajeros() / mensajeros.size() > 500
  }

  method pesosDeLosMensajeros() =
    mensajeros.sum({m => m.peso()})
  
  method enviar(unPaquete){
    if(self.puedeEntregarse(unPaquete)) {
        paquetesEnviados.add(unPaquete)
    }
    else {
      paquetesPendientes.add(unPaquete)
    }
  }

  method facturacion() = paquetesEnviados.sum({p => p.precioTotal()})

  method enviarPaquetes(listaDePaquetes) {
      listaDePaquetes.forEach({p => self.enviar(p)})
  }
  method enviarPendienteMasCaro(){
      if(self.puedeEntregarse(self.paquetePendienteMasCaro())){
      self.enviar(self.paquetePendienteMasCaro())
      paquetesPendientes.remove(self.paquetePendienteMasCaro())
      }

  }
  method paquetePendienteMasCaro(){
    return
    paquetesPendientes.max({p => p.precioTotal()})
  }
}
