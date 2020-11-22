# 02-tarbine-name

Premier µs de la stack. C'est un hello world. 

Il sert à démontrer son build et la relation avec la libraire partagée.

## Vendoring or not ?

Toujours pas nécessaire :

```
$ go run main.go
INFO[0000] hello world                                   name=raymond
```

## Modification locale de la lib

dans `pkg/core/logger/logrus.go` ligne 30 ajouter :
```go
	logrus.Info("parsing log level")
```

puis :
```
$ go run main.go
INFO[0000] hello world                                   name=raymond
```

Le log ne s'affiche pas. Depuis main.go, browser vers `logger.InitLogger()`.
 
Expliquer que go récupère la version la plus récente d'un module. Ici pas de tag
semver, c'est donc master qui est récupérée. Le numéro de version est v0.0.0 + un ~timestamp + ~hash git

### Solution 1 : repasser par le dépôt

Commiter. Puis :

```
$ go run main.go
INFO[0000] hello world                                   name=raymond
```

J'ai toujours pas mon log. Et bah oui, la version est figée en dur dans le go.mod ... 

Donc on peut penser qu'il faut un go get pour updater :

```
$ go get -u github.com/orphaner/02-tartine-lib/pkg/core 
```

Mais le go.mod reste inchangé.

La piste est bonne, mais en vrai il faut spécifier la version de la branche à mettre à jour (alors qu'il ne le fallait lors de l'ajout initial ...) :

```
$ go get -u github.com/orphaner/02-tartine-lib/pkg/core@master
$ go run main.go 
INFO[0000] parsing log level                            
INFO[0000] hello world                                   name=raymond
```

Ouf, ça y est ! et ça été fastidieux. 

### Solution 2 : replace en relatif

Dans le go.mod on peut utiliser l'instruction replace pour overrider l'emplacement d'un module. En particulier on peut utiliser un chemin relatif pour aller chercher les sources en local plutôt
que sur le dépôt.

TODO ::: Recommenter ligne 30 et commiter. Constater que le log s'affiche toujours.

Utiliser le replace :
```
$ go mod edit -replace=github.com/orphaner/02-tartine-lib/pkg/core@master=../02-tartine-lib/pkg/core
$ go run main.go
INFO[0000] hello world                                   name=raymond
```

MAIS : il ne faut pas commiter le go.mod avec les replace ... sinon sur la CI ça va fail le build car le dossier relatif ../ n'existe pas. Il faudra faire un clone de toutes les dépendances : ici il n'y a qu'une dépendance vers une libraire ça va, mais à l'échelle de toute une stack µs ça va pas le faire.
