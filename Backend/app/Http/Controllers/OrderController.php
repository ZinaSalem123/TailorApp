<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;

class OrderController extends Controller
{
    public function index(){
        $orders=Order::all();
        return $orders ;
    }

    public function show(Order $order) //this is type hinting
    {
        return response()->json([
            'message' => 'Fund!',
            'order' => $order,
            
        ],200);
        
    }


    public function edit(Order $order)
    {
        return response()->json([
            'message' => 'Fund!',
            'order' => $order,
            
        ],200);
    }

    public function store(){

        Order::create([
        'order_name'=>request()->order_name,
        'description'=>request()->description,
        'start_date'=>request()->start_date,
        'end_date'=>request()->end_date,
        ]);
        return response()->json([
            'message' => 'Success to add Orders!',
            'order' => Order::all(),
            
        ],200);
    }

    public function update($orderId)
    {
        $singleOrderFromDB = Order::find($orderId);
        if($singleOrderFromDB!=null){
            $singleOrderFromDB->update([
                'order_name' => request()->order_name,
                'description' => request()->description,
                'start_date' => request()->start_date,
                'end_date' => request()->end_date,
                'done' => request()->done,
            ]);
    
            return response()->json([
                'message' => 'Success Update!',
                'order' => $singleOrderFromDB,
                
            ],200);
        }
        else{
            return  response()->json([
                'message' => 'Not Found this order!'
            ], 401);
        }
        
    }
    public function isComplete($orderId){
        $getOrder=Order::find($orderId);
        if(!$getOrder){
            return  response()->json([
                'message' => 'Not Found This Order!'
            ], 401);
        }

        $newStatus = $getOrder->done ? '0' : '1';
        // Update the employee's status
        $getOrder->update([
            'done' => $newStatus,
        ]);
        return response()->json([
            'message' => 'success update!',
            'orders' => Order::all(),
            
        ],200);
    }
    public function destroy($orderId)
    {
        $order = Order::find($orderId);
        if($order!=null){
            $order->delete($orderId);
            return response()->json([
                'message' => 'Success Delete This Order!',
                'orders' =>Order::all(),
                
            ],200);
            }
            return  response()->json([
                'message' => 'Not Found this order!'
            ], 401);
        }
}
