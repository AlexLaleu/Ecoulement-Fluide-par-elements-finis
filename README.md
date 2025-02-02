Modélisation d'un écoulement fluide par éléments finis

Ce répertoire contient les codes d'un projet de modélisation d'un écoulement fluide dans un canal dans le cadre du cours d'éléments finis de l'ENSTA Paris.

Le langage utilisé est MATLAB et le projet ce décompose en plusieurs étapes : 
 - Eléments finis pour un problème de Poisson avec conditions de Neumann
 - Eléments finis pour le problème de Poisson avec conditions de Dirichlet
 - Equation de Stokes et modélisation d'une marche

Les deux premières étapes sont théoriques et leurs résultats permettent de traiter plus facilement la dernière partie.

Les résultats obtenus sont plutôt satisfaisants. Notons cependant une faible variation de la vitesse horizontale selon la viscosité pour l'écoulement dans un canal présentant une marche. Signe que mes résultats peuvent être améliorés.

Les routines à exécuter sont : 
 - principal_neumann_p2.m pour le problème avec conditions de Neumann
 - principal_dirichlet_p2.m pour le problème avec conditions de Dirichlet.
 - principal_stokes.m pour simulaer un écoulement stationnaire dans un canal rectiligne.
 - princiapl_stokes_marche.m pour simuler un écoulement dans un canal avec une marche descendante.

Le travail et la modélisation sont décrits en détail dans le compte-rendu.
