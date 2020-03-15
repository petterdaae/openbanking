import { firestore } from "firebase-admin";

export default interface Dependencies {
    firestore: firestore.Firestore;
    uid: string;
}