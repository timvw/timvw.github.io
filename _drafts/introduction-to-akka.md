---
title: Introduction to Akka
author: timvw
layout: post
---
Functional programming is all about immutable data and pure functions.

Akka is nothing like that.

The core concept in Akka is an Actor that handles messages (function invocations).

Here is how this looks like in practice:

```scala
trait Actor {
  type Receive = PartialFunction[Any, Unit]

  def receive: Actor.Receive
}
```

As you can see there is nothing pure about the receive function (It is a [PartialFunction](http://www.scala-lang.org/api/current/#scala.PartialFunction) returning [Unit](http://www.scala-lang.org/api/current/#scala.Unit)).

In order to call the receive function you have to send the actor a message via it's ! or tell method. Here is how those methods are defined:

```scala
trait ScalaActorRef { ref: ActorRef ⇒
  def !(message: Any)(implicit sender: ActorRef = Actor.noSender): Unit
}

abstract class ActorRef extends java.lang.Comparable[ActorRef] with Serializable {
  final def tell(msg: Any, sender: ActorRef): Unit = this.!(msg)(sender)
}
```

So what happens behind the scenes when you send a message? It depends on the implementation of ActorRef. Let's start with the LocalActorRef:

```scala
private[akka] class LocalActorRef private[akka] {
  private val actorCell: ActorCell = newActorCell(_system, this, _props, _dispatcher, _supervisor)
  actorCell.init(sendSupervise = true, _mailboxType)

  override def !(message: Any)(implicit sender: ActorRef = Actor.noSender): Unit = actorCell.sendMessage(message, sender)
}
```

So what is that actorCell? -> forward to Dispatch

```scala
private[akka] trait Dispatch {
  def sendMessage(msg: Envelope): Unit =
    try {
      if (system.settings.SerializeAllMessages) {
        val unwrapped = (msg.message match {
          case DeadLetter(wrapped, _, _) ⇒ wrapped
          case other                     ⇒ other
        }).asInstanceOf[AnyRef]
        if (!unwrapped.isInstanceOf[NoSerializationVerificationNeeded]) {
          val s = SerializationExtension(system)
          val serializer = s.findSerializerFor(unwrapped)
          val bytes = serializer.toBinary(unwrapped)
          serializer match {
            case ser2: SerializerWithStringManifest ⇒
              val manifest = ser2.manifest(unwrapped)
              s.deserialize(bytes, serializer.identifier, manifest).get != null
            case _ ⇒
              s.deserialize(bytes, unwrapped.getClass).get
          }
        }
      }
      dispatcher.dispatch(this, msg)
    } catch handleException
}
```

So, what happens when you create an ActorSystem?

```scala
object ActorSystem {
  def apply(): ActorSystem = apply("default")
  def apply(name: String): ActorSystem = apply(name, None, None, None)
  def apply(name: String, config: Option[Config] = None, classLoader: Option[ClassLoader] = None, defaultExecutionContext: Option[ExecutionContext] = None): ActorSystem = {
    val cl = classLoader.getOrElse(findClassLoader())
    val appConfig = config.getOrElse(ConfigFactory.load(cl))
    new ActorSystemImpl(name, appConfig, cl, defaultExecutionContext, None).start()
  }
}
```

So, what happens when you create an Actor?

```scala
private[akka] class ActorSystemImpl(
  def actorOf(props: Props): ActorRef =
    if (guardianProps.isEmpty) guardian.underlying.attachChild(props, systemService = false)
    else throw new UnsupportedOperationException("cannot create top-level actor from the outside on ActorSystem with custom user guardian")

  def guardian: LocalActorRef = provider.guardian

  val provider: ActorRefProvider = try {
    val arguments = Vector(
      classOf[String] → name,
      classOf[Settings] → settings,
      classOf[EventStream] → eventStream,
      classOf[DynamicAccess] → dynamicAccess)

    dynamicAccess.createInstanceFor[ActorRefProvider](ProviderClass, arguments).get
  } catch {
    case NonFatal(e) ⇒
      Try(stopScheduler())
      throw e
  }

object ActorSystem {
  final val ProviderClass: String =
    getString("akka.actor.provider") match {
      case "local"   ⇒ classOf[LocalActorRefProvider].getName
      // these two cannot be referenced by class as they may not be on the classpath
      case "remote"  ⇒ "akka.remote.RemoteActorRefProvider"
      case "cluster" ⇒ "akka.cluster.ClusterActorRefProvider"
      case fqcn      ⇒ fqcn
    }  
}

private[akka] class LocalActorRefProvider private[akka] (
  override lazy val guardian: LocalActorRef = {
    val cell = rootGuardian.underlying
    cell.reserveChild("user")
    val ref = new LocalActorRef(system, system.guardianProps.getOrElse(Props(classOf[LocalActorRefProvider.Guardian], guardianStrategy)),
      defaultDispatcher, defaultMailbox, rootGuardian, rootPath / "user")
    cell.initChild(ref)
    ref.start()
    ref
  }
}
```

You can read more about the [Guardians](http://doc.akka.io/docs/akka/current/general/supervision.html)
