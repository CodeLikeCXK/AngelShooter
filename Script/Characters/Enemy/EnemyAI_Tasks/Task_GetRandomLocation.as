UCLASS()
class UTask_GetRandomLocation: UBTTask_BlueprintBase
{
    default NodeName = "UTask_GetRandomLocation_CPP";

    UNavigationSystemV1 NavArea;
    FVector RandomPatrolLocation;
    UBlackboardComponent OwnerComp;

    // Called whenever this Task is first executed by the Behavior Tree
	UFUNCTION(BlueprintOverride)
	void ExecuteAI(AAIController OwnerController, APawn ControlledPawn)
    {
        NavArea = UNavigationSystemV1::GetNavigationSystem();
        if(NavArea != nullptr)
        {
            UNavigationSystemV1::GetRandomReachablePointInRadius(ControlledPawn.GetActorLocation(),RandomPatrolLocation, 15000.0f);
        }
        else
        {
            EBTNodeResult::Failed;
            FinishExecute(false); 

        }

        AIHelper::GetBlackboard(OwnerController).SetValueAsVector(FName("Random Patrol Location"), RandomPatrolLocation);
        EBTNodeResult::Succeeded;
        FinishExecute(true); 
    }

}