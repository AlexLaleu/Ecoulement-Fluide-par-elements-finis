Modélisation d'un écoulement fluide par éléments finis

Ce répertoire contient les codes d'un projet de modélisation d'un écoulement fluide dans un canal dans le cadre du cours d'éléments finis de l'ENSTA Paris.

Le langage utilisé est MATLAB et le projet ce décompose en plusieurs étapes : 
 - Eléments finis pour un problème de Poisson avec conditions de Neumann
 - Eléments finis pour le problème de Poisson avec conditions de Dirichlet
 - Equation de Stokes et modélisation d'une marche

Les deux premières étapes sont théoriques et leurs résultats permettent de traiter plus facilement la dernière partie.

Les résultats obtenus sont plutôt satisfaisants sauf pour l'écoulement avec une marche dans le canal qui comporte certaines valeurs incohérentes sur la frontière.

Les routines à exécuter sont : 
 - principal_neumann_p2.m pour le problème avec conditions de Neumann
 - principal_dirichlet_p2.m pour le problème avec conditions de Dirichlet
 - principal_stokes.m pour le canal sans la marche
 - princiapl_stokes_marche.m pour le canal avec marche (résultats incohérents)

Le travail et la modélisation sont décrits en détail dans le compte-rendu.
