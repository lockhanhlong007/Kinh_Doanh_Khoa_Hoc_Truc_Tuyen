import { OrderDetail } from './order-detail.model';
export class Order {
    id: number;
    paymentMethod: string;
    userId: string;
    total: string;
    address: string;
    phoneNumber: string;
    message: string;
    createdUser: string;
    creationTime: string;
    lastModificationTime: string;
    status: number;
    orderDetails: OrderDetail[];
}
