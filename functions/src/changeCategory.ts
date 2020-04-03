import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Dependencies from "./dependencies";

export default (deps: Dependencies) => functions
  .firestore
  .document('users/{uid}/transactions/{tid}')
  .onUpdate(async (change, context) => {
    const uid = context.params.uid;
    const categoryIdBefore = change.before.get('categoryId');
    const categoryIdAfter = change.after.get('categoryId');
    const transactionAmount = change.after.get('amount');

    console.log(`User changed category of transaction; 
                   Uid=${uid}; 
                   OldCategory=${categoryIdBefore}; 
                   NewCategory=${categoryIdAfter}; 
                   Transaction=${change.after.id}`);

    // Category did not change
    if (categoryIdAfter === categoryIdBefore) return;

    // Update old category
    if (categoryIdBefore) {
      await deps.firestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(categoryIdBefore)
        .update({
          'balance': admin.firestore.FieldValue.increment(-transactionAmount)
        });
    }

    // Update new category
    if (categoryIdAfter) {
      await deps.firestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(categoryIdAfter)
        .update({
          'balance': admin.firestore.FieldValue.increment(transactionAmount)
        });
    }
  });
