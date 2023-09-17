class AAngelEnemyControllerBase : AAIController
{
    UNavigationSystemV1 NavArea;
    FVector RandomLocation;
    FVector TargetLocation;
    

    UAITask_MoveTo EnemyTask_MoveTo;

    UPROPERTY(EditAnywhere, BlueprintReadWrite)
	UBehaviorTree BehaviorTree;

    
    UPROPERTY(EditAnywhere)
	float StoppingDistance = 100.0f;

    
    UPROPERTY(EditAnywhere)
	float AttackRange = 10.0f;

    APawn player;

    UPROPERTY(EditAnywhere)
    bool PlayerDetected;

    UPROPERTY(EditAnywhere)
    bool CanAttackPlayer; 



    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        NavArea = UNavigationSystemV1::GetNavigationSystem();
        RandomPatrol();
        player = Gameplay::GetPlayerPawn(0);

        ReceiveMoveCompleted.AddUFunction(this,n"OnAIMoveCompleted");


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

    UFUNCTION()
    void MoveToPlayer()
    {
        MoveToLocation(player.GetActorLocation(), StoppingDistance, true);
    }

    UFUNCTION()
    void SeekPlayer()
    {
        MoveToPlayer();
        System::SetTimer(this,n"SeekPlayer",0.25f,true);
    }    

    UFUNCTION()
    void StopSeekingPlayer()
    {
        System::ClearTimer(this,"SeekPlayer");
    }

        UFUNCTION()
    void OnAIMoveCompleted(FAIRequestID RequestID, EPathFollowingResult Result)
    {
      //   Print("Reach!");
      if(!PlayerDetected)
      {
        RandomPatrol();
      }
      else if (PlayerDetected && CanAttackPlayer)
      {
        StopSeekingPlayer();
        MoveToLocation(player.GetActorLocation(), AttackRange, true);
      }
    }

    


}