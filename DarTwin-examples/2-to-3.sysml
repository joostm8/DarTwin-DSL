doc /*
 * Encountered a problem:
 * Original transformation was in fact a combination of augmented and arbiter.
 * Combining AugmentedTrans and ArbiterTrans to a AugmentedWithArbiter proved not possible.
 * 
 * Possible alternative solution: apply in sequence the AugmentedTrans and ArbiterTrans.
 * Negative: doing so will have a lot of dangling ports/connections in the intermediate steps.
 *
 * From the issues encountered in 1-to-2 and 2-to-3 we can conclude that
 * either the transformations in the original paper were too loosely defined,
 * or that the transformations are too inflexible in SysML?
 */