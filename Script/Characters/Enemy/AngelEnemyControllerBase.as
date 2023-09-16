class AAngelEnemyControllerBase : AAIController
{
    UNavigationSystemV1 NavArea;
    FVector RandomLocation;
    FVector TargetLocation;
    

    UAITask_MoveTo EnemyTask_MoveTo;


    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        NavArea = UNavigationSystemV1::GetNavigationSystem();
        RandomPatrol();
    }
    
    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
    }

    UFUNCTION()
    void RandomPatrol()
    {
        UpdateRandomPatrolPoint();
//        Print("PatrolStart");
        TargetLocation = RandomLocation;
        MoveToLocation(TargetLocation);       
    }

    UFUNCTION()
    void UpdateRandomPatrolPoint()
    {
        UNavigationSystemV1::GetRandomReachablePointInRadius(GetControlledPawn().GetActorLocation(),RandomLocation, 15000.0f);
    }



}